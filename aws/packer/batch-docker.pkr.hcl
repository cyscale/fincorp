source "docker" "nginx" {
  image  = "nginx"
  commit = true
}

build {
  name = "batch"
  sources = [
    "source.docker.nginx"
  ]

  post-processors {
    post-processor "docker-tag" {
      repository = "${var.ecr_uri}/batch"
      tags       = ["1.0", "latest"]
    }

    post-processor "docker-push" {
      ecr_login    = true
      login_server = "https://${var.ecr_uri}/"
    }
  }
}
