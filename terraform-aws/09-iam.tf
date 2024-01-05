##Create IAM user with S3 and Mediaconvert access
resource "aws_iam_user" "staging_user" {
  name = "gk-staging_user"
  tags = var.tags
}

resource "aws_iam_access_key" "staging_user" {
  user = aws_iam_user.staging_user.name
  lifecycle {
    create_before_destroy = true
  }
}

data "aws_iam_policy" "s3_policy" {
  arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

data "aws_iam_policy" "mediaconvert_policy" {
  arn = "arn:aws:iam::aws:policy/AWSElementalMediaConvertFullAccess"
}

resource "aws_iam_user_policy_attachment" "s3_policy_attachment" {
  policy_arn = data.aws_iam_policy.s3_policy.arn
  user = aws_iam_user.staging_user.name
}

resource "aws_iam_user_policy_attachment" "mediaconvert_policy_attachment" {
  policy_arn = data.aws_iam_policy.mediaconvert_policy.arn
  user = aws_iam_user.staging_user.name
}
