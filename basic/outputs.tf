# state
# desire - know - actual
output "my_s3_bucket_versioning" {
  value = aws_s3_bucket.my_s3_bucket.versioning[0].enabled
}

output "my_s3_bucket_detail" {
  value = aws_s3_bucket.my_s3_bucket
}

output "my_iam_user_detail" {
  value = aws_iam_user.my_iam_user
}