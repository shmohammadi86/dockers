IMAGE=r-oneapi-bioc
REGISTRY=shmohammadi86
VERSION=3.12

all: build

build:
	docker build -t $(IMAGE) -t $(IMAGE):${VERSION} -t $(REGISTRY)/$(IMAGE) -t $(REGISTRY)/$(IMAGE):${VERSION} .
	
test:
	docker run --rm -it $(IMAGE) bash
