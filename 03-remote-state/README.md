# Solution 03: remote state 

Demonstrates how to share and persist Terraform state in a remote state backend based on S3 and DynamoDB.

This iteration demonstrates the following capabilities:

* `main.tf` contains only the call to the Terraform module
* `variables.tf` declares all input variables to this Terraform module
* `outputs.tf` declares all output variables of this Terraform module
* `terraform.tfvars` defines the values for all required input variables
* `modules/network` contains the module code of the `network` module
* `backend` contains the code to create the remote state backend on AWS
* `backend.tf` contains the backend definition of the remote state backend

## HOW-TO present this solution

### Step 1: Create the remote state backend

Change to folder `backend` and run the following terraform commands:

```shell
terraform init 
terraform apply -auto-approve -var-file ../common.tfvars
```

### Step 2: Create the AWS solution 

Change to the root folder of this solution and run the following terraform commands:

```shell
terraform init 
terraform apply -auto-approve
```

### Step 3: Destroy the AWS solution

Change to the root folder of this solution and run the following terraform commands:

```shell
terraform destroy -auto-approve
```

### Step 4: Destroy the remote state backend

Change to folder `backend` and run the following terraform commands:

```shell
terraform destroy -auto-approve -var-file ../common.tfvars
```
