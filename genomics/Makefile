IMAGE=genomics
REGISTRY=shmohammadi86

all: build

build:
	docker build -t $(IMAGE) -t $(REGISTRY)/$(IMAGE) .
	
test:
	docker run --rm -it $(IMAGE) bash
