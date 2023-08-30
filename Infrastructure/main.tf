provider "aws" {
    region = "eu-west-2"
}

# module 

module "website" {
    source = "./modules/website"
}