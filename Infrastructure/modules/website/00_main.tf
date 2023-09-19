# Provider global

provider "aws" {
    alias = "global"
    region = "us-east-1"
    profile = "zeeward41"
}

# Création d'un bucket qui contiendra les fichiers du site web
variable "url_web" {}
variable "url_name" {}

locals {
    s3_origin_id = aws_s3_bucket.bucket_base.bucket_regional_domain_name
    // = Name : www.xxx.s3.eu-west-5.amazonaws.com
}
