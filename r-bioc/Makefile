IMAGE=r-bioc

all: build

build:
	docker build -t $(IMAGE) --build-arg .

test:
	docker run --rm -it $(IMAGE) bash
