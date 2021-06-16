variable "project_id" {
  description = "The project ID to deploy to"
}

variable "certmanager_email" {
  description = "Email used to retrieve SSL certificates from Let's Encrypt"
}
variable "deletion_protection" {
  type = string
  description = "Protect instance from deletion."
  default = true
}
