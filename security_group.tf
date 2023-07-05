resource "aws_security_group" "bastion_sg" {
  name        = "Bastion host"
  description = "Allow SSH access to bastion host and outbound internet access"
  vpc_id      = local.vpc_id

  ingress {
    description      = "ssh connection to bastion"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks       = var.allowed_hosts
    security_group_id = aws_security_group.bastion_sg.id
  }
  egress {
    protocol          = "-1"
    from_port         = 0
    to_port           = 0
    cidr_blocks       = ["0.0.0.0/0"]
    security_group_id = aws_security_group.bastion_sg.id
  }
  lifecycle {
    create_before_destroy = true
    ignore_changes = [ingress]
  }

  tags = var.tags
}
