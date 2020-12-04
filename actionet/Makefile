IMAGE=actionet
PARENT_IMAGE=r-bioc

all: build

build:
	docker build -t $(IMAGE) .

test:
	docker run --rm -it $(IMAGE) bash
