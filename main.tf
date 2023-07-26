terraform {
  required_version = ">= 1.3.0"
  required_providers {
    # Use "greater than or equal to" range in modules
    ibm = {
      source  = "ibm-cloud/ibm"
      version = ">= 1.53.0"
    }
  }
}

provider "ibm" {
  ibmcloud_api_key = var.ibmcloud_api_key_demo
  region           = var.ibm_region
}


resource ibm_cloudant "cloudant_instance" {
  name     = var.cloudant_instance
  location = var.ibm_region
  plan     = "lite"
  resource_group_id = "6243047856cb46f7b22c8e8bcffddb73"
  service_endpoints = "public-and-private"

}


resource ibm_resource_key "service_creds" {
    name = var.cloudant_instance
    role = "Writer"
    resource_instance_id = ibm_cloudant.cloudant_instance.id
  
}

resource "ibm_cloudant_database" "cloudant_database" {
    depends_on = [ ibm_cloudant.cloudant_instance, ibm_resource_key.service_creds ]
    instance_crn  = ibm_cloudant.cloudant_instance.id
    db            = "test-database"
}

locals {
  service_creds = jsondecode(ibm_resource_key.service_creds.credentials_json)
}

resource null_resource "perform_db_post" {
    depends_on = [ local.url , ibm_cloudant_database.cloudant_database ]
    provisioner "local-exec" {
    command = "bash test.sh ${local.service_creds["apikey"]} ${local.service_creds["url"]}"
    }
}
