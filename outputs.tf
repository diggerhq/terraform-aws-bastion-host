output "public_ip" {
  value = aws_instance.bastion_instance.public_ip
}

output "private_ip" {
  value = aws_instance.bastion_instance.private_ip
}

output "instance_id" {
  value = aws_instance.bastion_instance.id
}

