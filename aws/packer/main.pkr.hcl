packer {
  required_plugins {
    docker = {
      version = ">= 1.0.8"
      source  = "github.com/hashicorp/docker"
    }
    amazon = {
      version = ">= 1.2.5"
      source  = "github.com/hashicorp/amazon"
    }
  }
}
