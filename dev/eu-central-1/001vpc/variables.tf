# Project Specific

variable "project_name" {
  type = string
}

variable "env" {
  type = string
}

variable "tags" {
  type = map(string)
}

# Folder Specific

variable "vpc_cidr" {
  type = string
}

variable "number_of_azs" {
  type = number
}

variable "enable_nat_gateway" {
  type = bool
}

variable "single_nat_gateway" {
  type = bool
}

