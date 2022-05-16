output "username" {
  value = aws_iam_user.playground.name
}

output "password" {
  value = aws_iam_user_login_profile.playground.encrypted_password
}

output "secret" {
  value = aws_iam_access_key.playground.encrypted_secret
}
