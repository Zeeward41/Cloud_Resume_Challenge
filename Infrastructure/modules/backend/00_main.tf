# Provider global

provider "aws" {
    alias = "global"
    region = "us-east-1"
}

# Variables

variable "region_base" {}