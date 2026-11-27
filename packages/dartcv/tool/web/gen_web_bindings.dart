// Copyright (c) 2025, Rainyl. All rights reserved. Use of this source code is governed by a
// Apache 2.0 license that can be found in the LICENSE file.

// Generates lib/src/web/g/*.g.dart from the ffigen output in lib/src/g/*.g.dart.
//
//   dart run tool/web/gen_web_bindings.dart   (from packages/dartcv, after tool/ffigen.dart)
//
// The web files keep every Dart name and signature of the native ones, so the hand-written code
// compiles against either. What changes:
//   * `@ffi.Native` externals become wrappers that call the Emscripten export `_<symbol>`,
//     lowering arguments with the wasm32 C ABI (clang): a struct whose fields flatten to a single
//     scalar is passed/returned as that scalar, any other struct is passed as a pointer to a
//     copy and returned through a hidden first sret pointer.
//   * structs/unions get explicit wasm32 layouts (getters/setters at fixed offsets).
//   * `addresses` hands out wasm table indices (Emscripten addFunction).
//   * native function typedefs register their wasm signature, for NativeCallable.
//
// It also owns `lib/src/bindings/<module>.dart`, the per-module facade that picks native or web, so
// the `dart.library.js_interop` switch exists once per module rather than in every file that imports
// the bindings.
// ignore_for_file: avoid_print

import 'dart:io';

/// Modules whose generated file is plain Dart: no `ffi.Native` declarations, no struct layouts,
/// nothing that differs between native and wasm. `constants.g.dart` is nothing but `const int`s, so
/// the native file is shared by both platforms (`dart tool/ffigen.dart` drops its unused `dart:ffi`
/// import) and no web mirror is generated for it.
const _platformIndependent = {'constants.g.dart'};

/// Regenerates `lib/src/web/g/*.g.dart` (and `register.g.dart`) from the ffigen output in
/// `lib/src/g`, for the package rooted at [packageDir].
///
/// Call this after the native bindings are written - `tool/ffigen.dart` does, so `dart
/// tool/ffigen.dart` refreshes both mirrors in one go. Standalone (`dart
/// tool/web/gen_web_bindings.dart`) it only needs the `lib/src/g` files on disk, which is what CI
/// uses for its freshness check.
///
/// With [check] nothing is written: the files are generated into a temp directory and compared
/// with the checked-in ones, and a [StateError] lists everything that is missing, stale or
/// different (so CI can fail without touching the working tree).
void generateWebBindings({required Directory packageDir, bool format = true, bool check = false}) {
  final inDir = Directory('${packageDir.path}/lib/src/g');
  // Not created in check mode: nothing is written there.
  final outDir = check
      ? Directory('${packageDir.path}/lib/src/web/g')
      : (Directory('${packageDir.path}/lib/src/web/g')..createSync(recursive: true));

  final files = inDir.listSync().whereType<File>().where((f) => f.path.endsWith('.g.dart')).toList()
    ..sort((a, b) => a.path.compareTo(b.path));
  final units = <String, Unit>{};
  for (final f in files) {
    final name = f.uri.pathSegments.last;
    if (name.contains('record_use_mapping') || _platformIndependent.contains(name)) continue;
    units[name] = Unit.parse(name, f.readAsStringSync());
  }
  final world = World(units);

  final expected = <String, String>{};
  var count = 0;
  for (final u in units.values) {
    expected[u.name] = u.emit(world);
    count += u.functions.length;
  }
  // One entry point that registers every file's layouts and callback signatures.
  final reg = StringBuffer()
    ..writeln(_header)
    ..writeln("// ignore_for_file: type=lint, unused_import");
  for (final u in units.values) {
    reg.writeln("import '${u.name}' as ${u.alias};");
  }
  reg.writeln('\nvoid registerAll() {');
  for (final u in units.values) {
    reg.writeln('  ${u.alias}.\$registerTypes();');
  }
  reg.writeln('}');
  expected['register.g.dart'] = reg.toString();

  // One facade per module: the conditional export the hand-written code imports instead of naming a
  // `g/` file.
  final facadeDir = check
      ? Directory('${packageDir.path}/lib/src/bindings')
      : (Directory('${packageDir.path}/lib/src/bindings')..createSync(recursive: true));
  final facades = <String, String>{
    for (final u in units.values) '${u.name.replaceAll('.g.dart', '')}.dart': _facade(u.name),
  };

  // The package version, for the handshake `initDartcv()` does with the module it loads: the build
  // tool stamps the module with the same string (`export const dartcvVersion`).
  final pubspec = File('${packageDir.path}/pubspec.yaml').readAsStringSync();
  final version = RegExp(r'^version: *(.+)$', multiLine: true).firstMatch(pubspec)?.group(1)?.trim();
  if (version == null || version.isEmpty) {
    throw StateError('no `version:` in ${packageDir.path}/pubspec.yaml');
  }
  final versionFile = <String, String>{'package_version.dart': _packageVersion(version)};
  final versionDir = Directory('${packageDir.path}/lib/src');

  if (check) {
    _checkGeneratedFiles(outDir, expected, format: format, suffix: '.g.dart', what: 'lib/src/web/g');
    _checkGeneratedFiles(facadeDir, facades, format: format, suffix: '.dart', what: 'lib/src/bindings');
    _checkGeneratedFiles(
      versionDir,
      versionFile,
      format: format,
      suffix: 'package_version.dart',
      what: 'lib/src/package_version.dart',
    );
    print('lib/src/web/g and lib/src/bindings are up to date (${units.length} files, $count functions)');
    return;
  }

  for (final e in expected.entries) {
    File('${outDir.path}/${e.key}').writeAsStringSync(e.value);
  }
  // A module dropped from tool/ffigen.dart's list leaves its mirror behind otherwise.
  for (final f in outDir.listSync().whereType<File>()) {
    final name = f.uri.pathSegments.last;
    if (name.endsWith('.g.dart') && !expected.containsKey(name)) {
      f.deleteSync();
      print('removed stale ${f.path}');
    }
  }
  for (final e in facades.entries) {
    File('${facadeDir.path}/${e.key}').writeAsStringSync(e.value);
  }
  // A module dropped from tool/ffigen.dart's list leaves its facade behind otherwise, like its mirror.
  for (final f in facadeDir.listSync().whereType<File>()) {
    final name = f.uri.pathSegments.last;
    if (name.endsWith('.dart') && !facades.containsKey(name)) {
      f.deleteSync();
      print('removed stale ${f.path}');
    }
  }
  if (format) {
    _format(outDir);
    _format(facadeDir);
  }
  for (final e in versionFile.entries) {
    File('${versionDir.path}/${e.key}').writeAsStringSync(e.value);
  }
  print('wrote ${units.length} files, $count functions to ${outDir.path}');
  print('wrote ${units.length} facades to ${facadeDir.path}');
  print('wrote ${versionFile.keys.single} ($version) to ${versionDir.path}');
}

/// `lib/src/package_version.dart`: the version the module is stamped with at build time.
String _packageVersion(String version) =>
    '''
// AUTO GENERATED FILE, DO NOT EDIT.
//
// Generated by `tool/web/gen_web_bindings.dart` from the `version:` of pubspec.yaml.
//
// The web build stamps the module with the same string (`export const dartcvVersion = ...`) and
// `initDartcv()` refuses a module that reports a different one, so a full-page reload cannot end up
// running a `dartcv.js` from another release against these bindings.
const packageVersion = '$version';
''';

/// `lib/src/bindings/<module>.dart`: the conditional export the hand-written code imports.
String _facade(String mirror) {
  final module = mirror.replaceAll('.g.dart', '');
  return '''
// AUTO GENERATED FILE, DO NOT EDIT.
//
// Generated by `tool/web/gen_web_bindings.dart`, like the mirror it selects.
//
// The one place that decides which bindings this platform uses: the hand-written code imports this
// facade, never `lib/src/g/$module.g.dart` or `lib/src/web/g/$module.g.dart` directly, so the
// `dart.library.js_interop` switch exists once per module instead of in every file that needs it.
export '../g/$module.g.dart' if (dart.library.js_interop) '../web/g/$module.g.dart';
''';
}

void _format(Directory dir) {
  // Every setting is passed explicitly instead of relying on the package's analysis_options.yaml,
  // so that the `--check` comparison in a temp directory formats exactly like the real run:
  //   * line length and trailing commas mirror `packages/dartcv/analysis_options.yaml`,
  //   * the language version is pinned, or `dart format` would fall back to the old short style
  //     when no package config is resolved (e.g. in CI before `pub get`).
  final fmt = Process.runSync(Platform.resolvedExecutable, [
    'format',
    '--line-length',
    '110',
    '--trailing-commas',
    'preserve',
    '--language-version',
    '3.10',
    dir.path,
  ]);
  if (fmt.exitCode != 0) throw StateError('dart format failed: ${fmt.stderr}');
}

/// Line endings are not content here: `dart format` keeps whatever the file already used, and a
/// Windows checkout with `core.autocrlf=true` rewrites every file to CRLF.
String _withoutCrlf(String s) => s.replaceAll('\r\n', '\n');

/// Formats [expected] into a temp directory and compares it with [outDir] without writing there.
void _checkGeneratedFiles(
  Directory outDir,
  Map<String, String> expected, {
  required bool format,
  required String suffix,
  required String what,
}) {
  final tmp = Directory.systemTemp.createTempSync('dartcv_web_g_check_');
  final problems = <String>[];
  try {
    for (final e in expected.entries) {
      File('${tmp.path}/${e.key}').writeAsStringSync(e.value);
    }
    if (format) _format(tmp);
    for (final e in expected.entries) {
      final onDisk = File('${outDir.path}/${e.key}');
      if (!onDisk.existsSync()) {
        problems.add('missing   ${e.key}');
      } else if (_withoutCrlf(onDisk.readAsStringSync()) !=
          _withoutCrlf(File('${tmp.path}/${e.key}').readAsStringSync())) {
        problems.add('differs   ${e.key}');
      }
    }
    if (outDir.existsSync()) {
      for (final f in outDir.listSync().whereType<File>()) {
        final name = f.uri.pathSegments.last;
        if (name.endsWith(suffix) && !expected.containsKey(name)) problems.add('stale     $name');
      }
    }
  } finally {
    tmp.deleteSync(recursive: true);
  }
  if (problems.isNotEmpty) {
    throw StateError(
      '$what is out of date, run `dart tool/ffigen.dart` (or `dart tool/web/gen_web_bindings.dart`):\n'
      '  ${problems.join('\n  ')}',
    );
  }
}

void main(List<String> args) {
  final pkg = File.fromUri(Platform.script).parent.parent.parent;
  generateWebBindings(packageDir: pkg, check: args.contains('--check'));
}

const _header = '''
// AUTO GENERATED FILE, DO NOT EDIT.
//
// Generated by `tool/web/gen_web_bindings.dart` from the ffigen output in lib/src/g.''';

// ---------------------------------------------------------------- parsing

/// Splits a Dart file into top-level declarations (good enough for formatted ffigen output).
///
/// A doc comment between two declarations stays attached to the declaration that follows it, so the
/// web bindings keep the documentation of the native ones. The file header itself (everything before
/// the first declaration) is dropped: the web files have their own.
List<String> splitTopLevel(String src) {
  final out = <String>[];
  var depth = 0, start = -1;
  var i = 0;
  while (i < src.length) {
    final c = src[i];
    if (c == '/' && i + 1 < src.length && src[i + 1] == '/') {
      // In the file header (nothing emitted yet): nothing to attach the comment to.
      if (depth == 0 && start < 0 && out.isEmpty) {
        i = src.indexOf('\n', i);
        if (i < 0) break;
        continue;
      }
      if (depth == 0 && start < 0) start = i;
      i = src.indexOf('\n', i);
      if (i < 0) break;
      continue;
    }
    if (depth == 0 && start < 0) {
      if (c.trim().isEmpty) {
        i++;
        continue;
      }
      start = i;
    }
    if (c == "'" || c == '"') {
      final end = src.indexOf(c, i + 1);
      i = end + 1;
      continue;
    }
    if (c == '(' || c == '{' || c == '[') depth++;
    if (c == ')' || c == ']') depth--;
    if (c == '}') {
      depth--;
      if (depth == 0) {
        out.add(src.substring(start, i + 1));
        start = -1;
        i++;
        continue;
      }
    }
    if (c == ';' && depth == 0) {
      out.add(src.substring(start, i + 1));
      start = -1;
    }
    i++;
  }
  return out;
}

/// Splits [s] on top-level commas (ignoring <>, () and [] nesting); drops empty trailing parts.
List<String> splitArgs(String s) {
  final out = <String>[];
  var depth = 0, start = 0;
  for (var i = 0; i < s.length; i++) {
    final c = s[i];
    if ('<([{'.contains(c)) depth++;
    if ('>)]}'.contains(c)) depth--;
    if (c == ',' && depth == 0) {
      out.add(s.substring(start, i).trim());
      start = i + 1;
    }
  }
  out.add(s.substring(start).trim());
  return out.where((e) => e.isNotEmpty).toList();
}

String norm(String s) => s.replaceAll(RegExp(r'\s+'), ' ').replaceAll('< ', '<').replaceAll(' >', '>').trim();

/// Splits a leading doc-comment block off a declaration chunk: `(comment, declaration)`.
(String, String) splitDoc(String chunk) {
  final lines = chunk.split('\n');
  var k = 0;
  while (k < lines.length && lines[k].trimLeft().startsWith('//')) {
    k++;
  }
  if (k == 0) return ('', chunk);
  // Blank lines between the comment and the declaration belong to neither.
  var end = k;
  while (end > 0 && lines[end - 1].trim().isEmpty) {
    end--;
  }
  return (lines.sublist(0, end).join('\n'), lines.sublist(end).join('\n').trimLeft());
}

class Field {
  Field(this.name, this.type, this.annotation, this.arrayLen);
  final String name;
  final String type; // Dart field type as written
  final String? annotation; // e.g. ffi.Int, ushort
  final int? arrayLen;
}

class StructDecl {
  StructDecl(this.name, this.isUnion, this.fields, this.rest, this.doc);
  final String doc; // leading doc comment, already re-indented for the emitted file
  final String name;
  final bool isUnion;
  final List<Field> fields;
  final String rest; // other members ($allocate), copied verbatim
}

class FunctionDecl {
  FunctionDecl(this.name, this.nativeRet, this.nativeParams, this.dartRet, this.dartParams, this.doc);
  final String doc; // leading doc comment
  final String name;
  final String nativeRet;
  final List<String> nativeParams;
  final String dartRet;
  final List<(String type, String name)> dartParams;
}

class Unit {
  Unit(this.name);
  final String name;
  String get alias => '\$${name.replaceAll('.g.dart', '')}';
  final imports = <String, String>{}; // prefix -> file name (g files only)
  final typedefs = <String, String>{}; // name -> aliased type (normalized)
  final typedefSrc = <String>[];
  final structs = <String, StructDecl>{};
  final functions = <FunctionDecl>[];
  final verbatim = <String>[];

  static Unit parse(String name, String src) {
    final u = Unit(name);
    for (final chunk in splitTopLevel(src)) {
      final (doc, d) = splitDoc(chunk);
      if (d.startsWith('import ')) {
        final m = RegExp(r"import 'package:dartcv4/src/g/([\w.]+)' as ([\w$]+);").firstMatch(d);
        if (m != null) u.imports[m.group(2)!] = m.group(1)!;
        continue;
      }
      if (d.startsWith('typedef ')) {
        final m = RegExp(r'^typedef (\w+) =\s*([\s\S]*);$').firstMatch(d)!;
        u.typedefs[m.group(1)!] = norm(m.group(2)!);
        u.typedefSrc.add(doc.isEmpty ? d : '$doc\n$d');
        continue;
      }
      final cm = RegExp(r'^(?:final )?class (\w+) extends ffi\.(Struct|Union) \{([\s\S]*)\}$').firstMatch(d);
      if (cm != null) {
        u.structs[cm.group(1)!] = _parseStruct(cm.group(1)!, cm.group(2) == 'Union', cm.group(3)!, doc);
        continue;
      }
      if (d.contains('library;')) continue;
      if (d.startsWith('const addresses') || d.startsWith('class _SymbolAddresses')) continue;
      final global = RegExp(r'external (\w+) (\w+);$').firstMatch(d);
      if (d.contains('@ffi.Native<') && global != null) {
        // C global variable: not exported by the wasm build.
        final (t, n) = (global.group(1)!, global.group(2)!);
        final stub =
            "$t get $n => throw UnsupportedError('$n is not available on the web');\n"
            "set $n($t v) => throw UnsupportedError('$n is not available on the web');";
        u.verbatim.add(doc.isEmpty ? stub : '$doc\n$stub');
        continue;
      }
      if (d.contains('@ffi.Native<')) {
        u.functions.add(_parseFunction(d, doc));
        continue;
      }
      u.verbatim.add(doc.isEmpty ? d : '$doc\n$d');
    }
    return u;
  }

  static StructDecl _parseStruct(String name, bool isUnion, String body, String doc) {
    final fields = <Field>[];
    final re = RegExp(r'((?:@[^\n]+\n\s*)*)external ([^;]+?) (\w+);');
    for (final m in re.allMatches(body)) {
      final ann = m.group(1)!.trim();
      String? annotation;
      int? arrayLen;
      for (final a in RegExp(r'@([\w.]+)\(([^)]*)\)').allMatches(ann)) {
        if (a.group(1) == 'ffi.Array.multi') {
          arrayLen = int.parse(RegExp(r'\d+').firstMatch(a.group(2)!)!.group(0)!);
        } else {
          annotation = a.group(1);
        }
      }
      fields.add(Field(m.group(3)!, norm(m.group(2)!), annotation, arrayLen));
    }
    final rest = body.replaceAll(re, '').trim();
    return StructDecl(name, isUnion, fields, rest, doc);
  }

  static FunctionDecl _parseFunction(String d, String doc) {
    final start = d.indexOf('@ffi.Native<') + '@ffi.Native<'.length;
    var depth = 1, i = start;
    for (; i < d.length; i++) {
      if (d[i] == '<') depth++;
      if (d[i] == '>') {
        depth--;
        if (depth == 0) break;
      }
    }
    final nativeType = norm(d.substring(start, i));
    final (nRet, nParams) = splitFunctionType(nativeType);
    final ext = RegExp(r'external ([\s\S]+?) (\w+)\(([\s\S]*)\);$').firstMatch(d)!;
    final params = [
      for (final p in splitArgs(ext.group(3)!))
        (norm(p.substring(0, p.lastIndexOf(RegExp(r'\s')))), p.substring(p.lastIndexOf(RegExp(r'\s')) + 1)),
    ];
    return FunctionDecl(ext.group(2)!, nRet, nParams, norm(ext.group(1)!), params, doc);
  }

  String emit(World w) {
    final b = StringBuffer()
      ..writeln(_header)
      ..writeln('// ignore_for_file: type=lint, unused_import, unused_element, unused_local_variable')
      ..writeln("import 'dart:typed_data';\n")
      ..writeln("import 'package:dartcv4/src/web/ffi.dart' as ffi;")
      ..writeln(r"import 'package:dartcv4/src/web/runtime.dart' as $rt;");
    for (final e in imports.entries) {
      b.writeln("import 'package:dartcv4/src/web/g/${e.value}' as ${e.key};");
    }
    b.writeln();
    for (final v in verbatim) {
      b
        ..writeln(v.replaceAll("import 'dart:ffi' as ffi;", ''))
        ..writeln();
    }
    for (final t in typedefSrc) {
      b
        ..writeln(t)
        ..writeln();
    }
    for (final s in structs.values) {
      b.writeln(w.emitStruct(this, s));
    }
    for (final f in functions) {
      b.writeln(w.emitFunction(this, f));
    }
    // addresses
    final freeFns = functions.where((f) => f.nativeRet == 'ffi.Void' && f.nativeParams.length == 1).toList();
    if (functions.isNotEmpty) {
      b
        ..writeln('const addresses = _SymbolAddresses();\n')
        ..writeln('class _SymbolAddresses {')
        ..writeln('  const _SymbolAddresses();');
      for (final f in freeFns) {
        final sig = w.wasmSig(this, f);
        b.writeln(
          '  ffi.Pointer<ffi.NativeFunction<${f.nativeRet} Function(${f.nativeParams.join(', ')})>> get ${f.name} =>'
          " ffi.Pointer.fromAddress(\$rt.addressOf('${f.name}', '$sig'));",
        );
      }
      b.writeln('}\n');
    }
    // registration
    b.writeln(r'void $registerTypes() {');
    for (final s in structs.values) {
      final l = w.layout(this, s.name);
      b.writeln('  ffi.\$registerStruct<${s.name}>(${l.size}, ${l.align}, ${s.name}.\$view);');
    }
    for (final e in typedefs.entries) {
      final cb = w.callbackSig(this, e.value);
      if (cb == null) continue;
      // A callback parameter is a reified `Pointer<X>` and dart2js checks it on entry to the closure,
      // so the shim cannot hand it its generic `Pointer<Void>`: register the pointee builders too.
      final pointers = cb.$3.any((p) => p != null)
          ? ', <Object? Function(int)?>[${cb.$3.map((p) => p ?? 'null').join(', ')}]'
          : '';
      b.writeln("  \$rt.registerCallback(${e.key}, '${cb.$1}', '${cb.$2}'$pointers);");
    }
    b.writeln('}');
    return b.toString();
  }
}

bool _balanced(String s) =>
    '<'.allMatches(s).length == '>'.allMatches(s).length &&
    '('.allMatches(s).length == ')'.allMatches(s).length;

(String, List<String>) splitFunctionType(String t) {
  final idx = t.indexOf(' Function(');
  final ret = t.substring(0, idx).trim();
  final args = t.substring(idx + ' Function('.length, t.lastIndexOf(')'));
  return (ret, splitArgs(args));
}

// ---------------------------------------------------------------- type model

/// Scalar kinds: i (signed i32), u (unsigned i32), b (bool), f (f32), d (f64), j (i64), J (u64), p (pointer).
const _prim = {
  'Int': 'i', 'Int32': 'i', 'Long': 'i', 'IntPtr': 'i', 'WChar': 'i', //
  'Short': 'i16', 'Int16': 'i16', 'Char': 'i8', 'Int8': 'i8', 'SignedChar': 'i8',
  'Uint32': 'u', 'UnsignedInt': 'u', 'UnsignedLong': 'u', 'Size': 'u', 'UintPtr': 'u',
  'Uint16': 'u16', 'UnsignedShort': 'u16', 'Uint8': 'u8', 'UnsignedChar': 'u8',
  'Bool': 'b', 'Float': 'f', 'Double': 'd',
  'Int64': 'j', 'LongLong': 'j', 'Uint64': 'J', 'UnsignedLongLong': 'J',
  'Void': 'v',
};

const _sizes = {
  'i': 4,
  'u': 4,
  'i16': 2,
  'u16': 2,
  'i8': 1,
  'u8': 1,
  'b': 1,
  'f': 4,
  'd': 8,
  'j': 8,
  'J': 8,
  'p': 4,
};

class UnresolvedType implements Exception {
  UnresolvedType(this.message);
  final String message;

  @override
  String toString() => message;
}

class Layout {
  Layout(this.size, this.align, this.offsets);
  final int size, align;
  final List<int> offsets;
}

/// A resolved type: a scalar kind, or a struct (unit + name).
class TypeRef {
  TypeRef.scalar(this.kind) : unit = null, struct = null;
  TypeRef.struct(this.unit, this.struct) : kind = 'S';
  final String kind;
  final Unit? unit;
  final String? struct;
}

class World {
  World(this.units);
  final Map<String, Unit> units;
  final _layouts = <String, Layout>{};

  TypeRef resolve(Unit u, String type) {
    final t = norm(type);
    if (t.startsWith('ffi.Pointer<')) return TypeRef.scalar('p');
    if (t.startsWith('ffi.')) {
      final k = _prim[t.substring(4)];
      if (k == null) throw UnresolvedType('unknown ffi type $t in ${u.name}');
      return TypeRef.scalar(k);
    }
    final dot = t.indexOf('.');
    if (dot > 0) {
      final target = units[u.imports[t.substring(0, dot)]]!;
      return resolve(target, t.substring(dot + 1));
    }
    if (u.structs.containsKey(t)) return TypeRef.struct(u, t);
    final alias = u.typedefs[t];
    if (alias != null) return resolve(u, alias);
    throw UnresolvedType('cannot resolve $t in ${u.name}');
  }

  /// The type of [f]: the `@ffi.*()` annotation when the field is a plain scalar (ffigen writes the
  /// element type there), the declared type otherwise. Both are resolved as written.
  TypeRef fieldType(Unit u, Field f) =>
      f.annotation != null && f.arrayLen == null ? resolve(u, f.annotation!) : resolve(u, f.type);

  Layout layout(Unit u, String name) => _layouts.putIfAbsent('${u.name}:$name', () {
    final s = u.structs[name]!;
    var off = 0, align = 1;
    final offsets = <int>[];
    for (final f in s.fields) {
      final int fs, fa;
      if (f.arrayLen != null) {
        final elem = arrayElement(u, f);
        if (elem.kind == 'S') {
          final l = layout(elem.unit!, elem.struct!);
          fa = l.align;
          fs = l.size * f.arrayLen!;
        } else {
          fa = _sizes[elem.kind]!;
          fs = fa * f.arrayLen!;
        }
      } else {
        final t = fieldType(u, f);
        if (t.kind == 'S') {
          final l = layout(t.unit!, t.struct!);
          fs = l.size;
          fa = l.align;
        } else {
          fs = fa = _sizes[t.kind]!;
        }
      }
      if (fa > align) align = fa;
      if (s.isUnion) {
        offsets.add(0);
        if (fs > off) off = fs;
      } else {
        off = (off + fa - 1) ~/ fa * fa;
        offsets.add(off);
        off += fs;
      }
    }
    final size = (off + align - 1) ~/ align * align;
    return Layout(size, align, offsets);
  });

  /// The element type of an `ffi.Array<...>` field.
  TypeRef arrayElement(Unit u, Field f) {
    final m = RegExp(r'ffi\.Array<(.+)>').firstMatch(f.type);
    if (m == null) {
      throw UnresolvedType('cannot read the element type of ${f.type} (${u.name}.${f.name})');
    }
    return resolve(u, m.group(1)!);
  }

  /// Flattens a struct to scalar leaves: (dart access path, kind).
  ///
  /// Only used for values passed or returned by value, where the wasm32 C ABI passes a struct that
  /// flattens to a single scalar in a register. Anything this cannot represent faithfully throws,
  /// so a new binding fails generation instead of producing a wrapper that reads the wrong bytes.
  List<(String, String)> leaves(Unit u, String name) {
    final s = u.structs[name]!;
    final out = <(String, String)>[];
    if (s.isUnion && s.fields.length > 1) {
      throw UnresolvedType(
        '${u.name}: union ${s.name} has ${s.fields.length} overlapping members, it cannot be passed '
        'or returned by value',
      );
    }
    for (final f in s.fields) {
      if (f.arrayLen != null) {
        final elem = arrayElement(u, f);
        if (elem.kind == 'S') {
          throw UnresolvedType(
            '${u.name}.${s.name}.${f.name}: arrays of structs cannot be passed or returned by value',
          );
        }
        // One leaf per element, with the element's own kind (not a blanket u32).
        for (var k = 0; k < f.arrayLen!; k++) {
          out.add(('${f.name}[$k]', elem.kind));
        }
        continue;
      }
      final t = fieldType(u, f);
      if (t.kind == 'S') {
        for (final (p, k) in leaves(t.unit!, t.struct!)) {
          out.add(('${f.name}.$p', k));
        }
      } else {
        out.add((f.name, t.kind));
      }
    }
    return out;
  }

  String _wasmChar(String kind) => switch (kind) {
    'f' => 'f',
    'd' => 'd',
    'j' || 'J' => 'j',
    'v' => 'v',
    _ => 'i',
  };

  String wasmSig(Unit u, FunctionDecl f) {
    final r = resolve(u, f.nativeRet);
    final sb = StringBuffer();
    final params = StringBuffer();
    var sret = false;
    if (r.kind == 'S') {
      final l = leaves(r.unit!, r.struct!);
      if (l.length == 1) {
        sb.write(_wasmChar(l.single.$2));
      } else {
        sb.write('v');
        sret = true;
      }
    } else {
      sb.write(_wasmChar(r.kind));
    }
    if (sret) params.write('i');
    for (final p in f.nativeParams) {
      final t = resolve(u, p);
      if (t.kind == 'S') {
        final l = leaves(t.unit!, t.struct!);
        params.write(l.length == 1 ? _wasmChar(l.single.$2) : 'i');
      } else {
        params.write(_wasmChar(t.kind));
      }
    }
    return '$sb$params';
  }

  /// The expression that rebuilds `Pointer<X>` (as written in [u]) inside [u]'s own emitted file.
  ///
  /// Returns `null` when `X` is `ffi.Void` (the shim's generic pointer already matches) and
  /// `(null, false)` when `X` cannot be spelled there - another module's type, because the emitted
  /// files import nothing but the shim. That case is a bug in waiting: the shim would hand the
  /// closure a `Pointer<Void>`, which dart2js refuses for a reified `Pointer<X>` parameter, so the
  /// caller reports it instead of letting the browser find out.
  (String?, bool) pointerBuilder(Unit u, String type) {
    final t = norm(type);
    if (!t.startsWith('ffi.Pointer<')) return (null, true);
    final inner = norm(t.substring('ffi.Pointer<'.length, t.length - 1));
    if (inner == 'ffi.Void' || inner == 'Void') return (null, true);
    final visible = inner.startsWith('ffi.')
        ? inner
        : (inner.contains('.') || !(u.structs.containsKey(inner) || u.typedefs.containsKey(inner)))
        ? null
        : inner;
    if (visible == null) return (null, false);
    return ('(a) => ffi.Pointer<$visible>.fromAddress(a)', true);
  }

  /// For a native function typedef (`ffi.X Function(...)`): (wasm signature, argument kinds, and per
  /// argument the expression that rebuilds a pointer with the pointee type the callback declares).
  (String, String, List<String?>)? callbackSig(Unit u, String alias) {
    if (!alias.contains(' Function(') || alias.startsWith('ffi.Pointer<')) return null;
    final (ret, params) = splitFunctionType(alias);
    if (!ret.startsWith('ffi.') && !u.typedefs.containsKey(ret)) return null;
    try {
      final r = resolve(u, ret);
      if (r.kind == 'S') return null;
      final kinds = StringBuffer();
      final pointers = <String?>[];
      final sig = StringBuffer(_wasmChar(r.kind));
      for (final p in params) {
        final named = RegExp(r'^(.*[>\w])\s+(\w+)$').firstMatch(p);
        final type = named != null && _balanced(named.group(1)!) ? named.group(1)! : p;
        final t = resolve(u, type);
        if (t.kind == 'S') return null;
        sig.write(_wasmChar(t.kind));
        kinds.write(switch (t.kind) {
          'p' => 'p',
          'b' => 'b',
          'f' || 'd' => 'd',
          'j' || 'J' => 'j',
          'u' || 'u8' || 'u16' => 'u',
          _ => 'i',
        });
        if (t.kind == 'p') {
          final (builder, resolvable) = pointerBuilder(u, type);
          if (!resolvable) {
            stderr.writeln(
              'warning: ${u.name}: callback parameter `$type` has a pointee that is not visible in '
              '${u.name}.g.dart, so its wasm callback keeps a generic Pointer<Void> and dart2js will '
              'reject it at runtime; declare the pointee in the module that owns the typedef.',
            );
          }
          pointers.add(builder);
        } else {
          pointers.add(null);
        }
      }
      return (sig.toString(), kinds.toString(), pointers);
    } on UnresolvedType {
      return null;
    }
  }

  String emitStruct(Unit u, StructDecl s) {
    final l = layout(u, s.name);
    final base = s.isUnion ? 'ffi.Union' : 'ffi.Struct';
    final b = StringBuffer();
    if (s.doc.isNotEmpty) b.writeln(s.doc);
    b
      ..writeln('final class ${s.name} extends $base {')
      ..writeln('  ${s.name}.\$view(super.\$bytes, super.\$offset) : super.\$view();');
    for (var k = 0; k < s.fields.length; k++) {
      final f = s.fields[k];
      final o = l.offsets[k];
      if (f.arrayLen != null) {
        b.writeln(
          '  ${f.type} get ${f.name} => ffi.Array.\$view(\$bytes, \$offset + $o, ${f.arrayLen});',
        );
        continue;
      }
      final t = fieldType(u, f);
      if (t.kind == 'S') {
        final size = layout(t.unit!, t.struct!).size;
        b
          ..writeln('  ${f.type} get ${f.name} => ${f.type}.\$view(\$bytes, \$offset + $o);')
          ..writeln('  set ${f.name}(${f.type} v) => \$copyFrom($o, v, $size);');
        continue;
      }
      final (getter, setter) = switch (t.kind) {
        'p' => ('${f.type}.fromAddress(\$u32($o))', '\$su32($o, v.address)'),
        'b' => ('\$u8($o) != 0', '\$su8($o, v ? 1 : 0)'),
        'i' => ('\$i32($o)', '\$si32($o, v)'),
        'u' => ('\$u32($o)', '\$su32($o, v)'),
        'i16' => ('\$i16($o)', '\$si16($o, v)'),
        'u16' => ('\$u16($o)', '\$su16($o, v)'),
        'i8' => ('\$i8($o)', '\$si8($o, v)'),
        'u8' => ('\$u8($o)', '\$su8($o, v)'),
        'f' => ('\$f32($o)', '\$sf32($o, v)'),
        'd' => ('\$f64($o)', '\$sf64($o, v)'),
        'j' || 'J' => ('\$i64($o)', '\$si64($o, v)'),
        _ => throw StateError('field kind ${t.kind}'),
      };
      b
        ..writeln('  ${f.type} get ${f.name} => $getter;')
        ..writeln('  set ${f.name}(${f.type} v) => $setter;');
    }
    if (s.rest.isNotEmpty) b.writeln('  ${s.rest}');
    b.writeln('}');
    return b.toString();
  }

  String _toJs(String kind, String expr) => switch (kind) {
    'p' => '\$rt.i($expr.address)',
    'b' => '\$rt.b($expr)',
    'f' || 'd' => '\$rt.d($expr)',
    'j' || 'J' => '\$rt.j($expr)',
    _ => '\$rt.i($expr)',
  };

  String _fromJs(String kind, String dartType, String expr) => switch (kind) {
    'p' => '$dartType.fromAddress(\$rt.ru($expr))',
    'b' => '\$rt.rb($expr)',
    'f' || 'd' => '\$rt.rd($expr)',
    'j' || 'J' => '\$rt.rj($expr)',
    'u' || 'u8' || 'u16' => '\$rt.ru($expr)',
    _ => '\$rt.ri($expr)',
  };

  /// Dart type of a struct leaf, for the pointer case of _fromJs.
  ///
  /// [path] is a `leaves()` path, so a leaf may be indexed (`p[0]`); the index does not change the
  /// Dart type of the field.
  String _leafPointerType(Unit u, String struct, String path) {
    var unit = u;
    var name = struct;
    final parts = path.split('.');
    for (var k = 0; k < parts.length; k++) {
      final fieldName = parts[k].split('[').first;
      final fields = unit.structs[name]?.fields;
      final f = fields?.where((f) => f.name == fieldName).firstOrNull;
      if (f == null) {
        throw UnresolvedType('$name has no field "$fieldName" (leaf path "$path" of ${u.name})');
      }
      if (k == parts.length - 1) return f.type;
      final t = fieldType(unit, f);
      if (t.unit == null) {
        throw UnresolvedType('"$fieldName" of $name is not a struct (leaf path "$path" of ${u.name})');
      }
      unit = t.unit!;
      name = t.struct!;
    }
    throw UnresolvedType('empty leaf path for $struct in ${u.name}');
  }

  String emitFunction(Unit u, FunctionDecl f) {
    final b = StringBuffer();
    final params = f.dartParams.map((p) => '${p.$1} ${p.$2}').join(', ');
    if (f.doc.isNotEmpty) b.writeln(f.doc);
    b.writeln('${f.dartRet} ${f.name}($params) {');
    final args = <String>[];
    final temps = <(String, int)>[];
    final r = resolve(u, f.nativeRet);
    String? sretSize;
    if (r.kind == 'S' && leaves(r.unit!, r.struct!).length != 1) {
      final size = layout(r.unit!, r.struct!).size;
      sretSize = '$size';
      b.writeln('  final \$sret = \$rt.scratch($sretSize);');
      args.add(r'$rt.i($sret)');
      temps.add((r'$sret', size));
    }
    for (var k = 0; k < f.nativeParams.length; k++) {
      final t = resolve(u, f.nativeParams[k]);
      final name = f.dartParams[k].$2;
      if (t.kind == 'S') {
        final l = leaves(t.unit!, t.struct!);
        if (l.length == 1) {
          args.add(_toJs(l.single.$2, '$name.${l.single.$1}'));
        } else {
          final size = layout(t.unit!, t.struct!).size;
          b.writeln('  final \$t$k = ffi.\$copyToWasm(\$rt.scratch($size), $name, $size);');
          temps.add(('\$t$k', size));
          args.add('\$rt.i(\$t$k)');
        }
      } else {
        args.add(_toJs(t.kind, name));
      }
    }
    final callExpr = "\$rt.call('${f.name}', [${args.join(', ')}])";
    String result;
    if (r.kind == 'v') {
      result = '$callExpr;';
    } else if (r.kind == 'S') {
      final size = layout(r.unit!, r.struct!).size;
      if (sretSize != null) {
        result = '$callExpr;\n    return ${f.dartRet}.\$view(ffi.\$copyFromWasm(\$sret, $size), 0);';
      } else {
        final (path, kind) = leaves(r.unit!, r.struct!).single;
        final ptrType = kind == 'p' ? _leafPointerType(r.unit!, r.struct!, path) : '';
        result =
            'final \$v = $callExpr;\n'
            '    final \$s = ${f.dartRet}.\$view(ByteData($size), 0);\n'
            '    \$s.$path = ${_fromJs(kind, ptrType, r'$v')};\n'
            r'    return $s;';
      }
    } else {
      result = 'return ${_fromJs(r.kind, f.dartRet, callExpr)};';
    }
    if (temps.isEmpty) {
      b.writeln('  $result');
    } else {
      b
        ..writeln('  try {')
        ..writeln('    $result')
        ..writeln('  } finally {');
      for (final (t, size) in temps) {
        b.writeln('    \$rt.releaseScratch($t, $size);');
      }
      b.writeln('  }');
    }
    b.writeln('}');
    return b.toString();
  }
}
