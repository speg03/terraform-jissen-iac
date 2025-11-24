variable "excluded_az_names" {
  description = "List of AZ names to exclude (e.g., obsolete or unavailable zones)."
  type        = list(string)
  default     = ["ap-northeast-1b"]
}

data "aws_availability_zones" "availability_zones" {
  state = "available"

  # 除外するアベイラビリティゾーン名（デフォルト: ap-northeast-1b、必要に応じて変更可能）
  exclude_names = var.excluded_az_names
}

locals {
  # 利用可能かつ除外されていないアベイラビリティゾーンの数
  number_of_availability_zones = length(data.aws_availability_zones.availability_zones.names)
}
