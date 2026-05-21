terraform {
  backend "s3" {
    bucket       = "memos-tfstate-devopsbyhassan-eu-west-2"
    key          = "memos/prod/terraform.tfstate"
    region       = "eu-west-2"
    encrypt      = true
    use_lockfile = true
  }
}
