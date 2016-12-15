image_name := nodejs
image_registry := quay.io/nordstrom
nodejs_version := 4.2.6
image_release := $(nodejs_version)-0

build_args := --build-arg NODEJS_VERSION=$(image_release)

ifdef http_proxy
build_args += --build-arg http_proxy=$(http_proxy)
build_args += --build-arg https_proxy=$(http_proxy)
build_args += --build-arg HTTP_PROXY=$(http_proxy)
build_args += --build-arg HTTPS_PROXY=$(http_proxy)
endif

.PHONY: build/image tag/image push/image

build/image: Dockerfile $(build_image_prereqs)
	docker build -t $(image_name) $(build_args) .

tag/image: build/image
	docker tag $(image_name) $(image_registry)/$(image_name):$(image_release)

push/image: tag/image
	docker push $(image_registry)/$(image_name):$(image_release)
