# Project Specific

variable "project_name" {
  type = string
}

variable "env" {
  type = string
}

variable "region" {
  type = string
}

variable "terraform_remote_state_bucket" {
  type = string
}

variable "tags" {
  type = map(string)
}

# Folder Specific

variable "service_port" {
  type = number
}

variable "service_health_check_path" {
  type = string
}
