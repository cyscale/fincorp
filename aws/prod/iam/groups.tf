resource "aws_iam_group" "devs" {
  name = "developers"
}

resource "aws_iam_group_membership" "devs" {
  name = "devs-membership"

  users = [
    aws_iam_user.playground.name,
  ]

  group = aws_iam_group.devs.name
}

resource "aws_iam_group_policy_attachment" "devs-policy" {
  group      = aws_iam_group.devs.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}
