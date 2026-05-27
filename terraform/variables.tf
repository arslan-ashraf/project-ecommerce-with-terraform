variable "subnet_config_map" {
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))

  validation {
    condition = alltrue([
      for subnet_config in values(var.subnet_config_map) :
      can(cidrnetmask(subnet_config.cidr_block))
    ])

    error_message = "CIDR Error: At least one of the privded CIDR blocks is invalid."
  }

  validation {
    condition = alltrue([
      for subnet_config in values(var.subnet_config_map) :
      contains(["us-east-1a", "us-east-1b"], subnet_config.availability_zone)
    ])

    error_message = "Only us-east-1a and us-east-1b AZs are allowed."
  }
}


variable "rtb_associations_public_subnets_1_list" {
  type = list(string)

  validation {
    condition = alltrue([
      for subnet_string in var.rtb_associations_public_subnets_1_list :
      strcontains(subnet_string, "public_subnet_1")
    ])

    error_message = "Only public subnets 1 in us-east-1a and us-east-1b AZs are allowed."
  }
}

variable "rtb_associations_private_subnets_for_compute_list" {
  type = list(string)

  validation {
    condition = alltrue([
      for subnet_string in var.rtb_associations_private_subnets_for_compute_list :
      strcontains(subnet_string, "private_subnet_for_compute")
    ])

    error_message = "Only private subnets for compute in us-east-1a and us-east-1b AZs are allowed."
  }
}

variable "rtb_associations_private_subnets_2_list" {
  type = list(string)

  validation {
    condition = alltrue([
      for subnet_string in var.rtb_associations_private_subnets_2_list :
      strcontains(subnet_string, "private_subnet_2")
    ])

    error_message = "Only private subnets 2 in us-east-1a and us-east-1b AZs are allowed."
  }
}


# variable "security_group_config_map" {
#   type = map(object({
#     name = string
#   }))

#   validation {
#     condition = alltrue([
#       for security_group_config in value(var.security_group_config_map) :
#       contains(["public", "private"], security_group_config.name)
#     ])

#     error_message = "Only public and private names are allowed in the security group names."
#   }
# }


# variable "ec2_instance_config_map" {
#   type = map(object({
#     instance_type = string
#     ami = string
#     subnet_name = optional(string, "private_subnet")
#     security_group = string
#   }))

#   validation {
#     condition = alltrue([
#       for ec2_instance_config in values(var.ec2_instance_config_map) :
#       contains(["t2.nano"], ec2_instance_config.instance_type)
#     ])

#     error_message = "Only t2.nano instances are allowed."
#   }

#   validation {
#     condition = alltrue([
#       for ec2_instance_config in values(var.ec2_instance_config_map) :
#       contains(["ubuntu"], ec2_instance_config.ami)
#     ])

#     error_message = "Only \"ubuntu\" AMIs are allowed."
#   }
# }