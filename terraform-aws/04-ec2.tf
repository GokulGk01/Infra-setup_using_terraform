#AMI Lookup for Ubuntu Minimal, 20.04 LTS, amd64 focal image
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu-minimal/images/hvm-ssd/ubuntu-focal-20.04-amd64-minimal-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

#Build Server with EIP
resource "aws_instance" "build_server" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.build_server[0].ec2_type
  key_name                    = aws_key_pair.ec2_key.id
  vpc_security_group_ids      = [aws_security_group.buildserver_sg.id]
  subnet_id                   = aws_subnet.staging_subnet_1.id
  associate_public_ip_address = true

  root_block_device {
    volume_type           = "gp3"
    volume_size           = var.build_server[0].volume_size
    delete_on_termination = true
  }

  tags = merge(var.tags, {
    Name    = "Staging Build Server-${var.project_name}"
  })
}

resource "aws_eip" "buildserver_eip" {
  vpc      = true
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.build_server.id
  allocation_id = aws_eip.buildserver_eip.id
}

#DB Server
resource "aws_instance" "db_server" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.db_server[0].ec2_type
  key_name                    = aws_key_pair.ec2_key.id
  vpc_security_group_ids      = [aws_security_group.db_server_sg.id]
  subnet_id                   = aws_subnet.staging_subnet_1.id
  associate_public_ip_address = true

  root_block_device {
    volume_type           = "gp3"
    volume_size           = var.db_server[0].volume_size
    delete_on_termination = true
  }

  tags = merge(var.tags, {
    Name    = "Staging DB Server-${var.project_name}"
  })
}


#Ansible inventory file
resource "local_file" "inventory" {
  filename = "../ansible/hosts.ini"
  file_permission      = "0644"
  content  = <<EOF
[buildserver]
${aws_eip_association.eip_assoc.public_ip}

[dbserver]
${aws_instance.db_server.public_ip}

[all:vars]
ansible_user = ubuntu
ansible_ssh_private_key_file = ${var.keypair_name}.pem
EOF
}

#KeyPair generation for EC2
resource "aws_key_pair" "ec2_key" {
  key_name   = "${var.project_name}-staging_ec2_key"
  public_key = tls_private_key.rsa.public_key_openssh
}
resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "local_file" "ec2_key" {
  content  = tls_private_key.rsa.private_key_pem
  file_permission      = "0400"
  filename = "../ansible/${var.keypair_name}.pem"
}

resource "local_file" "varsfile" {
  filename = "../ansible/group_vars/aws.yml"
  file_permission      = "0644"
  content  = <<EOF
---
aws_access_key: "${aws_iam_access_key.staging_user.id}"
aws_secret_key: "${aws_iam_access_key.staging_user.secret}"
aws_region: "${var.aws_region}"
aws_s3_bucket: "${aws_s3_bucket.s3_bucket.id}"
cloudfront_url: "${aws_cloudfront_distribution.s3_distribution.domain_name}"
aws_iam_role: "${aws_iam_role.media_convert_role.arn}"
aws_mc_queue: "${aws_media_convert_queue.media_convert_queue.arn}"
smtp_access_key: "${aws_iam_access_key.smtp_user.id}"
smtp_secret_key: "${aws_iam_access_key.smtp_user.ses_smtp_password_v4}"
smtp_email: "${var.smtp_email}"
db_private_ip: "${aws_instance.db_server.private_ip}"
EOF
}

