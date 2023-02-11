# Solution 01: multiple files 

Demonstrates how to organize Terraform code in multiple *.tf files.

This iteration demonstrates the following capabilities:

* `main.tf` contains only the common Terraform code shared by this module 
* `variables.tf` declares all input variables to this Terraform module 
* `outputs.tf` declares all output variables of this Terraform module
* `terraform.tfvars` defines the values for all required input variables
* `internet-gateway.tf` defines the internet gateway resource
* `subnets.tf` defines the subnet resources
* `vpc.tf` defines the VPC resource