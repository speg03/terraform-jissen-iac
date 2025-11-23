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

variable "subnet_cidrs" {
  description = "サブネットごとのCIDRリスト"
  type = object({
    public  = list(string)
    private = list(string)
  })

  validation {
    condition = (
      length(
        setintersection(
          [for cidr in var.subnet_cidrs.public : can(cidrhost(cidr, 0)) ? cidr : null],
          var.subnet_cidrs.public
        )
      ) == length(var.subnet_cidrs.public)
    )
    error_message = "Specify VPC Public Subnet CIDR block with the CIDR format."
  }

  validation {
    condition = (
      length(
        setintersection(
          [for cidr in var.subnet_cidrs.private : can(cidrhost(cidr, 0)) ? cidr : null],
          var.subnet_cidrs.private
        )
      ) == length(var.subnet_cidrs.private)
    )
    error_message = "Specify VPC Private Subnet CIDR block with the CIDR format."
  }

  # 可用性のためのバリデーション（パブリック、プライベートで複数サブネットを作成）
  validation {
    condition     = length(var.subnet_cidrs.public) >= 2
    error_message = "For availability, set more than or equal to 2 public subnet cidrs."
  }
  validation {
    condition     = length(var.subnet_cidrs.private) >= 2
    error_message = "For availability, set more than or equal to 2 private subnet cidrs."
  }

  # publicとprivateの配列長が同じことを確認するバリデーション
  validation {
    condition     = length(var.subnet_cidrs.public) == length(var.subnet_cidrs.private)
    error_message = "Redundancy of public subnet and private subnet must be same."
  }
}

variable "subnet_additional_tags" {
  description = "サブネットに付与したい追加タグ（Name, Env, AvailabilityZone, Scope 除く）"
  type        = map(string)
  default     = {}
  validation {
    condition = (
      length(
        setintersection(
          keys(var.subnet_additional_tags),
          ["Name", "Env", "AvailabilityZone", "Scope"]
        )
      ) == 0
    )
    error_message = "Key names, Name and Env, AvailabilityZone, Scope are reserved. Not allowed to use them."
  }
}

variable "igw_additional_tags" {
  description = "インターネットゲートウェイに付与したい追加タグ（Name, Env, VpcId 除く）"
  type        = map(string)
  default     = {}

  validation {
    condition = (
      length(
        setintersection(
          keys(var.igw_additional_tags),
          ["Name", "Env", "VpcId"]
        )
      ) == 0
    )
    error_message = "Key names, Name and Env, VpcId are reserved. Not allowed to use them."
  }
}
