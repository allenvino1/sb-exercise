terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
      version = "2.6.0"
    }
    http = {
      source = "hashicorp/http"
      version = "3.2.1"
    }

    kubectl = {
      source = "gavinbunney/kubectl"
      version = "1.14.0"
    }
  }
}