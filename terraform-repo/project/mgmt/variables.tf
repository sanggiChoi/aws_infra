# VPC 이름을 넣어준다. 이 값은 VPC module이 생성하는 모든 리소스 이름의 prefix가 된다.
variable "name" {
  default = "mgmt"
}

variable "office_cidr_blocks" {
  type = "list"

  default = [
    "0.0.0.0/0",
  ] # 이 값은 실제 접속을 허용할 IP를 넣어야 함
}

variable "base-ami-tag" {
  description = "base-ami-tag"
  default     = "base-ami-packer"
}
