module "dynamo_db_authors" {
  source  = "./dynamodb"
  name    = "authors"
}

module "dynamo_db_courses" {
  source  = "./dynamodb"
  name    = "courses"
}

module "lambda" {
  source  = "./lambda"
  name    = "lambda"

  get_all_authors_arn = module.iam.role_get_all_authors_arn
}

module "iam" {
  source                = "./iam"
  name                  = "iam"
  dynamodb_authors_arn = module.dynamo_db_authors.dynamodb_arn
  dynamodb_courses_arn = module.dynamo_db_courses.dynamodb_arn
}