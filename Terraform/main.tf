terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}

variable "kubeconfig_path" {
  description = "Path to the kubeconfig file"
  type        = string
  default     = "/home/cheikh/.kube/config"
}

provider "kubernetes" {
  config_path = var.kubeconfig_path
}

# Terraform provisionne uniquement le cluster Kubernetes ici
# Les déploiements et services Kubernetes seront gérés par Ansible

output "kube_config" {
  value     = file(var.kubeconfig_path)
  sensitive = true
}
