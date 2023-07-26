variable "ibmcloud_api_key_demo" {
  description = "APIkey that's associated with the account to use."
  type        = string
  sensitive   = true
}

variable "ibm_region" {
  type = string
  default = "us-south"
}

variable "cloudant_instance" {
  type = string
  default = "cloudant-instance"
}
