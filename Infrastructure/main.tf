provider "aws" {
    region = "var.region_base"
}

# module 

module "website" {
    source = "./modules/website"
}