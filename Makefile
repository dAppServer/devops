
all: help

clean: ## Docker System Prune
	docker system prune --all

build: ## Builds lthn/build
	docker build -t lthn/build -f build-conf/build.Dockerfile build-src


help: ## Show this help
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m make %-30s\033[0m %s\n", $$1, $$2}'