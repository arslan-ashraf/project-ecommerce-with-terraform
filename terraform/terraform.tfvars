subnet_config_map = {

  zone_a_private_subnet_1 = { 
    cidr_block = "10.0.1.0/24" 
    availiability_zone = "us-east-1a"
  }
  zone_a_public_subnet_1  = { 
    cidr_block = "10.0.2.0/24" 
    availiability_zone = "us-east-1a"
  }
  zone_a_public_subnet_2  = { 
    cidr_block = "10.0.3.0/24" 
    availiability_zone = "us-east-1a"
  }
}

security_group_config_map = {
  public_traffic_sg  = { name = "public_traffic_sg" }
  private_traffic_sg = { name = "private_traffic_sg" }
}