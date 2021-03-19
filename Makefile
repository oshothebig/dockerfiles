REPOSITORY ?= ghcr.io/oshothebig
DOCKER_FILES := $(wildcard */Dockerfile)
BUILD_FILES := $(patsubst %/Dockerfile,%/.build,$(DOCKER_FILES))
PUSH_TARGETS := $(patsubst %/Dockerfile,%/.push,$(DOCKER_FILES))

.PHONY: build
build: $(BUILD_FILES)

$(BUILD_FILES): %/.build: %/Dockerfile
	docker build -t $(REPOSITORY)/$* $*
	touch $@

.PHONY: clean
clean:
	rm $(BUILD_FILES)

.PHONY: push
push: $(PUSH_TARGETS)

.PHONY: $(PUSH_TARGETS)
$(PUSH_TARGETS): %/.push: %/.build
	docker push $(REPOSITORY)/$*
