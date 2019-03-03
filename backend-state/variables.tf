variable "region" {
  description = "A região que será usada"
  type        = "string"
}

variable "profile" {
  description = "O profile que será usado"
  type        = "string"
}

variable "billing" {
  description = "A área de cobrança do custo"
  type        = "string"
}

variable "environment" {
  description = "O ambiente que será usado"
  type        = "string"
}

variable "backend-bucket" {
  description = "O nome do bucket S3 para armazenar o estado das execuções do terraform"
  type        = "string"
}
