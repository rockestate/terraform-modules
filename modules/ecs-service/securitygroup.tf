resource "aws_security_group" "ecs-service" {
  name        = var.application_name
  vpc_id      = var.vpc_id
  description = var.application_name

  dynamic ingress {
    for_each = var.ingress_rules
    content {
      from_port       = ingress.value.from_port
      to_port         = ingress.value.to_port
      protocol        = ingress.value.protocol
      security_groups = ingress.value.security_groups
      cidr_blocks     = try(ingress.value.cidr_blocks, [])
      description     = try(ingress.value.description, "")
      prefix_list_ids = try(ingress.value.prefix_list_ids, [])
      self            = try(ingress.value.self, false)
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}