# Solution 01: multiple files 

Demonstrates how to organize Terraform code in modules.

This iteration demonstrates the following capabilities:

* `main.tf` contains only the call to the Terraform module
* `variables.tf` declares all input variables to this Terraform module
* `outputs.tf` declares all output variables of this Terraform module
* `terraform.tfvars` defines the values for all required input variables
* `modules/network` contains the module code of the `network` module
