
locals {
  external_secrets_version = "0.8.1"
}

data "http" "external_secrets_fetch_raw_crds" {
  url = "https://raw.githubusercontent.com/external-secrets/external-secrets/v${local.external_secrets_version}/deploy/crds/bundle.yaml"
}

data "kubectl_file_documents" "external_secrets_raw_docs" {
  content = data.http.external_secrets_fetch_raw_crds.response_body
}

resource "kubectl_manifest" "external_secrets_apply_raw_crds" {
    for_each  = data.kubectl_file_documents.external_secrets_raw_docs.manifests
    yaml_body = each.value
}


resource "helm_release" "external_secrets" {
  name             = "external-secrets"
  version          = "${local.external_secrets_version}"
  namespace        = "external-secrets"

  repository       = "https://charts.external-secrets.io"
  chart            = "external-secrets"
  create_namespace = true

  set {
    name = "installCRDs"
    value = false
  }

  set {
    name = "resources.limits.cpu"
    value = "100m"
  }

  set {
    name = "resources.limits.memory"
    value = "512Mi"
  }

  set {
    name = "resources.requests.cpu"
    value = "10m"
  }

  set {
    name = "resources.requests.memory"
    value = "128Mi"
  }

  set {
    name = "certController.resources.limits.cpu"
    value = "100m"
  }

  set {
    name = "certController.resources.limits.memory"
    value = "512Mi"
  }

  set {
    name = "certController.resources.requests.cpu"
    value = "10m"
  }

  set {
    name = "certController.resources.requests.memory"
    value = "128Mi"
  }

  set {
    name = "webhook.resources.limits.cpu"
    value = "100m"
  }

  set {
    name = "webhook.resources.limits.memory"
    value = "512Mi"
  }

  set {
    name = "webhook.resources.requests.cpu"
    value = "10m"
  }

  set {
    name = "webhook.resources.requests.memory"
    value = "128Mi"
  }

}