terraform {
#  cloud {
#    organization = "hashicorp-tutorials-learning"
#
#    workspaces {
#      name = "terra-house-1"
#    }
#  }
}

module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
  error_html_file_path = var.error_html_file_path
  index_html_file_path = var.index_html_file_path
  content_version = var.content_version
}