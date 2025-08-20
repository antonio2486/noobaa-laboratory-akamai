terraform {
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "= 3.0.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "linode" {
  token = var.linode_token
  obj_use_temp_keys = true
  #API token is assigned in the tfvars file
}

provider "google" {
  project     = var.gcp_projectid
  region      = var.gcp_region
  # Auth via  GOOGLE_APPLICATION_CREDENTIALS gcloud-cli
}