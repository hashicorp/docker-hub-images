build:
	docker build -t hashicorp/packer:full      -f packer/Dockerfile-full packer
	docker build -t hashicorp/packer:light     -f packer/Dockerfile-light packer
	docker build -t hashicorp/packer:latest    -f packer/Dockerfile-light packer
	docker build -t hashicorp/terraform:full   -f terraform/Dockerfile-full terraform
	docker build -t hashicorp/terraform:light  -f terraform/Dockerfile-light terraform
	docker build -t hashicorp/terraform:latest -f packer/Dockerfile-light terraform
	docker build -t hashicorp/vault:full       -f vault/Dockerfile-full vault
	docker build -t hashicorp/vault:light      -f vault/Dockerfile-light vault
	docker build -t hashicorp/vault:latest     -f packer/Dockerfile-light vault

version:
		@echo -n "hashicorp/packer:full\t\t"
		@docker run hashicorp/packer:full --version
		@echo -n "hashicorp/packer:light\t\t"
		@docker run hashicorp/packer:light --version
		@echo -n "hashicorp/terraform:full\t\t"
		@docker run hashicorp/terraform:full --version
		@echo -n "hashicorp/terraform:light\t\t"
		@docker run hashicorp/terraform:light --version
		@echo -n "hashicorp/vault:full\t\t"
		@docker run hashicorp/vault:full --version
		@echo -n "hashicorp/vault:light\t\t"
		@docker run hashicorp/vault:light --version

test:
	@make version
