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

variable "rds_engine_version" {
  type = string
}

variable "family" {
  type = string
}

variable "major_engine_version" {
  type = string
}

variable "instance_class" {
  type = string
}

variable "allocated_storage" {
  type = number
}

variable "max_allocated_storage" {
  type = number
}

variable "multi_az" {
  type = string
}

variable "username" {
  type = string
}

variable "db_name" {
  type = string
}
