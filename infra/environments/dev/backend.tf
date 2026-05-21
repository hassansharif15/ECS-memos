terraform {
  backend "s3" {
    bucket         = "memos-tfstate-devopsbyhassan-eu-west-2"
    key            = "memos/dev/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "memos-terraform-locks"
    encrypt        = true
  }
}