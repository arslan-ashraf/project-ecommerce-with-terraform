variable "subnet_config_map" {
  type = map(object({
    cidr_block = string 
  }))

  validation {
    condition = alltrue([
      for subnet_config in values(var.subnet_config_map) : can(cidrnetmask(subnet_config.cidr_block))
    ])

    error_message = "CIDR Error: At least one of the privded CIDR blocks is invalid."
  }
}


variable "security_group_config_map" {
  type = map(object({
    name = string
  }))

  validation {
    condition = alltrue([
      for security_group_config in value(var.security_group_config_map) : 
      contains(["public", "private"], security_group_config.name)
    ])
  }
}