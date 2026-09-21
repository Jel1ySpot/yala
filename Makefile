AMBER  ?= amber
TARGET ?= bash-4.3
ENTRY  ?= src/main.ab
OUT    ?= dist/yala

.PHONY: all build run test check docs clean

all: build

## Compile src/main.ab into a standalone shell script in dist/.
build:
	mkdir -p dist
	$(AMBER) build --target $(TARGET) $(ENTRY) $(OUT)

## Build, then execute the compiled script.
run: build
	$(OUT)

## Run every test block under tests/ (and src/).
test:
	$(AMBER) test .

## Type-check the entry point and everything it imports.
check:
	$(AMBER) check $(ENTRY)

## Generate markdown docs from /// comments into docs/.
docs:
	$(AMBER) docs $(ENTRY) ../docs

clean:
	rm -rf dist docs
