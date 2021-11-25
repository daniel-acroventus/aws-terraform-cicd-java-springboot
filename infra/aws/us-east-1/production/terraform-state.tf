terraform {
  backend "s3" {
    encrypt = true
    bucket = "dafy-terraform-remote-state"
    key = "aws-terraform-cicd-java-springboot/prod/ecs/terraform.tfstate"
    region = "us-east-1"
    profile = "dafi"
    shared_credentials_file = "~/.aws/credentials"
    dynamodb_table = "terraform-remote-state"
  }
}
