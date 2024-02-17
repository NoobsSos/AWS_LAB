module "labels" {
  source  = "git::https://github.com/cloudposse/terraform-null-label.git?ref=0.25.0"
  name    = var.name
}

resource "aws_dynamodb_table" "this" {
  name         =  module.labels.id
  hash_key     = "id"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "id"
    type = "S"
  }
}