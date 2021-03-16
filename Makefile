DOCKER_FILES := $(wildcard */Dockerfile)
BUILD_FILES := $(patsubst %/Dockerfile,%/.build,$(DOCKER_FILES))

.PHONY: build
build: $(BUILD_FILES)

$(BUILD_FILES): %/.build: %/Dockerfile
	docker build -t $* $*
	touch $@

.PHONY: clean
clean:
	rm $(BUILD_FILES)
