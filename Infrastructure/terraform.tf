terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.14"
    }
  }

  backend "s3" {

  # valeur à la main :(         
    profile = "zeeward41"
    bucket = "zeeward41-state-file"
    key = "global/s3/terraform.tfstate"
    region = "eu-west-2"

    dynamodb_table = "zeeward41-terraform-lock"
    encrypt = true

    depends_on = [module.remote_backend.aws_s3_bucket.terraform_state, module.remote_backend.aws_dynamodb_table.terraform_locks]

    }
}

  
