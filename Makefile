REPOSITORY ?= ghcr.io/oshothebig
IMAGES := $(patsubst %/Dockerfile,%,$(wildcard */Dockerfile))

.PHONY: build
build: $(addprefix build-,$(IMAGES))

.PHONY: build-%
build-%: %/.build ;

.PRECIOUS: %/.build
%/.build: %/Dockerfile
	docker build -t $(REPOSITORY)/$* $*
	touch $@

.PHONY: clean
clean:
	rm -f $(addsuffix /.build,$(IMAGES))

.PHONY: push
push: $(addprefix push-,$(IMAGES))

.PHONY: push-%
push-%: build-%
	docker push $(REPOSITORY)/$*
