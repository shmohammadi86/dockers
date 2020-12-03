IMAGE=r-base
all: build

build:
	docker build -t $(IMAGE) .

test:
	docker run --rm -it $(IMAGE) bash
