# https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html (bucket naming rules)
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket

resource "aws_s3_bucket" "terraform-bootcamp-simple-s3-bucket" {
  bucket = var.bucket_name

  tags = {
    UserUuid = var.user_uuid
  }
}