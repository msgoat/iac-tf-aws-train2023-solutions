# Solution 04: live code 

Demonstrates how maintain Terraform module code and Terraform live code in separate locations.

This iteration demonstrates the following capabilities:

* `live-code` contains the Terraform live code
* `module-code` contains the Terraform module code

## HOW-TO present this solution

### Step 1: Create the remote state backend

Change to folder `live-code/eu-central-1/dev/backend` and run the following terraform commands:

```shell
terraform init 
terraform apply -auto-approve -var-file ../network.tfvars
```

### Step 2: Create the AWS solution

Change to the stage folder `live-code/stage/network` of this solution and run the following terraform commands:

```shell
terraform init -backend-config ../../eu-central-1/dev/network.s3.tfbackend
terraform apply -auto-approve -var-file ../../eu-central-1/dev/network.tfvars
```

### Step 3: Destroy the AWS solution

Change to the stage folder `live-code/stage/network` of this solution and run the following terraform commands:

```shell
terraform destroy -auto-approve -var-file ../../eu-central-1/dev/network.tfvars
```

### Step 4: Destroy the remote state backend

Change to folder `live-code/eu-central-1/dev/backend` and run the following terraform commands:

```shell
terraform destroy -auto-approve -var-file ../network.tfvars
```
