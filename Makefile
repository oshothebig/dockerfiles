DOCKER_FILES := $(wildcard */Dockerfile)
IMAGES := $(patsubst %/Dockerfile,%,$(DOCKER_FILES))

.PHONY: build
build: $(IMAGES)

.PHONY: $(IMAGES)
$(IMAGES):
	docker build -t $@ $@
