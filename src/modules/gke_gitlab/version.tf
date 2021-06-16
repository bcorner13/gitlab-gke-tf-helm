terraform {
  required_version = ">= 0.12.0"
  required_providers {
    helm = {version="~> 0.10"}
    google = {
      source = "hashicorp/google"
      version = "~> 3.70.0"
    }
    google-beta = {
      source = "hashicorp/google-beta"
      version = "~> 3.70.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 2.3.1"
    }
    null = {
      source = "hashicorp/null"
      version = "~> 3.1.0"
    }

    random = {
      source = "hashicorp/random"
      version = "~> 3.1.0"
    }
    template = {
      source = "hashicorp/template"
      version = "~> 2.2.0"
    }
  }
}
