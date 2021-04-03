REPOSITORY ?= ghcr.io/oshothebig
IMAGES := $(patsubst %/Dockerfile,%,$(wildcard */Dockerfile))

.PHONY: build
build: $(addsuffix /.build,$(IMAGES))

%/.build: %/Dockerfile
	docker build -t $(REPOSITORY)/$* $*
	touch $@

.PHONY: push
push: $(addprefix push-,$(IMAGES))

.PHONY: push-%
push-%: %/.build
	docker push $(REPOSITORY)/$*

.PHONY: clean
clean:
	rm -f */.build
