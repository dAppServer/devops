
COMMON_PROPS:=--platform=linux/amd64 --load compiler/src
all: help


dev: ## Builds full env
	bash build-dev.sh

testnet-itw3: ## Start iTw3 Testnet
	./blockchain/bin/itw3d --testnet --detach --data-dir=data/itw3/testnet

testnet-lthn: ## Start Lethean Testnet
	./blockchain/bin/letheand --testnet --detach --data-dir=data/lthn/testnet

testnet-wrkz: ## Start WrkzCoin Testnet
	./blockchain/bin/letheand --testnet --detach --data-dir=data/wrkz/testnet

clean: ## Docker System Prune
	docker system prune --all

help: ## Show this help
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m make %-30s\033[0m %s\n", $$1, $$2}'
