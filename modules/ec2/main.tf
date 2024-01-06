# create a data source to get the latest ubuntu 20.04 LTS AMI ID for the region

data "aws_ami" "ubuntu" {
  most_recent             = true
  owners                  = ["099720109477"] # Canonical

  filter {
    name                  = "name"
    values                = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name                  = "virtualization-type"
    values                = ["hvm"]
  }

  filter {
    name                  = "root-device-type"
    values                = ["ebs"]
  }

  filter {
    name                  = "architecture"
    values                = ["x86_64"]
  }
}

##############################################################

# create a PEM openSSH key pair for the EC2 instances

resource "tls_private_key" "rsa-key" {
  algorithm               = "RSA"
  rsa_bits                = 4096
}

# create the keypair in aws

resource "aws_key_pair" "rsa-key" {
  key_name                = "${var.project-name}-key"
  public_key              = tls_private_key.rsa-key.public_key_openssh
}

# save the private key on the local filesystem

resource "local_file" "rsa-key" {
  content                 = tls_private_key.rsa-key.private_key_pem
  filename                = "${var.project-name}-key.pem"
}

##############################################################

# create 3 EC2 instances in the 3 subnets

resource "aws_instance" "ec2" {
  count                   = 3

  ami                     = data.aws_ami.ubuntu.id
  instance_type           = var.instance_type
  key_name                = aws_key_pair.rsa-key.key_name
  subnet_id               = element(var.subnet_ids, count.index)
  vpc_security_group_ids  = [var.public-instance-sg-id]

  tags                    = {
    Name                  = "${var.project-name}-ec2-${count.index}"
  }
}

##############################################################

# export public IPs of the EC2 instances to a local variable
locals {
  host-ips                = aws_instance.ec2.*.public_ip
}

##############################################################

# create a null resource to generate an ansible inventory file

resource "null_resource" "ansible_inventory" {
  depends_on = [aws_instance.ec2]

  provisioner "local-exec" {
    command = "echo '[ec2-hosts]' > ../ansible/host-inventory.ini && echo '${join("\n", local.host-ips)}' >> ../ansible/host-inventory.ini"
  }
}