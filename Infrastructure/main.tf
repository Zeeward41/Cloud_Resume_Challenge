provider "aws" {
    region = "var.region_base"
    default_tags {
        tags = {
            Createur = "Zee"
            Projet = "Cloud Resume Challenge"
        }
    }
}

# module 

module "website" {
    source = "./modules/website"
}