resource "random_password" "db_admin_password" {
    length = 16
    special = true
    override_special = "_"
}

resource "aws_security_group" "rds_instance" {
  name        = "${var.environment_name}-${var.ecs_cluster_name}-rds-sg"
  description = "${var.environment_name}-${var.ecs_cluster_name}-rds-sg"
  vpc_id      = module.vpc.vpc_id
  tags = {
    Name      = "${var.environment_name}-${var.ecs_cluster_name}-rds-sg"
  }
}

resource "aws_security_group_rule" "mysql" {
  security_group_id        = aws_security_group.rds_instance.id
  description              = "TCP/5432 for ECS Instances"
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 5432
  to_port                  = 5432
  source_security_group_id = aws_security_group.ecs_instance.id
}

resource "aws_db_instance" "prod" {
    identifier             = "${var.platform_type}-${var.environment_name}-rds-instance"
    allocated_storage      = 20
    engine                 = "postgres"
    engine_version         = "11.6"
    instance_class         = var.rds_instance_type
    name                   = var.service_name_short
    username               = var.rds_admin_username
    password               = var.rds_admin_password
    db_subnet_group_name   = var.rds_subnet_group_name
#    parameter_group_name   = "default.mysql8.0"
    skip_final_snapshot    = true
    publicly_accessible    = false 
    vpc_security_group_ids = [aws_security_group.rds_instance.id]
    tags = {
        Name               = "${var.platform_type}-${var.environment_name}-rds-instance"
    }
}
