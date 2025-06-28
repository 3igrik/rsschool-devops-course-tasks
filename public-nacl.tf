resource "aws_network_acl" "public_nacl" {
  vpc_id = aws_vpc.main.id
  subnet_ids = [
    aws_subnet.public_subnet_1.id,
    aws_subnet.public_subnet_2.id
  ]
  tags = {
    Name = "public-nacl"
  }
}

resource "aws_network_acl_rule" "public_nacl_ingress_ssh" {
  network_acl_id = aws_network_acl.public_nacl.id
  rule_number    = 100
  protocol       = "tcp"
  rule_action    = "allow"
  egress         = false
  cidr_block     = var.allowed_ssh_cidr
  from_port      = 22
  to_port        = 22
}

resource "aws_network_acl_rule" "public_nacl_ingress_k3s" {
  network_acl_id = aws_network_acl.public_nacl.id
  rule_number    = 111
  protocol       = "tcp"
  rule_action    = "allow"
  egress         = false
  cidr_block = var.allowed_ssh_cidr
  from_port  = 6443
  to_port    = 6443
}

resource "aws_network_acl_rule" "public_nacl_ingress_ephemeral" {
  network_acl_id = aws_network_acl.public_nacl.id
  rule_number    = 110
  protocol       = "tcp"
  rule_action    = "allow"
  egress         = false
  cidr_block     = "0.0.0.0/0"
  from_port      = 1024
  to_port        = 65535
}

resource "aws_network_acl_rule" "public_nacl_egress_all" {
  network_acl_id = aws_network_acl.public_nacl.id
  rule_number    = 100
  protocol       = "-1"
  rule_action    = "allow"
  egress         = true
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 0
}