provider "google" {
  project = var.project_id
}

provider "google-beta" {
  project = var.project_id
}

data "google_container_cluster" "gitlab" {
  name     = "gitlab"
  location = "us-central1"
}

provider "kubernetes" {
  host                   = google_container_cluster.gitlab.endpoint
  token                  = data.google_client_config.provider.access_token
  client_certificate     = base64decode(google_container_cluster.gitlab.master_auth.0.client_certificate)
  client_key             = base64decode(google_container_cluster.gitlab.master_auth.0.client_key)
  cluster_ca_certificate = base64decode(google_container_cluster.gitlab.master_auth.0.cluster_ca_certificate)
}

provider "helm" {
  debug           = true
  kubernetes {
    host                   = google_container_cluster.gitlab.endpoint
    client_certificate     = base64decode(google_container_cluster.gitlab.master_auth.0.client_certificate)
    client_key             = base64decode(google_container_cluster.gitlab.master_auth.0.client_key)
    cluster_ca_certificate = base64decode(google_container_cluster.gitlab.master_auth.0.cluster_ca_certificate)
  }
}
