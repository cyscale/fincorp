source "amazon-ebs" "lamp" {
  ami_name      = "packer-lamp-amzn-ami"
  instance_type = "t2.micro"
  region        = "eu-west-1"
  source_ami_filter {
    filters = {
      name                = "amzn2-ami-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["amazon"]
  }
  ssh_username = "ec2-user"
  ami_groups   = ["all"]
}

build {
  sources = [
    "source.amazon-ebs.lamp"
  ]

  provisioner "shell" {
    inline = [
      "sudo yum update -y",
      "sudo amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2",
      "sudo yum install -y httpd-2.4.48-2.amzn2 mariadb-server",
    ]
  }
}
