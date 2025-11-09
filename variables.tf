variable "vpc_cidr_block" {
  type        = string
  default     = "10.0.0.0/16"
  description = "VPCに割り当てるCIDRブロックを記述します"

  validation {
    condition     = can(regex("^(\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\/\\d{1,2})$", var.vpc_cidr_block))
    error_message = "Specify VPC CIDR block with the CIDR format."
  }
}

variable "service_name" {
  type        = string
  description = "VPCを利用するサービス名"
}

variable "env" {
  type        = string
  description = "環境識別子 (dev, stg, prod)"

  validation {
    condition     = contains(["dev", "stg", "prod"], var.env)
    error_message = "The environment identifier must be one of the following: dev, stg, prod."
  }
}

variable "vpc_additional_tags" {
  description = "VPCに付与したい追加タグ"
  type        = map(string)
  default     = {}

  validation {
    condition = (
      length(
        setintersection(
          keys(var.vpc_additional_tags),
          ["Name", "Env"]
        )
      ) == 0
    )
    error_message = "Key names, Name and Env is reserved. Not allowed to use them."
  }
}
