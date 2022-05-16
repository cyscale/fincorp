output "username" {
  value = aws_iam_user.playground.name
}

output "password" {
  value     = aws_iam_user_login_profile.playground.encrypted_password
  sensitive = true
}

output "secret" {
  value     = aws_iam_access_key.playground.encrypted_secret
  sensitive = true
}

output "instance_profile" {
  value = aws_iam_instance_profile.ec2_profile.name
}
