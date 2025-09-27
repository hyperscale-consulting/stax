SHELL := bash -eu -o pipefail
MAKEFLAGS += --warn-undefined-variable

.PHONY: build clean

requirements.txt: uv.lock
	uv export --no-default-groups --no-emit-local --locked -o $@

build: requirements.txt
	docker build -t stax .

clean:
	rm requirements.txt
