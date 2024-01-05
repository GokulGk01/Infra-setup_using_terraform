#EC2 Instances
output "buildserver_public_ip" {
  description = "Public IP of Build Server"
  value       = aws_eip_association.eip_assoc.public_ip
}

output "db_server_public_ip" {
  description = "Public IP of DB Server"
  value       = aws_instance.db_server.public_ip
}

#S3 Bucket
output "s3_bucket_url" {
  description = "Bucket URL"
  value       = "https://${aws_s3_bucket.s3_bucket.bucket}.s3.${var.aws_region}.amazonaws.com/"
}

output "s3_bucket_name" {
  description = "S3 Bucket Name"
  value       = aws_s3_bucket.s3_bucket.id
}

output "s3_bucket_region" {
  description = "The AWS region S3 bucket resides in."
  value       = var.aws_region
}

output "staging_user_access_key" {
  description = "Access key for staging user"
  value = aws_iam_access_key.staging_user.id
}

output "staging_user_secret_key" {
  description = "Secret Key for staging user"
  value = aws_iam_access_key.staging_user.secret
  sensitive = true
}

output "media_convert_role_arn" {
  value = aws_iam_role.media_convert_role.arn
}

output "media_convert_queue_arn" {
  value = aws_media_convert_queue.media_convert_queue.arn
}

output "smtp_username_access_key" {
  value = aws_iam_access_key.smtp_user.id
}

output "smtp_password" {
  value = aws_iam_access_key.smtp_user.ses_smtp_password_v4
  sensitive = true
}
