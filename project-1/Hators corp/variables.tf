variable "resource_group_name" {
  description = "Resource group"
  type = string
}
variable "storage_account_name" {
  description = "state files storage_account"
  type = map(string)
}
variable "storage_account_container" {
  description = "state files storage account container"
  type = map(string)
}
# App service plan
variable "app_service_plan" {
  type = map(object({
    name = string
    os_type = string
    sku_name = string
    location = string
  }))
  description = "app_service_plans_information"
}
###webapp
variable "hotorscorp-webapp" {
  type = map(object({
    name = string
    app_service_plan = string
    repo_url = string
    branch = string
    type = string
    # token = string
 }))
 description = "hotorscorp webapps  information"
 
}
###VIRTUAL MACHINES
variable "linux_virtual_machine" {
  type = map(object({
    name = string
    location = string
    size = string
    admin_username = string
    network_interface_card = string
    admin_ssh_key = object({
      username = string
      public_key = string      
    })  
    os_disk = object({
      caching = string
      storage_account_type = string
    })
    source_image_reference = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
  }))
  description = "virtual machines(linux)"
}
variable "linux_nic" {
  type = map(object({
    name = string
    ip_configuration = object({
        name                          = string
        subnet_id = string
        private_ip_address_allocation = string
    })
  }))
  description = "network interface card that is attached to linux virtual machines"

}
variable "windows_virtual_machine" {
  type = map(object({
    name = string
    location = string
    size = string
    admin_username = string
    admin_password = string
    network_interface_card = string
    os_disk = object({
      caching = string
      storage_account_type = string
    })
    source_image_reference = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
  }))
  description = "virtual machines(windows)"
}
variable "windows_nic" {
  type = map(object({
    name = string
    ip_configuration = object({
        name                          = string
        subnet_id = string
        private_ip_address_allocation = string
    })
 }))
  description = "network interface card that is attached to resources"
}
variable "hatorsstracct1" {
  type = map(string)
  description = "The details of the storage_account of the Linux Function App which maintains state and other information about your projects.."
}
variable "function_apps" {
  type = map(object({
    name            = string
    app_service_plan = string
  }))
  description = "The name of the fucnction app"
}
variable "vnet" {
    type = map(object({
      name = string
      address_space = list(string)
    }))
    description = "virtual networks" 
}
variable "subnets" {
  type = map(object({
    name = string
    virtual_network = string
    address_prefixes = list(string)
  }))
  description = "subnets in the virtual networks where the virtual machines resides"
}
variable "publicip" {
  type = map(object({
    name = string
    allocation_method = string
    sku = string
  }))
  description = "public ip"
}
variable "bastion_host" {
  type = map(object({
    name = string
    ip_configuration = map(string)
  }))
}
variable "frontdoor_profile" {
  type = map(string)
  description = "cdn frontdoor profile details"
}
variable "frontdoor_endpoint_name" {
  type = string
  description = "cdn frontdoor endpoint details"
}
variable "frontdoor_origin_group" {
  type = map(object({
    name = string
    session_affinity_enabled = bool
    load_balancing = object({
      additional_latency_in_milliseconds = number
      sample_size = number
      successful_samples_required = number
    })
    health_probe = object({
      path = string
      request_type = string
      protocol = string
      interval_in_seconds = number
    })
  }))
  description = "cdn frontdoor origin group"
}
variable "frontdoor_origins" {
   type = map(object({
     name = string
     origin_group_id = string
     enabled =bool
     certificate_name_check_enabled = bool
     host_name          = string
     http_port          = number
     https_port         = number
     origin_host_header = string
     priority           = number
     weight             = number
   }))
   description = "cdn frontdoor origins"
}
 variable "dns_zone" {
   type = string
   description = "the name for the dns zone"
}
variable "cdn_route_config" {
  type = object({
    route_name        = string
    origin_group_id   = string
    origin_id1        = string
    origin_id2        = string
     # rule_set_id1 = ""
     # rule_set_id2 = ""
    route_enabled                   = bool
    forwarding_protocol            = string
    https_redirect_enabled          = bool
    patterns_to_match               = list(string)
    supported_protocols             = list(string)
    # custom_domain_id = string
    # custom_domain_id = string
    link_to_default_domain          = bool
    cache = object({
      query_string_caching_behavior   = string
      query_strings          = list(string)
      compression_enabled             = bool
      content_types_to_compress       = list(string) 
    })
    
  })
 description = "Variables for the CDN Frontdoor Route"
}