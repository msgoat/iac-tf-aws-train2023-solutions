# Solution 06: use case Kubernetes 

Demonstrates how create all resources for the use cases `Kubernetes` based on module code from the `iac-tf-aws-cloudtrain-modules` module repo.

Since this solution only contains live code, the root folder has the following subfolders:

* `eu-west-1\dev`: contains the configuration for the `DEV` stage of the solution.
* `stage`: contains the actual live code shared by all stages.

## HOW-TO present these use cases

### Step 1: Create the remote state backend

Change to folder `/eu-central-1/dev/backend` and run the following terraform commands:

```shell
terraform init 
terraform apply -auto-approve -var-file ../k8s-foundation.tfvars
```

### Step 2: Create the AKS cluster

Change to folder `/stage/ks8-foundation` and run the following terraform commands:

```shell
terraform init -backend-config ../../eu-central-1/dev/k8s-foundation.s3.tfbackend 
terraform apply -auto-approve -var-file ../../eu-central-1/dev/k8s-foundation.tfvars
```

### Step 3: Bootstrap the AKS cluster with add-ons and tools

Change to folder `/stage/ks8-bootstrap` and run the following terraform commands:

```shell
terraform init -backend-config ../../eu-central-1/dev/k8s-bootstrap.s3.tfbackend 
terraform apply -auto-approve -var-file ../../eu-central-1/dev/k8s-bootstrap.tfvars
```

### Step 4: Destroy the AWS resources

Destroy the AWS resources in reverse order by running `terraform destroy` 
first in the `/stage/k8s-bootstrap` live code section 
then in the `/stage/k8s-foundation` live code section.

### Step 5: Destroy the remote state backend

Change to folder `/eu-central-1/dev/backend` and run the following terraform commands:

```shell
terraform destroy -auto-approve -var-file ../k8s-foundation.tfvars
```
