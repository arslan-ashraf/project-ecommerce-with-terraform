resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"
  tags       = { Name = "main_vpc" }
}

resource "aws_internet_gateway" "internet_gateway_for_main_vpc" {
  vpc_id = aws_vpc.main_vpc.id

  tags = { Name = "internet_gateway_for_main_vpc" }

}

# creates 6 subnets, 2 private, 4 public
resource "aws_subnet" "subnets_in_main_vpc" {
  for_each          = var.subnet_config_map
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = { Name = each.key }
}

################################################
############### 3 ROUTE TABLES #################
################################################

# route table for the public subnets
resource "aws_route_table" "rtb_public_subnets_in" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway_for_example_vpc.id
  }

  tags = { Name = "rtb_public_subnets" }

}


# route table for private subnet with outbound internet access through NAT Gateway
resource "aws_route_table" "rtb_private_subnets_outbound_access" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    
  }

  tags = { Name = "rtb_private_subnets_outbound_access" }

}