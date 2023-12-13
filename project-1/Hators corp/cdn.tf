resource "azurerm_cdn_frontdoor_profile" "hators_frontdoor" {
  name                = var.frontdoor_profile["name"]
  resource_group_name = data.azurerm_resource_group.main.name
  sku_name            = var.frontdoor_profile["sku_name"]
}
resource "azurerm_cdn_frontdoor_endpoint" "hators_frontdoor" {
  name                     = var.frontdoor_endpoint_name
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.hators_frontdoor.id
}
resource "azurerm_cdn_frontdoor_origin_group" "hators_frontdoor" {
  for_each = var.frontdoor_origin_group
  name                     = each.value.name
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.hators_frontdoor.id
  session_affinity_enabled = each.value.session_affinity_enabled
  load_balancing {
    additional_latency_in_milliseconds = each.value.load_balancing.additional_latency_in_milliseconds
    sample_size                        = each.value.load_balancing.sample_size
    successful_samples_required        = each.value.load_balancing.successful_samples_required
  }
  health_probe {
    path                = each.value.health_probe.path
    request_type        = each.value.health_probe.request_type
    protocol            = each.value.health_probe.protocol
    interval_in_seconds = each.value.health_probe.interval_in_seconds
}
}
resource "azurerm_cdn_frontdoor_origin" "hators_frontdoor" {
  for_each = var.frontdoor_origins
  name                          = each.value.name
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.hators_frontdoor[each.value.origin_group_id].id
  enabled                       = each.value.enabled
  certificate_name_check_enabled = each.value.certificate_name_check_enabled
  host_name          = each.value.host_name
  http_port          = each.value.http_port
  https_port         = each.value.https_port
  origin_host_header = each.value.origin_host_header
  priority           = each.value.priority
  weight             = each.value.weight
}
resource "azurerm_dns_zone" "hators_frontdoor" {
  name                = var.dns_zone
  resource_group_name = data.azurerm_resource_group.main.name
}

# # resource "azurerm_cdn_frontdoor_rule_set" "hators_frontdoor" {
# #   name                     = "HatorRuleSet"
# #   cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.hators_frontdoor.id
# # }

# # resource "azurerm_cdn_frontdoor_custom_domain" "contoso" {
# #   name                     = "hator-custom-domain"
# #   cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.hators_frontdoor.id
# #   dns_zone_id              = azurerm_dns_zone.hators_frontdoor.id
# #   host_name                = join(".", ["contoso", azurerm_dns_zone.hators_frontdoor.name])

# #   tls {
# #     certificate_type    = "ManagedCertificate"
# #     minimum_tls_version = "TLS12"
# #   }
# # }

# # resource "azurerm_cdn_frontdoor_custom_domain" "fabrikam" {
# #   name                     = "fabrikam-custom-domain"
# #   cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.hators_frontdoor.id
# #   dns_zone_id              = azurerm_dns_zone.hators_frontdoor.id
# #   host_name                = join(".", ["fabrikam", azurerm_dns_zone.hators_frontdoor.name])

# #   tls {
# #     certificate_type    = "ManagedCertificate"
# #     minimum_tls_version = "TLS12"
# #   }
# # }
resource "azurerm_cdn_frontdoor_route" "hators_frontdoor" {
  name                          = var.cdn_route_config.route_name
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.hators_frontdoor.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.hators_frontdoor[var.cdn_route_config.origin_group_id].id
  cdn_frontdoor_origin_ids      = [azurerm_cdn_frontdoor_origin.hators_frontdoor[var.cdn_route_config.origin_id2].id, azurerm_cdn_frontdoor_origin.hators_frontdoor[var.cdn_route_config.origin_id1].id]
  # cdn_frontdoor_rule_set_ids    = var.cdn_route_config.cdn_frontdoor_rule_set_ids
  enabled                       = var.cdn_route_config.route_enabled
  forwarding_protocol    = var.cdn_route_config.forwarding_protocol
  https_redirect_enabled = var.cdn_route_config.https_redirect_enabled
  patterns_to_match      = var.cdn_route_config.patterns_to_match
  supported_protocols    = var.cdn_route_config.supported_protocols
  # cdn_frontdoor_custom_domain_ids = var.cdn_route_config.cdn_frontdoor_custom_domain_ids
  link_to_default_domain          = var.cdn_route_config.link_to_default_domain
  cache {
    query_string_caching_behavior = var.cdn_route_config.cache.query_string_caching_behavior
    query_strings                 = var.cdn_route_config.cache.query_strings
    compression_enabled           = var.cdn_route_config.cache.compression_enabled
    content_types_to_compress     = var.cdn_route_config.cache.content_types_to_compress
  }
}

# # resource "azurerm_cdn_frontdoor_custom_domain_association" "contoso" {
# #   cdn_frontdoor_custom_domain_id = azurerm_cdn_frontdoor_custom_domain.contoso.id
# #   cdn_frontdoor_route_ids        = [azurerm_cdn_frontdoor_route.hators_frontdoor.id]
# # }
# # resource "azurerm_cdn_frontdoor_custom_domain_association" "fabrikam" {
# #   cdn_frontdoor_custom_domain_id = azurerm_cdn_frontdoor_custom_domain.fabrikam.id
# #   cdn_frontdoor_route_ids        = [azurerm_cdn_frontdoor_route.hators_frontdoor.id]
# # }