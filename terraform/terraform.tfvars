subnet_config_map = {
  private_subnet = { cidr_block = "10.0.0.0/24" }
  public_subnet  = { cidr_block = "10.0.1.0/24" }
}

security_group_config_map = {
  public_traffic_sg  = { name = "public_traffic_sg" }
  private_traffic_sg = { name = "private_traffic_sg" }
}

ec2_instance_config_map = {
  
}