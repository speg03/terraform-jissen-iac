variable "vpc_cidr_block" {
  type        = string
  default     = "10.0.0.0/16"
  description = "VPCに割り当てるCIDRブロックを記述します"

  validation {
    condition     = can(cidrhost(var.vpc_cidr_block, 0))
    error_message = "Specify a valid IPv4 CIDR block (e.g., 10.0.0.0/16)."
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
    error_message = "The key names 'Name' and 'Env' are reserved and cannot be used."
  }
}
