.PHONY: ffigen build_win

ffigen:
	dart run ffigen --config ffigen_const.yaml
	dart run ffigen --config ffigen_types.yaml
	dart run ffigen --config ffigen.yaml

build_win:
	mkdir -Force build
