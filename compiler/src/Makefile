# Configuration Values
DOCKER_COMPOSE ?= .build/src/docker-compose.yml
DOCKER_FILE ?= .build/src/Dockerfile
K8_BUILD_DIR ?= .build/dist/dist/k8
DOCKER_IMAGE ?= lthn/build
BUILD_RESULT_PATH ?= /home/build/build
BUILD_GIT_REPO ?= "https://github.com/letheanVPN/build-template.git#master"

# Internal Behaviour Settings
DOCKER_NAME_NORMALISED ?= lthn-$(subst /,-,$(DOCKER_IMAGE))

all:
	echo "Please see our documentation on how to use: https://letheanvpn.github.io/build-template/"

# Build Stage
.PHONY: build
build:
	docker build -f "$(DOCKER_FILE)" -t "$(DOCKER_IMAGE)" src || exit

.PHONY: build-git
build-git:
	docker build -t "$(DOCKER_IMAGE)" ${BUILD_GIT_REPO} || exit

.PHONY: compile-git
compile-git:
	docker build -f "$(DOCKER_FILE)" -t "$(DOCKER_IMAGE)" src || exit

.PHONY: eject-build
eject-build: run-docker eject-docker stop-docker clean-docker
	echo "Ejected Build to ${BUILD_RESULT_PATH}"

# Interactions

.PHONY: run-docker
run-docker:
	docker run --name "$(DOCKER_NAME_NORMALISED)" -d "$(DOCKER_IMAGE)"

.PHONY: stop-docker
stop-docker:
	docker stop "$(DOCKER_NAME_NORMALISED)"

.PHONY: clean-docker
clean-docker:
	docker rm "$(DOCKER_NAME_NORMALISED)" && docker rmi "$(DOCKER_IMAGE)"

.PHONY: eject-docker
eject-docker:
	docker cp "$(DOCKER_NAME_NORMALISED)":"$(BUILD_RESULT_PATH)" ./dist

.PHONY: check-docker
check-docker:
	docker stats || exit

# Docker Deployment

.PHONY: deploy-docker
deploy-docker: build
	docker push "$(DOCKER_IMAGE)"

.PHONY: pull-docker
pull-docker:
	docker pull "$(DOCKER_IMAGE)"



# K8 Integrations

.PHONY: k8
k8:
	@mkdir -p $(K8_BUILD_DIR)
	kompose convert --file "$(DOCKER_COMPOSE)" --out "$(K8_BUILD_DIR)"


.PHONY: build-k8s
build-k8s: $(K8_BUILD_DIR)
	@for file in $(K8S_FILES); do \
		mkdir -p `dirname "$(K8_BUILD_DIR)/$$file"` ; \
		$(SHELL_EXPORT) envsubst <$(DOCKER_COMPOSE)/$$file >$(K8_BUILD_DIR)/$$file ;\
	done

.PHONY: deploy
deploy: build-k8s build-docker
	kubectl apply -f $(K8_BUILD_DIR)
