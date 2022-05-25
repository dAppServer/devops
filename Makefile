
COMMON_PROPS:=--platform=linux/amd64 --load compiler/src
all: help


chains: ## Builds full env
	bash scripts/build-chains.sh

mainnet-lthn: ## Run lethean Blockchain Node
	./blockchain/bin/letheand --confirm-external-bind --detach --data-dir=data/lthn

mainnet-wrkz: ## Run WrkzCoin Node
	./blockchain/bin/Wrkzd --confirm-external-bind --data-dir=data/wrkz

testnet-itw3: ## Start iTw3 Testnet
	./blockchain/bin/itw3d --confirm-external-bind --testnet --detach --data-dir=data/itw3/testnet

testnet-lthn: ## Start Lethean Testnet
	./blockchain/bin/letheand --confirm-external-bind --testnet --detach --data-dir=data/lthn/testnet

testnet-wrkz: ## Start WrkzCoin Testnet
	./blockchain/bin/Wrkzd --confirm-external-bind --testnet --data-dir=data/wrkz/testnet

clean: ## Docker System Prune
	docker system prune --all

help: ## Show this help
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m make %-30s\033[0m %s\n", $$1, $$2}'
