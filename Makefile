.PHONY: validate plan apply

validate:
	bash run_terraform.sh validate

plan:
	bash run_terraform.sh plan

apply:
	bash run_terraform.sh apply -auto-approve
