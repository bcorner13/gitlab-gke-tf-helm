variable "project_id" {
  description = "The project ID to deploy to"
}

variable "certmanager_email" {
  description = "Email used to retrieve SSL certificates from Let's Encrypt"
}
# This variable turns off or on the protection from deletion feature. The
# default action of true means that this resource cannot be deleted without
# first changing this value to false and re-runing the terraform apply.
variable "deletion_protection" {
  type = string
  description = "Protect instance from deletion."
  default = true
}
