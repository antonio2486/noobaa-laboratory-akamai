
# Enable required APIs
resource "google_project_service" "storage_api" {
  project = var.gcp_projectid
  service = "storage.googleapis.com"
}

# random suffix to avoid global-name collisions
resource "random_id" "gcs_suffix" {
  byte_length = 4
}

# GCP Storage Bucket (Private)
resource "google_storage_bucket" "noobaa_storage_b" {
  name                        = "noobaa-storage-b-${random_id.gcs_suffix.hex}" # make sure it is unique
  location                    = var.gcp_region
  project                     = var.gcp_projectid
  uniform_bucket_level_access = true
  
  versioning {
    enabled = true
  }

  lifecycle_rule {
    condition {
      age = 365
    }
    action {
      type = "Delete"
    }
  }

  # Make bucket private
  public_access_prevention = "enforced"

  labels = {
    environment = "lab"
    project     = "noobaa"
    storage     = "b"
  }

  depends_on = [google_project_service.storage_api]
}

#-----Creation of the Akamai Object Storage--------------#

#creation of the data cluster store



# Linode Object Storage Bucket (for Akamai region)
resource "linode_object_storage_bucket" "noobaa_storage_a" {
  region     = var.region
  label      = "noobaa-storage-a"
  versioning = true
}