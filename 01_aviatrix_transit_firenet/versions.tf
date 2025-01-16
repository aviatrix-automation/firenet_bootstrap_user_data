terraform {
  backend "s3" {}
  required_providers {
    aviatrix = {
      source = "AviatrixSystems/aviatrix"
      version = "~> 3.2.1" ## 7.2 Aviatrix Controller
    }
  }
  required_version = ">= 1.0"
}
