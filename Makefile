.PHONY: build
build:
	docker build --squash --rm -t lthn/build .

.PHONY: push
push: build
	docker login
	docker push lthn/build