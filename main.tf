# Configure the AWS Provider
provider "aws" {
  region = "us-east-2"
  version = "~> 2.55"
}

# plan - excute
resource "aws_s3_bucket" "my_s3_bucket" {
    bucket = "my-s3-bucket-terraform01"
    versioning {
        enabled = true
    }
}

# IAM User
resource "aws_iam_user" "my_iam_user" {
    count = 2
    name = "my_iam_user_${count.index}"
}
output "my_iam_user_detail_news" {
  value = aws_iam_user.my_iam_user
}