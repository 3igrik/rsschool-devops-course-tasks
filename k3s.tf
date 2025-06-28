resource "aws_instance" "k3s_server" {
  ami             = var.bastion_ami
  instance_type   = var.bastion_instance_type
  subnet_id       = aws_subnet.public_subnet_1.id
  key_name        = var.ssh_key_name
  security_groups = [aws_security_group.k3s_sg.id]
  user_data       = <<-EOF
    #!/bin/bash
    curl -sfL https://get.k3s.io | sh -
    sudo systemctl enable k3s
    sudo systemctl start k3s
    EOF
  tags = {
    Name = "k3s-server"
  }
}

output "k3s_public_ip" {
  description = "Public IP of the k3s server"
  value       = aws_instance.k3s_server.public_ip
}