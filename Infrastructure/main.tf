provider "aws" {
  region = var.region_base
  default_tags {
    tags = {
      Createur = "Zee"
      Projet   = "Cloud Resume Challenge"
    }
  }
}

# module 

module "website" {
  source  = "./modules/website"
  url_web = var.url_web
  url_name = var.url_name
}