IMAGE=bioc
REGISTRY=shmohammadi86
VERSION=3.12.28

all: build

build:
	docker build -t $(IMAGE) -t $(REGISTRY)/$(IMAGE) -t $(REGISTRY)/$(IMAGE):${VERSION} .
	
test:
	docker run --rm -it $(IMAGE) bash
