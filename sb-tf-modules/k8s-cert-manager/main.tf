
locals {
  cert_manager_version = "1.11.0"
}

data "http" "cert_manager_fetch_raw_crds" {
  url = "https://github.com/cert-manager/cert-manager/releases/download/v${local.cert_manager_version}/cert-manager.crds.yaml"
}

data "kubectl_file_documents" "cert_manager_raw_docs" {
  content = data.http.cert_manager_fetch_raw_crds.response_body
}

resource "kubectl_manifest" "cert_manager_apply_raw_crds" {
    for_each  = data.kubectl_file_documents.cert_manager_raw_docs.manifests
    yaml_body = each.value
}

resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  version    = "${local.cert_manager_version}"
  namespace  = "cert-manager"

  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"

  depends_on = [
    kubectl_manifest.cert_manager_apply_raw_crds
  ]
}