resource "aws_db_instance" "db" {
  identifier = "${var.common.env}-${var.common.project}-${var.rds_name}"
  allocated_storage = var.rds_strorage
  engine = var.rds_engine
  engine_version = var.rds_engine_version
  instance_class = var.rds_class
  username = jsondecode(data.aws_secretsmanager_secret_version.ugc_secret_version.secret_string)["username"]
  password = jsondecode(data.aws_secretsmanager_secret_version.ugc_secret_version.secret_string)["password"]
  db_name = var.rds_name
  port = var.rds_port
  parameter_group_name = aws_db_parameter_group.db_parameter_group.name
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.sg_db.id]
  skip_final_snapshot  = true // dont create snapshot before deleted
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]
  # create_cloudwatch_log_group = true
  # cloudwatch_log_group_retention_in_days = 7
  backup_retention_period = "7"
  backup_window = "00:30-01:30"
  maintenance_window = "sat:04:30-sat:05:30"
}

// information for secret manager
data "aws_secretsmanager_secret" "ugc_secret_dev" {
  name = "ugc_secret_dev"
}

// get data of secret manager
data "aws_secretsmanager_secret_version" "ugc_secret_version" {
  secret_id = data.aws_secretsmanager_secret.ugc_secret_dev.id
}

resource "aws_security_group_rule" "sg_rule_rds" {
  type = "ingress"
  from_port = var.rds_port
  to_port = var.rds_port
  protocol = "TCP"
  cidr_blocks = ["0.0.0.0/0"]
  #source_security_group_id = var.network.sg_container
  security_group_id = aws_security_group.sg_db.id
}

resource "aws_security_group" "sg_db" {
  name = "${var.common.env}-${var.common.project}-${var.rds_name}-sg"
  vpc_id = var.network.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_parameter_group" "db_parameter_group" {
    name = "${var.common.env}-${var.common.project}-${var.rds_name}"
    family = var.rds_family
}

resource "aws_db_subnet_group" "db_subnet_group" {
    name = "${var.common.env}-${var.common.project}-${var.rds_name}"
    subnet_ids = var.network.subnet_ids
}

#########S3 FOR ARCHIVED LOG ###################
resource "aws_s3_bucket" "s3" {
  bucket = "${var.common.env}-${var.common.project}-${var.rds_name}-logs"
}

resource "aws_s3_bucket_policy" "allow_access_resource" {
  bucket = aws_s3_bucket.s3.id
  policy = data.aws_iam_policy_document.allow_access_resource.json
}

data "aws_iam_policy_document" "allow_access_resource" {
  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["arn:aws:s3:::${var.common.env}-${var.common.project}-${var.rds_name}-logs"]
    actions   = ["s3:GetBucketAcl"]

    principals {
      type        = "Service"
      identifiers = ["logs.us-east-1.amazonaws.com"]
    }
  }

  statement {
    sid       = ""
    effect    = "Allow"
    resources = ["arn:aws:s3:::${var.common.env}-${var.common.project}-${var.rds_name}-logs/*"]
    actions   = ["s3:PutObject"]

    principals {
      type        = "Service"
      identifiers = ["logs.us-east-1.amazonaws.com"]
    }
  }
}

output "dev_postgresql_log" {
  value = "/aws/rds/instance/${aws_db_instance.db.identifier}/postgresql"
}

output "dev_rds_s3_logs" {
  value = aws_s3_bucket.s3.bucket
}