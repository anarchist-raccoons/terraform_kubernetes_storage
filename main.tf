provider "kubernetes" {
#  load_config_file = false
  host = var.host
  username = var.username
  password = var.password
  client_certificate = var.client_certificate
  client_key = var.client_key
  cluster_ca_certificate = var.cluster_ca_certificate
}

# Storage Class https://kubernetes.io/docs/concepts/storage/storage-classes/
# Creates a dynamic volume
resource "kubernetes_storage_class" "azure_file" {
  metadata {
    name = "ep-azurefile"
  }

  storage_provisioner = "kubernetes.io/azure-file"
  reclaim_policy = "Retain"
  parameters = {
    skuname = "Standard_LRS"
  }

}

resource "kubernetes_storage_class" "azure_disk" {
  metadata {
    name = "azuredisk"
  }

  storage_provisioner = "kubernetes.io/azure-disk"
  reclaim_policy = "Retain"
  parameters = {
    kind = "managed"
    storageaccounttype = "Standard_LRS"
  }

}
