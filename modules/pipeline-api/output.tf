output "codepipeline_arn" {
  value = aws_codepipeline.codepipeline.arn
}
output "object_endpoint" {
  value = format("%s/%s/%s/metadata.zip",var.organization,var.gitRepo,var.gitBranch)
}