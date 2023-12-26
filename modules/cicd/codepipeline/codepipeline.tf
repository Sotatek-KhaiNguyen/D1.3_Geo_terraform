resource "aws_codepipeline" "pipeline" {
  name = "${var.common.env}-${var.common.project}-${var.name}"
  role_arn = var.pipeline.role_codepipeline

  artifact_store {
    location = var.pipeline.pipeline_bucket
    type = "S3"
  }

  stage {
    name = "Source"
    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["SourceArtifact"]

      configuration = {
        ConnectionArn = var.git_url
        FullRepositoryId = var.repo
        BranchName = var.branch
      }
    }
  }

  stage {
    name = "Build"
    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["SourceArtifact"]
      output_artifacts = ["BuildArtifact"]
      version          = "1"
      configuration = {
        ProjectName = "${var.common.env}-${var.common.project}-${var.name}"
      }
    }
  }

  stage {
    name = "Deploy"
    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "ECS"
      input_artifacts = ["BuildArtifact"]
      version         = "1"
      configuration = {
        ClusterName = "${var.common.env}-${var.common.project}"
        FileName = "${var.common.project}_${var.name}.json"
        ServiceName = "${var.common.env}-${var.common.project}"
      }
    }
  }
}
