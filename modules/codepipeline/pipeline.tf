resource "aws_codepipeline" "codepipeline" {
    name = "${var.common.env}-${var.common.project}-pipeline"
    
}