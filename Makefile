REPOSITORY ?= ghcr.io/oshothebig
IMAGES := $(patsubst %/Dockerfile,%,$(wildcard */Dockerfile))
PUSH_TARGETS := $(addprefix push-,$(IMAGES))

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

.PHONY: clean
clean:
	rm -f */.build
