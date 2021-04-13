variable "amis" {
  type = map(any)
  default = {
    "us-east-1" = "ami-08962a4068733a2b6"
    "us-east-2" = "ami-08962a4068733a2b6"
  }
}

variable "cdirs_acesso_remoto" {
  type    = list(any)
  default = ["191.19.70.50/32"]
}

variable "key_name" {
  default = "aws-kayan"
}
