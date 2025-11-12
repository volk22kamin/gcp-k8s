# Terraform backend configuration for the cluster stack

terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}
