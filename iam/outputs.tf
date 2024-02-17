output "role_get_all_authors_arn" {
  value = aws_iam_role.get_all_authors_lambda_role.arn
}

output "role_get_all_courses_arn" {
  value = aws_iam_role.get_all_courses_lambda_role.arn
}

output "role_get_course_arn" {
  value = aws_iam_role.get_course_lambda_role.arn
}