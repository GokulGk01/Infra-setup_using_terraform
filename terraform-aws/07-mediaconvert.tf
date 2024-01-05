##Role for AWS media convert.
resource "aws_iam_role" "media_convert_role" {
  name = "gk_Staging_Mediaconvert_Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "mediaconvert.amazonaws.com"
        },
        Effect = "Allow",
      },
    ],
  })
}

##Attaching S3 and APIGatewayinvokeFull access policy to the role create media_convert_role.
resource "aws_iam_role_policy_attachment" "media_convert_role_s3_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  role       = aws_iam_role.media_convert_role.name
}

resource "aws_iam_role_policy_attachment" "media_convert_role_apigateway_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonAPIGatewayInvokeFullAccess"
  role       = aws_iam_role.media_convert_role.name
}

##Creating the AWS MediaQueue.
resource "aws_media_convert_queue" "media_convert_queue" {
  name        = "gk_Staging_Mediaconvert"
  description = "Media Convert Queue for Staging "
}
