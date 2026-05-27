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

############################################################################
#################### 3 ROUTE TABLES & ATTACHMENTS ##########################
############################################################################

# route table for the public subnets
resource "aws_route_table" "rtb_public_subnets" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway_for_main_vpc.id
  }

  tags = { Name = "rtb_public_subnets" }

}

resource "aws_route_table_association" "rtb_associations_public_subnets" {
  # convert list to objects
  # for_each       = { for item in var.route_table_associations_config_list : item.subnet => item }
  # the map of objects now looks like:
  # { 
  #   AZ_a_public_subnet_1 = { subnet = "AZ_a_public_subnet_1" }, 
  #   AZ_b_public_subnet_1 = { subnet = "AZ_b_public_subnet_1" }
  # }

  count          = length(var.route_table_associations_subnet_list)

  subnet_id      = aws_subnet.subnets_in_main_vpc[
    var.route_table_associations_subnet_list[count.index]
  ].id
  
  route_table_id = aws_route_table.rtb_public_subnets.id
}

# route table for private subnet with outbound internet access through NAT Gateway
resource "aws_route_table" "rtb_private_subnets_outbound_access" {
  vpc_id = aws_vpc.main_vpc.id

  # route {
  #   cidr_block = "0.0.0.0/0"
  #   gateway_id = aws_nat_gateway.nat_gateway.id
  # }

  tags = { Name = "rtb_private_subnets_outbound_access" }

}

resource "aws_route_table" "rtb_private_subnets_no_outbound_access" {
  vpc_id = aws_vpc.main_vpc.id

  tags = { Name = "rtb_private_subnets_no_outbound_access" }
}