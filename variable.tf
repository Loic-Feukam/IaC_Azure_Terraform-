variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "tenant_id" {
  description = "Azure tenant ID"
  type        = string
}


variable "ssh_key_vm_prive" {
  type = string
  default = "~/.ssh/id_rsa.pub"
}


variable "ssh_key_vm_public" {
  type = string
  default = "~/.ssh/id_rsa.pub"
}

variable "vm-public" {
  type = string
  default = "vm-public"
}

variable "vm-prive" {
  type = string
  default = "vm-prive"
}

variable "nom" {
  type = string 
}