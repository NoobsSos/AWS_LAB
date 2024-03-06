module "labels" {
  source  = "cloudposse/label/null"
  name    = var.name
  stage   = var.stage
}

data "archive_file" "get_all_authors" {
  type        = "zip"
  source_file = "lambda/functions/get-all-authors/get-all-authors.js"
  output_path = "lambda/functions/get-all-authors/get-all-authors.zip"
}

resource "aws_lambda_function" "get_all_authors" {
  filename      = data.archive_file.get_all_authors.output_path
  function_name = "get-all-authors-${module.labels.stage}-${module.labels.name}"
  role          = var.get_all_authors_arn
  handler       = "get-all-authors.handler"

  source_code_hash = data.archive_file.get_all_authors.output_base64sha256

  runtime = "nodejs16.x"
}

data "archive_file" "get_all_courses" {
  type        = "zip"
  source_file = "lambda/functions/get-all-courses/get-all-courses.js"
  output_path = "lambda/functions/get-all-courses/get-all-courses.zip"
}

resource "aws_lambda_function" "get_all_courses" {
  filename      = data.archive_file.get_all_courses.output_path
  function_name = "get-all-courses-${module.labels.stage}-${module.labels.name}"
  role          = var.get_all_courses_arn
  handler       = "get-all-courses.handler"

  source_code_hash = data.archive_file.get_all_courses.output_base64sha256

  runtime = "nodejs16.x"
}

data "archive_file" "get_course" {
  type        = "zip"
  source_file = "lambda/functions/get-course/get-course.js"
  output_path = "lambda/functions/get-course/get-course.zip"
}

resource "aws_lambda_function" "get_course" {
  filename      = data.archive_file.get_course.output_path
  function_name = "get-course-${module.labels.stage}-${module.labels.name}"
  role          = var.get_course_arn
  handler       = "get-course.handler"

  source_code_hash = data.archive_file.get_course.output_base64sha256

  runtime = "nodejs16.x"
}

data "archive_file" "save_course" {
  type        = "zip"
  source_file = "lambda/functions/save-course/save-course.js"
  output_path = "lambda/functions/save-course/save-course.zip"
}

resource "aws_lambda_function" "save_course" {
  filename      = data.archive_file.save_course.output_path
  function_name = "save-course-${module.labels.stage}-${module.labels.name}"
  role          = var.save_course_arn
  handler       = "save-course.handler"

  source_code_hash = data.archive_file.save_course.output_base64sha256

  runtime = "nodejs16.x"
}

data "archive_file" "update_course" {
  type        = "zip"
  source_file = "lambda/functions/update-course/update-course.js"
  output_path = "lambda/functions/update-course/update-course.zip"
}

resource "aws_lambda_function" "update_course" {
  filename      = data.archive_file.update_course.output_path
  function_name = "update-course-${module.labels.stage}-${module.labels.name}"
  role          = var.update_course_arn
  handler       = "update-course.handler"

  source_code_hash = data.archive_file.update_course.output_base64sha256

  runtime = "nodejs16.x"
}

data "archive_file" "delete_course" {
  type        = "zip"
  source_file = "lambda/functions/delete-course/delete-course.js"
  output_path = "lambda/functions/delete-course/delete-course.zip"
}

resource "aws_lambda_function" "delete_course" {
  filename      = data.archive_file.delete_course.output_path
  function_name = "delete-course-${module.labels.stage}-${module.labels.name}"
  role          = var.delete_course_arn
  handler       = "delete-course.handler"

  source_code_hash = data.archive_file.delete_course.output_base64sha256

  runtime = "nodejs16.x"
}

data "archive_file" "sns" {
  type        = "zip"
  source_file = "lambda/functions/sns-notify/sns-notify.js"
  output_path = "lambda/functions/sns-notify/sns-notify.zip"
}

resource "aws_lambda_function" "sns" {
  function_name =  "sns-notify-${module.labels.stage}-${module.labels.name}"
  filename      = data.archive_file.sns.output_path
  role          = var.sns_topic_arn
  handler       = "sns-notify.handler"

  source_code_hash = data.archive_file.sns.output_base64sha256

  runtime = "nodejs16.x"
}
