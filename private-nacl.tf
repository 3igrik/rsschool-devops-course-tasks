resource "aws_network_acl" "private_nacl" {
  vpc_id = aws_vpc.main.id
  subnet_ids = [
    aws_subnet.private_subnet_1.id,
    aws_subnet.private_subnet_2.id
  ]
  tags = {
    Name = "private-nacl"
  }
}

resource "aws_network_acl_rule" "private_nacl_ingress_ssh" {
  network_acl_id = aws_network_acl.private_nacl.id
  rule_number    = 100
  protocol       = "tcp"
  rule_action    = "allow"
  egress         = false
  cidr_block     = aws_subnet.public_subnet_1.cidr_block
  from_port      = 22
  to_port        = 22
}

resource "aws_network_acl_rule" "private_nacl_ingress_vpc" {
  network_acl_id = aws_network_acl.private_nacl.id
  rule_number    = 110
  protocol       = "-1"
  rule_action    = "allow"
  egress         = false
  cidr_block     = var.vpc_cidr
  from_port      = 0
  to_port        = 0
}

resource "aws_network_acl_rule" "private_nacl_egress_all" {
  network_acl_id = aws_network_acl.private_nacl.id
  rule_number    = 100
  protocol       = "-1"
  rule_action    = "allow"
  egress         = true
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 0
}