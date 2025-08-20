
locals {
  
  # Kubernetes configuration
  kube_config_path = "${path.root}/.kube/config"
}

# LKE Cluster
resource "linode_lke_cluster" "noobaa_lke" {
  label       = var.cluster_label
  k8s_version = var.k8s_version
  region      = var.region
  tags        = ["noobaa", "lab"]

  pool {
    type       = var.lke_node_type
    count      = var.lke_node_count
    autoscaler {
      min = var.lke_node_count
      max = var.lke_node_count_max
    }
  }
}


# Create .kube directory and save kubeconfig
resource "local_file" "kubeconfig" {
  content         = base64decode(linode_lke_cluster.noobaa_lke.kubeconfig)
  filename        = local.kube_config_path
  file_permission = "0600"
  
  depends_on = [linode_lke_cluster.noobaa_lke]
}