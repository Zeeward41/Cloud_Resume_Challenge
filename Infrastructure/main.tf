provider "aws" {
  region = var.region_base
  profile = "zeeward41"
  default_tags {
    tags = {
      Createur = "Zee"
      Projet   = "Cloud Resume Challenge"
    }
  }
}

# module 

module "website" {
  source   = "./modules/website"
  url_web  = var.url_web
  url_name = var.url_name
}

module "backend" {
  source      = "./modules/backend"
  region_base = var.region_base
}

# module "remote_backend" {
#   source = "./remote_backend"
#   region_base = var.region_base
# }