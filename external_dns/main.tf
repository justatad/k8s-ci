provider "aws" {
  region  = "eu-west-1"
  profile = "default"
}

terraform {
  backend "s3" {
    bucket = "k8s-tf-bucket-slalom"
    key    = "externaldns/terraform.tfstate"
    region = "eu-west-1"
  }
}
