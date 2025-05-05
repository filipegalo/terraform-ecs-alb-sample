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

variable "image_name" {
  type = string
}

variable "image_tag" {
  type = string
}

variable "total_cpu" {
  type = number
}

variable "total_memory" {
  type = number
}

variable "cpu" {
  type = number
}

variable "memory" {
  type = number
}

variable "port" {
  type = number
}

variable "environment" {
  type = map(string)
}
