resource "aws_key_pair" "auth_key" {

  key_name   = "${var.project_name}-${var.project_env}-publickey"
  public_key = file("zomatokey.pub")
  tags = {
    Name = "${var.project_name}-${var.project_env}-publickey"
  }


}

resource "aws_security_group" "sg_webserver_access" {

  name        = "${var.project_name}-${var.project_env}-webserver-access"
  description = "Allowing http and https connections"
  tags = {
    Name = "${var.project_name}-${var.project_env}-webserver-access"
  }

}

resource "aws_security_group_rule" "sg_rules" {

  count             = length(var.sg_ingress_ports)
  security_group_id = aws_security_group.sg_webserver_access.id
  type              = "ingress"
  from_port         = var.sg_ingress_ports["${count.index}"]
  to_port           = var.sg_ingress_ports["${count.index}"]
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]

}
