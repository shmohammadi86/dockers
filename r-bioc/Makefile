IMAGE=r-bioc
PARENT_IMAGE=r-base

all: build

build:
	docker build -t $(IMAGE) --build-arg PARENT_IMAGE=$(PARENT_IMAGE) .

test:
	docker run --rm -it $(IMAGE) bash
