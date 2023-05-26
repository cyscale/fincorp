resource "aws_iam_user" "playground" {
  name = "playground.user"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_iam_user_login_profile" "playground" {
  user            = aws_iam_user.playground.name
  password_length = 8
}

resource "aws_iam_access_key" "playground" {
  user = aws_iam_user.playground.name
}

resource "aws_iam_user_policy" "playground" {
  name = "test"
  user = aws_iam_user.playground.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
