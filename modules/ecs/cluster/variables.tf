variable "service_name" {
  description = "ECSクラスターを利用するサービス名"
  type        = string
}

variable "env" {
  description = "環境識別子 (dev, stg, prod)"
  type        = string

  validation {
    condition     = contains(["dev", "stg", "prod"], var.env)
    error_message = "The environment identifier must be one of the following: dev, stg, prod."
  }
}

variable "cluster_additional_tags" {
  description = "ECSクラスターに付与したい追加タグ"
  type        = map(string)
  default     = {}

  validation {
    condition = (
      length(
        setintersection(
          keys(var.cluster_additional_tags),
          ["ServiceName", "Env"]
        )
      ) == 0
    )
    error_message = "The key names 'ServiceName' and 'Env' are reserved and cannot be used."
  }
}
