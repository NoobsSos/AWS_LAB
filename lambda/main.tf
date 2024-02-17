module "labels" {
  source  = "git::https://github.com/cloudposse/terraform-null-label.git?ref=0.25.0"
  name    = var.name
  label_order = var.label_order
}

data "archive_file" "get_all_authors" {
  type        = "zip"
  source_file = "lambda/functions/get-all-authors/get-all-authors.js"
  output_path = "lambda/functions/get-all-authors/get-all-authors.zip"
}

resource "aws_lambda_function" "get_all_authors" {
  filename      = data.archive_file.get_all_authors.output_path
  function_name = "${module.labels.id}-get-all-authors"
  role          = var.get_all_authors_arn
  handler       = "get-all-authors.handler"

  source_code_hash = data.archive_file.get_all_authors.output_base64sha256

  runtime = "nodejs16.x"
  environment {
    variables = {
      "TABLE_NAME" = "authors"
    }
  }
}

