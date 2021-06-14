
variable "secret_service_principal_password" {
    type    = string
    default = "{{ secret_service_principal_password }}"
}

variable "secret_tenant_id" {
    type    = string
    default = "{{ secret_tenant_id }}"
}

variable "secret_subscription_id" {
    type    = string
    default = "{{ secret_subscription_id }}"
}
