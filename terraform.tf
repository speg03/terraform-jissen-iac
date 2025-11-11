terraform {
  backend "s3" {
    bucket       = "speg03-sandbox-terraform-state-sample-bucket"
    key          = "terraform-state-sample.tfstate"
    region       = "ap-northeast-1"
    use_lockfile = true
  }
}
