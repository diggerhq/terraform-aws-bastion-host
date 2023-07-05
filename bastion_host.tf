data "aws_ami" "amazon_linux_ami" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
}

data "aws_subnet" "public_subnet" {
  id = local.public_subnet_id
}

locals {
  vpc_id           = data.aws_subnet.public_subnet.vpc_id
  ami_id           = data.aws_ami.amazon_linux_ami.id
  disk_size        = var.disk_size
  public_subnet_id = var.subnet_id
  ssh_key          = var.ssh_key
  instance_type    = var.instance_type
}

resource "aws_instance" "bastion_instance" {
  ami                         = local.ami_id
  instance_type               = local.instance_type
  key_name                    = local.ssh_key
  subnet_id                   = local.public_subnet_id
  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]
  associate_public_ip_address = true

  root_block_device {
    volume_size           = local.disk_size
    delete_on_termination = true
  }

  lifecycle {
    ignore_changes = [ami]
  }

  tags = merge(var.tags, {"Name": var.instance_name})
}

