resource "aws_instance" "bastion" {
  ami             = var.bastion_ami
  instance_type   = var.bastion_instance_type
  subnet_id       = aws_subnet.public_subnet_1.id
  key_name        = var.ssh_key_name
  security_groups = [aws_security_group.bastion_sg.id]

  tags = {
    Name = "bastion-host"
  }
}