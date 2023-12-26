resource "aws_elasticache_cluster" "redis" {
  cluster_id = "${var.common.env}-${var.common.project}"
  node_type = var.node_type
  num_cache_nodes = var.num_cache_nodes
  port = var.port
  engine = var.redis_engine_version
  subnet_group_name = aws_elasticache_subnet_group.cache_subnet_group.name
  security_group_ids = [aws_security_group.sg_redis.id]
}

resource "aws_elasticache_subnet_group" "cache_subnet_group" {
    name = "${var.common.env}-${var.common.project}"
    subnet_ids = var.network.subnet_ids
}

resource "aws_security_group_rule" "sg_rule_redis" {
  type = "ingress"
  from_port = var.port
  to_port = var.port
  protocol = "TCP"
  source_security_group_id = var.network.sg_container
  security_group_id = aws_security_group.sg_redis.id
}

resource "aws_security_group" "sg_redis" {
  name = "${var.common.env}-${var.common.project}-sg-redis"
  vpc_id = var.network.vpc_id_private

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}