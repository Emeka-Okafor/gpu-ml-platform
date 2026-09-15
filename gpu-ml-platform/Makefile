.PHONY: help init plan apply destroy fmt validate

help:
	@echo "Available targets:"
	@echo "  make init      - terraform init"
	@echo "  make plan      - terraform plan"
	@echo "  make apply     - terraform apply"
	@echo "  make destroy   - terraform destroy"
	@echo "  make fmt       - terraform fmt"
	@echo "  make validate  - terraform validate"

TF_DIR := terraform/environments/dev

init:
	cd $(TF_DIR) && terraform init

plan:
	cd $(TF_DIR) && terraform plan

apply:
	cd $(TF_DIR) && terraform apply

destroy:
	cd $(TF_DIR) && terraform destroy

fmt:
	terraform fmt -recursive

validate:
	cd $(TF_DIR) && terraform validate
