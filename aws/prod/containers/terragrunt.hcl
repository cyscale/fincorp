include "root" {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path  = "../networking"
  skip_outputs = true
}

dependency "iam" {
  config_path  = "../iam"
  skip_outputs = true
}
