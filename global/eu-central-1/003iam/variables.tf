# Project Specific

variable "project_name" {
  type = string
}

variable "tags" {
  type = map(string)
}

# Folder Specific

variable "repository" {
  type = string
}

variable "branch" {
  type = string
}

variable "region" {
  type = string
}
