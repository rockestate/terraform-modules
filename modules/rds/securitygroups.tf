locals {
  port = contains(["mysql", "mariadb"], data.aws_rds_engine_version.rds_version.engine) ? 3306 : 5432
}
resource "aws_security_group" "rds" {
  name        = "${var.name}-rds"
  vpc_id      = var.vpc_id
  description = "${var.name}-rds"
}

resource "aws_security_group_rule" "rds_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.rds.id
}

resource "aws_security_group_rule" "rds_ingress_self" {
  count             = var.allow_self ? 1 : 0
  type              = "ingress"
  from_port         = local.port
  to_port           = local.port
  protocol          = "tcp"
  security_group_id = aws_security_group.rds.id
  self              = true
}
