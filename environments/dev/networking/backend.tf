# Terraform backend configuration for the networking stack

terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}
