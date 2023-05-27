source "docker" "httpd" {
  image  = "httpd:2.4.50-alpine"
  commit = true
}

build {
  name = "httpd"
  sources = [
    "source.docker.httpd"
  ]

  post-processors {
    post-processor "docker-tag" {
      repository = "${var.ecr_public_uri}/httpd"
      tags       = ["1.0", "latest"]
    }

    post-processor "docker-push" {
      ecr_login    = true
      login_server = "https://${var.ecr_public_uri}/"
    }
  }
}
