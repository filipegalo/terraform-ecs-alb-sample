# Project Specific

variable "project_name" {
  type = string
}

variable "tags" {
  type = map(string)
}

# Folder Specific

variable "repositories" {
  type = set(string)
}
