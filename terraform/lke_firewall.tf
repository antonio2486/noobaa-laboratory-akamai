# Cloud Firewall for LKE Security
resource "linode_firewall" "noobaa_lke_firewall" {
  label = "${var.cluster_label}-firewall"
  tags  = ["noobaa", "lke", "firewall"]

  # Default policies
  inbound_policy  = "DROP"
  outbound_policy = "ACCEPT"

  # Inbound rules for LKE cluster communication
  inbound {
    label    = "kubelet-health-checks"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "10250"
    ipv4     = ["192.168.128.0/17"]
  }

  inbound {
    label    = "wireguard-tunnel"
    action   = "ACCEPT"
    protocol = "UDP"
    ports    = "51820"
    ipv4     = ["192.168.128.0/17"]
  }

  inbound {
    label    = "calico-bgp"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "179"
    ipv4     = ["192.168.128.0/17"]
  }

  # NodePort services - restricted to admin IP
  inbound {
    label    = "nodeport-services"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "30000-32767"
    ipv4     = [var.admin_ip]
  }

  inbound {
    label    = "nodeport-services-udp"
    action   = "ACCEPT"
    protocol = "UDP"
    ports    = "30000-32767"
    ipv4     = [var.admin_ip]
  }

  # SSH access for administration
  inbound {
    label    = "ssh-admin"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "22"
    ipv4     = [var.admin_ip]
  }

  # HTTPS traffic - restricted to admin IP
  inbound {
    label    = "https-traffic"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "443"
    ipv4     = [var.admin_ip]
  }

  # HTTP traffic - restricted to admin IP
  inbound {
    label    = "http-traffic"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "80"
    ipv4     = [var.admin_ip]
  }

  # NooBaa specific ports (S3 API) - restricted to admin IP
  inbound {
    label    = "noobaa-s3-api"
    action   = "ACCEPT"
    protocol = "TCP"
    ports    = "8080,8443"
    ipv4     = [var.admin_ip]
  }


  # Apply to LKE cluster nodes
  //linodes = linode_lke_cluster.noobaa_lke.pool[0].nodes[*].instance_id

  depends_on = [linode_lke_cluster.noobaa_lke]
}