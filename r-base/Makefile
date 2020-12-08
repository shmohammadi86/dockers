IMAGE=r-base
REGISTRY=shmohammadi86
VERSION=4.0.3

all: build

build:
	docker build -t $(IMAGE) -t $(REGISTRY)/$(IMAGE) -t $(REGISTRY)/$(IMAGE):${VERSION} .
	
test:
	docker run --rm -it $(IMAGE) bash
