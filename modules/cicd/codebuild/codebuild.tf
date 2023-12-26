resource "aws_codebuild_project" "codebuild" {
    name = "${var.common.env}-${var.common.project}-${var.name}"
    service_role = var.role_codebuild

    artifacts {
      type = "CODEPIPELINE"
    }

    source {
      type = "CODEPIPELINE"
      #buildspec = var.buildspec_url
    }

    environment {
      compute_type = "BUILD_GENERAL1_SMALL"
      image = "aws/codebuild/standard:6.0"
      type = "LINUX_CONTAINER"
      privileged_mode = false
    }

    # vpc_config {
    #   vpc_id = var.network.vpc_id
    #   subnets = var.network.subnet_ids
    #   security_group_ids = [var.network.sg_container]
    # }
    logs_config {
      cloudwatch_logs {
        status = "ENABLED"
      }
      s3_logs {
        encryption_disabled = false
        status = "DISABLED"
      }
    }
}