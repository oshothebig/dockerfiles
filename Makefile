REPOSITORY ?= ghcr.io/oshothebig
ARCHS ?= amd64 arm64
IMAGES := $(patsubst %/Dockerfile,%,$(wildcard */Dockerfile))
PUSH_TARGETS := $(addprefix push-,$(IMAGES))

# defined for tricks to concatenate strings
EMPTY :=
SPACE := $(EMPTY) $(EMPTY)
COMMA := ,
# concatenate strings in ARCHS, returning linux/amd64,linux/arm64
PLATFORMS := $(subst $(SPACE),$(COMMA),$(addprefix linux/,$(ARCHS)))

.PHONY: build
build: $(addsuffix /.build,$(IMAGES))

%/.build: %/Dockerfile
	docker build -t $(REPOSITORY)/$* $*
	touch $@

.PHONY: push
push: $(PUSH_TARGETS)

.PHONY: $(PUSH_TARGETS)
$(PUSH_TARGETS): push-%: %/.build
	docker push $(REPOSITORY)/$*

.PHONY: multi-arch-build
multi-arch-build: $(IMAGES)

.PHONY: $(IMAGES)
$(IMAGES): %:
	docker buildx build -t $(REPOSITORY)/$@ --platform $(PLATFORMS) --push $@

.PHONY: clean
clean:
	rm -f */.build
