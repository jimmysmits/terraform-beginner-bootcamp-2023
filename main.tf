# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string
resource "random_string" "bucket_name" {
  length           = 32
  special          = false
  upper            = false
}

# https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html (bucket naming rules)
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket

resource "aws_s3_bucket" "terraform-bootcamp-simple-s3-bucket" {
  bucket = random_string.bucket_name.result

  tags = {
    UserUuid = var.user_uuid
  }
}