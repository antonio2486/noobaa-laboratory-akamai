#--------Core Infrastructure Variables------------#                                              

variable "linode_token" {
  description = "Linode API token"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "Linode region for deployment"
  type        = string
  default     = "fr-par"
}

variable "root_pass" {
  description = "Root password for instances"
  type        = string
  sensitive   = true
}

variable "ssh_public_key" {
  description = "SSH public key for instance access"
  type        = string
}

variable "admin_ip" {
  description = "Admin IP address for firewall access (CIDR format, e.g., 1.2.3.4/32)"
  type        = string
}

# ------------LKE Cluster Variables -----------#                                                       

variable "k8s_version" {
  description = "Kubernetes version for the LKE cluster"
  type        = string
  default     = "1.33"
}

variable "cluster_label" {
  description = "Label for the LKE cluster"
  type        = string
  default     = "noobaa-lke"
}

variable "lke_node_type" {
  description = "Linode instance type for LKE worker nodes"
  type        = string
  default     = "g6-standard-4"
}

variable "lke_node_count" {
  description = "Number of worker nodes in the LKE cluster"
  type        = number
  default     = 4
}

variable "lke_node_count_max" {
  description = "Maximum number of worker nodes for autoscaling"
  type        = number
  default     = 6
}

# ------------Object Storage Variables -----------#

variable "gcp_projectid" {
  description = "GCP billing account ID for the project"
  type        = string
}

variable "gcp_region" {
  description = "GCP region for storage bucket"
  type        = string
  default     = "EUROPE-WEST8"
}