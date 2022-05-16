terraform {
  cloud {
    organization = "fincorp"

    workspaces {
      name = "aws-prod-iam"
    }
  }
}
