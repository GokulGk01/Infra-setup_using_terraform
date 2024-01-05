##Create email for verified identity
resource "aws_ses_email_identity" "staging_smtp" {
  email = var.smtp_email
   
}
#If using domain verification
#resource "aws_ses_domain_identity" "staging_smtp" {
#  domain = var.smtp_email
#}

##Create IAM user with smtp access
resource "aws_iam_user" "smtp_user" {
  name = "gk_smtp_user"
   
}

resource "aws_iam_access_key" "smtp_user" {
  user = aws_iam_user.smtp_user.name
   
}

data "aws_iam_policy_document" "ses_sender" {
  statement {
    actions   = ["ses:SendEmail", "ses:SendRawEmail"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "ses_sender" {
  name        = "gk_ses_sender"
  description = "Allows sending of e-mails via Simple Email Service"
  policy      = data.aws_iam_policy_document.ses_sender.json
   
}

resource "aws_iam_user_policy_attachment" "ses_attach" {
  user       = aws_iam_user.smtp_user.name
  policy_arn = aws_iam_policy.ses_sender.arn
   
}

