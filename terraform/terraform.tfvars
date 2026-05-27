subnet_config_map = {

  # AZ: us-east-1a
  AZ_a_public_subnet_1 = {
    cidr_block        = "10.0.1.0/24"
    availability_zone = "us-east-1a"
  }
  AZ_a_private_subnet_1 = {
    cidr_block        = "10.0.2.0/24"
    availability_zone = "us-east-1a"
  }
  AZ_a_private_subnet_2 = {
    cidr_block        = "10.0.3.0/24"
    availability_zone = "us-east-1a"
  }

  # AZ: us-east-1b
  AZ_b_public_subnet_1 = {
    cidr_block        = "10.0.11.0/24"
    availability_zone = "us-east-1b"
  }
  AZ_b_private_subnet_1 = {
    cidr_block        = "10.0.12.0/24"
    availability_zone = "us-east-1b"
  }
  AZ_b_private_subnet_2 = {
    cidr_block        = "10.0.13.0/24"
    availability_zone = "us-east-1b"
  }

}

rtb_associations_public_subnet_1_list = [
  "AZ_a_public_subnet_1", 
  "AZ_b_public_subnet_1"
]

rtb_associations_private_subnet_1_list = [
  "AZ_a_private_subnet_1", 
  "AZ_b_private_subnet_1"
]

# security_group_config_map = {
#   public_traffic_sg  = { name = "public_traffic_sg" }
#   private_traffic_sg = { name = "private_traffic_sg" }
# }