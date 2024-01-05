project_name   = "gk-ott"
aws_region     = "ap-south-1"

build_server = [{ ec2_type = "t2.medium", volume_size = "30" }]

db_server = [{ ec2_type = "t2.medium", volume_size = "10" }]

keypair_name = "gk-staging"

smtp_email = "gokul0129@gmail.com"
