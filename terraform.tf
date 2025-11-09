terraform {
  backend "s3" {
    bucket = "speg03-sandbox-terraform-state-sample-bucket"
    key    = "090_vpc/vpc.tfstate"
    region = "ap-northeast-1"
  }
}
