# Solution 05: use case VPC, EC2 and RDS 

Demonstrates how maintain create all resources for the use cases `VPC`, `EC2` and `RDS` based on module code from the `iac-tf-aws-cloudtrain-modules` module repo.

Since this solution only contains live code, the root folder has the following subfolders:

* `eu-west-1\dev`: contains the configuration for the `DEV` stage of the solution.
* `stage`: contains the actual live code shared by all stages.

## HOW-TO present these use cases

### Step 1: Create the remote state backend

Change to folder `/eu-central-1/dev/backend` and run the following terraform commands:

```shell
terraform init 
terraform apply -auto-approve -var-file ../common.tfvars
```

### Step 2: Create the AWS solution

Change to folder `/stage` and run the following terraform commands:

```shell
terraform init -backend-config ../eu-central-1/dev/common.s3.tfbackend 
terraform apply -auto-approve -var-file ../eu-central-1/dev/common.tfvars
```

### Step 3: Destroy the AWS solution

Change to folder `/stage` and run the following terraform commands:

```shell
terraform destroy -auto-approve -var-file ../eu-central-1/dev/common.tfvars
```

### Step 4: Destroy the remote state backend

Change to folder `/eu-central-1/dev/backend` and run the following terraform commands:

```shell
terraform destroy -auto-approve -var-file ../common.tfvars
```
