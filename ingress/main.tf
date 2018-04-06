terraform {
  backend "s3" {
    bucket = "k8s-tf-bucket-slalom"
    key    = "ingress/terraform.tfstate"
    region = "eu-west-1"
  }
}
