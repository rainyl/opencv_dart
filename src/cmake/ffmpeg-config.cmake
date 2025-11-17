#[=======================================================================[.rst
FindFFMPEG
----------

FindModule for FFMPEG and associated libraries

.. versionchanged:: 3.0
  Updated FindModule to CMake standards

Components
^^^^^^^^^^

.. versionadded:: 1.0

This module contains provides several components:

``avcodec``
``avdevice``
``avfilter``
``avformat``
``avutil``
``postproc``
``swscale``
``swresample``

Import targets exist for each component.

Imported Targets
^^^^^^^^^^^^^^^^

.. versionadded:: 2.0

This module defines the :prop_tgt:`IMPORTED` targets:

``FFMPEG::avcodec``
  AVcodec component

``FFMPEG::avdevice``
  AVdevice component

``FFMPEG::avfilter``
  AVfilter component

``FFMPEG::avformat``
  AVformat component

``FFMPEG::avutil``
  AVutil component

``FFMPEG::postproc``
  postproc component

``FFMPEG::swscale``
  SWscale component

``FFMPEG::swresample``
  SWresample component

Result Variables
^^^^^^^^^^^^^^^^

This module sets the following variables:

``FFMPEG_FOUND``
  True, if all required components and the core library were found.
``FFMPEG_VERSION``
  Detected version of found FFMPEG libraries.
``FFMPEG_INCLUDE_DIRS``
  Include directories needed for FFMPEG.
``FFMPEG_LIBRARIES``
  Libraries needed to link to FFMPEG.
``FFMPEG_DEFINITIONS``
  Compiler flags required for FFMPEG.
``FFMPEG_LIB_PATHS``
  Paths of libraries

``FFMPEG_<COMPONENT>_VERSION``
  Detected version of found FFMPEG component library.
``FFMPEG_<COMPONENT>_INCLUDE_DIRS``
  Include directories needed for FFMPEG component.
``FFMPEG_<COMPONENT>_LIBRARIES``
  Libraries needed to link to FFMPEG component.
``FFMPEG_<COMPONENT>_DEFINITIONS``
  Compiler flags required for FFMPEG component.

Cache variables
^^^^^^^^^^^^^^^

The following cache variables may also be set:

``FFMPEG_<COMPONENT>_LIBRARY``
  Path to the library component of FFMPEG.
``FFMPEG_<COMPONENT>_INCLUDE_DIR``
  Directory containing ``<COMPONENT>.h``.

#]=======================================================================]

option(FFMPEG_USE_STATIC_LIBS "Use static libs (only for windows now)" ON)

include(FindPackageHandleStandardArgs)

if (NOT DEFINED FFMPEG_ROOT)
  get_filename_component(FFMPEG_ROOT "${CMAKE_CURRENT_LIST_DIR}/.." ABSOLUTE)
endif ()

# some builds have multiple architectures like `lib/arm64`
if (DEFINED FFMPEG_ARCH)
  # custom overridden values
elseif (MSVC)
  # see Modules/CMakeGenericSystem.cmake
  if ("${CMAKE_GENERATOR}" MATCHES "(Win64|IA64)")
    set(FFMPEG_ARCH "x64")
  elseif ("${CMAKE_GENERATOR_PLATFORM}" MATCHES "ARM64")
    set(FFMPEG_ARCH "ARM64")
  elseif ("${CMAKE_GENERATOR}" MATCHES "ARM")
    set(FFMPEG_ARCH "ARM")
  elseif ("${CMAKE_SIZEOF_VOID_P}" STREQUAL "8")
    set(FFMPEG_ARCH "x64")
  else ()
    set(FFMPEG_ARCH x86)
  endif ()
elseif (MINGW)
  if (CMAKE_SYSTEM_PROCESSOR MATCHES "amd64.*|x86_64.*|AMD64.*")
    set(FFMPEG_ARCH x64)
  else ()
    set(FFMPEG_ARCH x86)
  endif ()

  message(STATUS "FFMPEG_ARCH not defined, set to: ${FFMPEG_ARCH}")
endif ()

message(STATUS "FFMPEG_ROOT: ${FFMPEG_ROOT}")
message(STATUS "FFMPEG_ARCH: ${FFMPEG_ARCH}")

# https://stackoverflow.com/a/46057018/18539998
if (ANDROID)
  set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY BOTH)
  set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE BOTH)
  set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE BOTH)
endif ()

set(_DEFAULT_COMPONENTS
        avcodec
        avformat
        avutil
        swscale
        avdevice
        avfilter
        avresample
        postproc
        swresample
)

# set(FFMPEG_FIND_COMPONENTS
# avcodec
# avformat
# avutil
# swscale
# )
set(component_avcodec libavcodec avcodec avcodec.h)
set(component_avdevice libavdevice avdevice avdevice.h)
set(component_avformat libavformat avformat avformat.h)
set(component_avfilter libavfilter avfilter avfilter.h)
set(component_avresample libavresample avresample avresample.h)
set(component_avutil libavutil avutil avutil.h)
set(component_postproc libpostproc postproc postprocess.h)
set(component_swscale libswscale swscale swscale.h)
set(component_swresample libswresample swresample swresample.h)

if (NOT FFMPEG_FIND_COMPONENTS)
  set(FFMPEG_FIND_COMPONENTS ${_DEFAULT_COMPONENTS})
endif ()

set(FFMPEG_LIB_PATHS)

macro(ffmpeg_append_lib_path _path)
  if (IS_DIRECTORY "${_path}")
    # do nothing
  else ()
    list(APPEND FFMPEG_LIB_PATHS "${_path}")
  endif ()
endmacro()

# ffmpeg_find_component: Find and set up requested FFMPEG component
macro(ffmpeg_find_component component)
  list(GET component_${component} 0 component_libname)
  list(GET component_${component} 1 component_name)
  list(GET component_${component} 2 component_header)

  if (NOT CMAKE_HOST_SYSTEM_NAME MATCHES "Windows")
    find_package(PkgConfig)
    set(ENV{PKG_CONFIG_PATH} "$ENV{PKG_CONFIG_PATH}:${FFMPEG_ROOT}/lib/pkgconfig")

    if (PKG_CONFIG_FOUND)
      pkg_search_module(PC_FFMPEG_${component} QUIET ${component_libname})
    endif ()
  endif ()

  find_path(
          FFMPEG_${component}_INCLUDE_DIR
          NAMES ${component_libname}/${component_header} ${component_libname}/version.h
          PATHS
          "${FFMPEG_ROOT}/include"
          DOC "FFMPEG component ${component_name} include directory"
  )

  ffmpeg_check_version()

  message(DEBUG "[FindFFMPEG]: CMAKE_SYSTEM_NAME: ${CMAKE_SYSTEM_NAME}")

  if (CMAKE_SYSTEM_NAME MATCHES "Windows")
    find_library(
            FFMPEG_${component}_IMPLIB
            NAMES ${component_libname} ${component_name}
            HINTS ${FFMPEG_ROOT}/lib
            PATHS
            ${FFMPEG_ROOT}/lib/${FFMPEG_ARCH}
            DOC "FFMPEG component ${component_name} import library location"
    )

    if (FFMPEG_USE_STATIC_LIBS)
      set(FFMPEG_${component}_LIBRARY "${FFMPEG_${component}_IMPLIB}")
    else ()
      ffmpeg_find_dll()
    endif ()

  elseif (CMAKE_SYSTEM_NAME MATCHES "Linux|Darwin")
    # desktop platforms support bundled and system-wide ffmpeg
    find_library(
            FFMPEG_${component}_LIBRARY
            NAMES ${component_libname} ${component_name}
            HINTS ${PC_FFMPEG_${component}_LIBRARY_DIRS}
            PATHS
            "${FFMPEG_ROOT}/lib"
            "${FFMPEG_ROOT}/lib/${FFMPEG_ARCH}"
            "${FFMPEG_ROOT}/bin"
            "${FFMPEG_ROOT}/bin/${FFMPEG_ARCH}"
            DOC "FFMPEG component ${component_name} location"
    )
  elseif (CMAKE_SYSTEM_NAME MATCHES "Android")
    # for android, sometimes system-wide ffmpeg is installed
    # here, ignore all default paths, only include bundled libs
    find_library(
            FFMPEG_${component}_LIBRARY
            NAMES ${component_libname} ${component_name}
            PATHS
            "${FFMPEG_ROOT}/lib"
            "${FFMPEG_ROOT}/lib/${FFMPEG_ARCH}"
            "${FFMPEG_ROOT}/bin"
            "${FFMPEG_ROOT}/bin/${FFMPEG_ARCH}"
            NO_DEFAULT_PATH
            DOC "FFMPEG component ${component_name} location"
    )
  else ()
    # IOS not supported yet
    message(FATAL_ERROR "Unsupported platform: ${CMAKE_SYSTEM_NAME}")
  endif ()

  if (FFMPEG_${component}_LIBRARY AND FFMPEG_${component}_INCLUDE_DIR)
    set(FFMPEG_${component}_FOUND TRUE)
    set(FFMPEG_${component}_LIBRARIES ${${_library_var}})
    set(FFMPEG_${component}_INCLUDE_DIRS ${FFMPEG_${component}_INCLUDE_DIR})
    set(FFMPEG_${component}_DEFINITIONS ${PC_FFMPEG_${component}_CFLAGS_OTHER})
    mark_as_advanced(FFMPEG_${component}_LIBRARY FFMPEG_${component}_INCLUDE_DIR FFMPEG_${component}_IMPLIB)

    ffmpeg_append_lib_path(${FFMPEG_${component}_LIBRARY})
  endif ()

  message(DEBUG "[FindFFMPEG]:  ${component_name}:")
  message(DEBUG "[FindFFMPEG]:    LIBRARY: ${FFMPEG_${component}_LIBRARY}")
  message(DEBUG "[FindFFMPEG]:    IMPLIB: ${FFMPEG_${component}_IMPLIB}")
  message(DEBUG "[FindFFMPEG]:    INCLUDE: ${FFMPEG_${component}_INCLUDE_DIR}")
  message(DEBUG "[FindFFMPEG]:    DEFINITIONS: ${FFMPEG_${component}_DEFINITIONS}")
  message(DEBUG "[FindFFMPEG]:    FFMPEG_${component}_VERSION: ${FFMPEG_${component}_VERSION}")
  message(DEBUG "[FindFFMPEG]:    PC_FFMPEG_${component}_VERSION: ${PC_FFMPEG_${component}_VERSION}")
  message(DEBUG "[FindFFMPEG]:    PC_FFMPEG_${component}_INCLUDE_DIRS: ${PC_FFMPEG_${component}_INCLUDE_DIRS}")
  message(DEBUG "[FindFFMPEG]:    PC_FFMPEG_${component}_LIBRARY_DIRS: ${PC_FFMPEG_${component}_LIBRARY_DIRS}")
endmacro()

# ffmpeg_find_dll: Macro to find DLL for corresponding import library
macro(ffmpeg_find_dll)
  cmake_path(GET FFMPEG_${component}_IMPLIB PARENT_PATH _implib_path)
  cmake_path(SET _bin_path NORMALIZE "${FFMPEG_ROOT}/bin")

  string(REGEX REPLACE "([0-9]+)\\.[0-9]+\\.[0-9]+" "\\1" _dll_version "${FFMPEG_${component}_VERSION}")

  find_program(
          FFMPEG_${component}_LIBRARY
          NAMES ${component_name}-${_dll_version}.dll
          HINTS ${_implib_path} ${_bin_path}
          DOC "FFMPEG component ${component_name} DLL location"
  )

  if (NOT FFMPEG_${component}_LIBRARY)
    set(FFMPEG_${component}_LIBRARY "${FFMPEG_${component}_IMPLIB}")
  endif ()

  unset(_implib_path)
  unset(_bin_path)
  unset(_dll_version)
endmacro()

# ffmpeg_check_version: Macro to help extract version number from FFMPEG headers
macro(ffmpeg_check_version)
  if (PC_FFMPEG_${component}_VERSION)
    set(FFMPEG_${component_libname}_VERSION ${PC_FFMPEG_${component}_VERSION})
  elseif (EXISTS "${FFMPEG_${component}_INCLUDE_DIR}/${component_libname}/version.h")
    # get major version from version_major if version_major.h exists
    if (EXISTS "${FFMPEG_${component}_INCLUDE_DIR}/lib${component}/version_major.h")
      set(_major_version_file "${FFMPEG_${component}_INCLUDE_DIR}/lib${component}/version_major.h")
    else ()
      # otherwise get major version from version.h
      set(_major_version_file "${FFMPEG_${component}_INCLUDE_DIR}/lib${component}/version.h")
    endif ()

    # get major version
    file(
            STRINGS
            ${_major_version_file}
            _version_string
            REGEX "^.*VERSION_MAJOR[ \t]+[0-9]+[ \t]*$"
    )
    string(REGEX REPLACE ".*VERSION_MAJOR[ \t]+([0-9]+).*" "\\1" _version_major "${_version_string}")

    # get minor and micro version
    file(
            STRINGS
            "${FFMPEG_${component}_INCLUDE_DIR}/lib${component}/version.h"
            _version_string
            REGEX "^.*VERSION_(MINOR|MICRO)[ \t]+[0-9]+[ \t]*$"
    )
    string(REGEX REPLACE ".*VERSION_MINOR[ \t]+([0-9]+).*" "\\1" _version_minor "${_version_string}")
    string(REGEX REPLACE ".*VERSION_MICRO[ \t]+([0-9]+).*" "\\1" _version_micro "${_version_string}")

    if (NOT _version_major STREQUAL "" AND NOT _version_minor STREQUAL "" AND NOT _version_micro STREQUAL "")
      set(FFMPEG_${component}_VERSION "${_version_major}.${_version_minor}.${_version_micro}")
      set(FFMPEG_${component_libname}_VERSION "${_version_major}.${_version_minor}.${_version_micro}")
      message(DEBUG "[FindFFMPEG]: found ${component}: ${_version_major}.${_version_minor}.${_version_micro}")
    else ()
      message(STATUS "Failed to find ${component_name} version.")
    endif ()

    unset(_version_major)
    unset(_version_minor)
    unset(_version_micro)
    unset(_version_string)
    unset(_major_version_file)
  else ()
    if (NOT FFMPEG_FIND_QUIETLY)
      message(STATUS "Failed to find ${component_name} version.")
    endif ()

    # set(FFMPEG_${component_libname}_VERSION 0.0.0)
  endif ()
endmacro()

# ffmpeg_set_soname: Set SONAME property on imported library targets
macro(ffmpeg_set_soname)
  if (CMAKE_HOST_SYSTEM_NAME MATCHES "Darwin")
    execute_process(
            COMMAND sh -c "otool -D '${FFMPEG_${component}_LIBRARY}' | grep -v '${FFMPEG_${component}_LIBRARY}'"
            OUTPUT_VARIABLE _output
            RESULT_VARIABLE _result
    )

    if (_result EQUAL 0 AND _output MATCHES "^@rpath/")
      # extract soname, some libraries have multiple soname
      string(REGEX REPLACE "\n" ";" _soname_list "${_output}")
      list(GET _soname_list 0 _soname)
      string(REGEX REPLACE "^@rpath/" "" _soname "${_soname}")
      string(STRIP ${_soname} _soname)
      # set target soname
      set_property(TARGET FFMPEG::${component} PROPERTY IMPORTED_SONAME "${_soname}")
      # concat library path and add to FFMPEG_LIB_PATHS
      get_filename_component(_comp_dir ${FFMPEG_${component}_LIBRARY} DIRECTORY)
      set(_loc_real "${_comp_dir}/${_soname}")
      if (EXISTS "${_loc_real}")
        ffmpeg_append_lib_path("${_loc_real}")
      endif ()
    endif ()
  elseif (CMAKE_HOST_SYSTEM_NAME MATCHES "Linux|FreeBSD")
    execute_process(
            COMMAND sh -c "objdump -p '${FFMPEG_${component}_LIBRARY}' | grep SONAME"
            OUTPUT_VARIABLE _output
            RESULT_VARIABLE _result
    )

    if (_result EQUAL 0)
      # extract soname
      string(REGEX REPLACE "[ \t]+SONAME[ \t]+([^ \t]+)" "\\1" _soname "${_output}")
      string(STRIP ${_soname} _soname)
      # set target soname
      set_property(TARGET FFMPEG::${component} PROPERTY IMPORTED_SONAME "${_soname}")
      # concat library path and add to FFMPEG_LIB_PATHS
      get_filename_component(_loc_dir ${FFMPEG_${component}_LIBRARY} DIRECTORY)
      set(_loc_soname "${_loc_dir}/${_soname}")
      ffmpeg_append_lib_path(${_loc_soname})
      if (IS_SYMLINK ${_loc_soname})
        get_filename_component(_loc_real ${_loc_soname} REALPATH)
        ffmpeg_append_lib_path("${_loc_real}")
      endif ()
      unset(_soname)
      unset(_loc_dir)
      unset(_loc_soname)
      unset(_loc_real)
    endif ()
  endif ()
  unset(_output)
  unset(_result)
endmacro()

macro(ffmpeg_create_target component)
  if (FFMPEG_${component}_FOUND AND NOT TARGET FFMPEG::${component})
    if (IS_ABSOLUTE "${FFMPEG_${component}_LIBRARY}")
      if (DEFINED FFMPEG_${component}_IMPLIB)
        if (FFMPEG_${component}_IMPLIB STREQUAL FFMPEG_${component}_LIBRARY)
          add_library(FFMPEG::${component} STATIC IMPORTED GLOBAL)
        else ()
          add_library(FFMPEG::${component} SHARED IMPORTED GLOBAL)
          set_target_properties(
                  FFMPEG::${component}
                  PROPERTIES
                  IMPORTED_IMPLIB "${FFMPEG_${component}_IMPLIB}"
          )
        endif ()
      else ()
        add_library(FFMPEG::${component} SHARED IMPORTED GLOBAL)
        ffmpeg_set_soname()
      endif ()

      set_target_properties(
              FFMPEG::${component}
              PROPERTIES
              IMPORTED_LOCATION "${FFMPEG_${component}_LIBRARY}"
      )
    else ()
      add_library(FFMPEG::${component} INTERFACE IMPORTED GLOBAL)
      set_target_properties(
              FFMPEG::${component}
              PROPERTIES
              IMPORTED_LIBNAME "${FFMPEG_${component}_LIBRARY}"
      )
    endif ()

    set_target_properties(
            FFMPEG::${component}
            PROPERTIES
            INTERFACE_COMPILE_OPTIONS "${PC_FFMPEG_${component}_CFLAGS_OTHER}"
            INTERFACE_INCLUDE_DIRECTORIES "${FFMPEG_${component}_INCLUDE_DIR}"
            VERSION ${FFMPEG_${component_libname}_VERSION}
    )

    # get_target_property(_ffmpeg_interface_libraries FFMPEG::FFMPEG INTERFACE_LINK_LIBRARIES)

    # if(NOT FFMPEG::${component} IN_LIST _ffmpeg_interface_libraries)
    # set_property(TARGET FFMPEG::FFMPEG APPEND PROPERTY INTERFACE_LINK_LIBRARIES FFMPEG::${component})
    # endif()
  endif ()
endmacro()

##################################################################################
# Main logic
##################################################################################
foreach (component IN LISTS FFMPEG_FIND_COMPONENTS)
  if (NOT component IN_LIST _DEFAULT_COMPONENTS)
    message(FATAL_ERROR "Unknown FFMPEG component specified: ${component}.")
  endif ()

  if (NOT FFMPEG_${component}_FOUND)
    ffmpeg_find_component(${component})
  endif ()

  if (FFMPEG_${component}_FOUND)
    ffmpeg_create_target(${component})

    # list(APPEND FFMPEG_LIB_PATHS ${FFMPEG_${component}_LIBRARY})
    set(FFMPEG_LIBRARIES ${FFMPEG_LIBRARIES} FFMPEG::${component})
    set(FFMPEG_DEFINITIONS ${FFMPEG_DEFINITIONS} ${FFMPEG_${component}_DEFINITIONS})
    set(FFMPEG_INCLUDE_DIRS ${FFMPEG_INCLUDE_DIRS} ${FFMPEG_${component}_INCLUDE_DIR})
  endif ()
endforeach ()

if (NOT FFMPEG_avutil_FOUND)
  ffmpeg_find_component(avutil)
endif ()

if (EXISTS "${FFMPEG_avutil_INCLUDE_DIR}/libavutil/ffversion.h")
  file(
          STRINGS
          "${FFMPEG_avutil_INCLUDE_DIR}/libavutil/ffversion.h"
          _version_string
          REGEX "FFMPEG_VERSION"
  )
  string(REGEX REPLACE ".*\"n?\(.*\)\"" "\\1" FFMPEG_VERSION "${_version_string}")
endif ()

unset(_version_string)

message(STATUS "FFMPEG_VERSION: ${FFMPEG_VERSION}")

list(REMOVE_DUPLICATES FFMPEG_INCLUDE_DIRS)
list(REMOVE_DUPLICATES FFMPEG_LIBRARIES)
list(REMOVE_DUPLICATES FFMPEG_LIB_PATHS)
list(REMOVE_DUPLICATES FFMPEG_DEFINITIONS)

set(FFMPEG_LIB_PATHS "${FFMPEG_LIB_PATHS}" CACHE INTERNAL "FFMPEG_LIB_PATHS")

if (CMAKE_HOST_SYSTEM_NAME MATCHES "Darwin|Windows")
  set(FFMPEG_ERROR_REASON "Ensure that obs-deps is provided as part of CMAKE_PREFIX_PATH.")
elseif (CMAKE_HOST_SYSTEM_NAME MATCHES "Linux|FreeBSD")
  set(FFMPEG_ERROR_REASON "Ensure that required FFMPEG libraries are installed on the system.")
endif ()

find_package_handle_standard_args(
        FFMPEG
        REQUIRED_VARS FFMPEG_ROOT FFMPEG_LIBRARIES FFMPEG_INCLUDE_DIRS
        VERSION_VAR FFMPEG_VERSION
        HANDLE_COMPONENTS
        REASON_FAILURE_MESSAGE "${FFMPEG_ERROR_REASON}"
)

if (FFMPEG_FOUND AND NOT TARGET FFMPEG::FFMPEG)
  add_library(FFMPEG::FFMPEG INTERFACE IMPORTED GLOBAL)

  foreach (component IN LISTS FFMPEG_FIND_COMPONENTS)
    if (FFMPEG_${component}_FOUND)
      set_property(TARGET FFMPEG::FFMPEG APPEND PROPERTY INTERFACE_LINK_LIBRARIES FFMPEG::${component})
    endif ()
  endforeach ()
endif ()

include(FeatureSummary)
set_package_properties(
        FFMPEG
        PROPERTIES
        URL "https://www.ffmpeg.org"
        DESCRIPTION "A complete, cross-platform solution to record, convert and stream audio and video."
)
