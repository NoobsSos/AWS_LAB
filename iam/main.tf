module "labels" {
  source  = "git::https://github.com/cloudposse/terraform-null-label.git?ref=0.25.0"
  name    = var.name
}

resource "aws_iam_role" "get_all_authors_lambda_role" {
    name = "${module.labels.id}-get-all-authors-lambda-role"
    assume_role_policy = jsonencode({
        Version = "2012-10-17",
        Statement = [
        {
            Action = "sts:AssumeRole",
            Effect = "Allow",
            Principal = {
            Service = "lambda.amazonaws.com"
            }
        }
        ]
    })
}

resource "aws_iam_policy" "get_all_authors_lambda_policy" {
    name = "${module.labels.id}-get-all-authors-lambda-policy"

    policy      = jsonencode({
        Version = "2012-10-17",
        Statement = [
        {
            Action = [
            "dynamodb:Scan",
            "dynamodb:Query",
            "dynamodb:GetItem",
            "dynamodb:PutItem",
            "dynamodb:UpdateItem",
            "dynamodb:DeleteItem"
            ],
            Effect   = "Allow",
            Resource = var.dynamodb_authors_arn
        }
        ]
    })
}

resource "aws_iam_role_policy_attachment" "get_all_authors_lambda_policy_attachment" {
    policy_arn = aws_iam_policy.get_all_authors_lambda_policy.arn
    role       = aws_iam_role.get_all_authors_lambda_role.name
}

resource "aws_iam_role" "get_all_courses_lambda_role" {
    name = "${module.labels.id}-get-all-courses-lambda-role"
    assume_role_policy = jsonencode({
        Version = "2012-10-17",
        Statement = [
        {
            Action = "sts:AssumeRole",
            Effect = "Allow",
            Principal = {
            Service = "lambda.amazonaws.com"
            }
        }
        ]
    })
}

resource "aws_iam_policy" "get_all_courses_lambda_policy" {
    name = "${module.labels.id}-get-all-courses-lambda-policy"

    policy      = jsonencode({
            Version = "2012-10-17",
            Statement = [
            {
            Action = [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
            ],
            Effect   = "Allow",
            Resource = "arn:aws:logs:*:*:*"
            },
            {
            Action = [
                "dynamodb:GetItem",
                "dynamodb:Scan",
            ],
            Effect   = "Allow",
            Resource = var.dynamodb_courses_arn
            }
        ]
    })
}

resource "aws_iam_role_policy_attachment" "get_all_courses_lambda_policy_attachment" {
    policy_arn = aws_iam_policy.get_all_courses_lambda_policy.arn
    role       = aws_iam_role.get_all_courses_lambda_role.name
}

resource "aws_iam_role" "get_course_lambda_role" {
    name = "${module.labels.id}-get-course-lambda-role"
    assume_role_policy = jsonencode({
        Version = "2012-10-17",
        Statement = [
        {
            Action = "sts:AssumeRole",
            Effect = "Allow",
            Principal = {
            Service = "lambda.amazonaws.com"
            }
        }
        ]
    })
}

resource "aws_iam_policy" "get_course_lambda_policy" {
    name = "${module.labels.id}-get-course-lambda-policy"

    policy      = jsonencode({
        Version = "2012-10-17",
        Statement = [
        {
            Action = [
            "dynamodb:GetItem",
            ],
            Effect   = "Allow",
            Resource = var.dynamodb_courses_arn
        }
        ]
    })
}

resource "aws_iam_role_policy_attachment" "get_course_lambda_policy_attachment" {
    policy_arn = aws_iam_policy.get_course_lambda_policy.arn
    role       = aws_iam_role.get_course_lambda_role.name
}
