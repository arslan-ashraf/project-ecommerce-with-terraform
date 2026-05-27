resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"
  tags       = { Name = "main_vpc" }
}

resource "aws_internet_gateway" "internet_gateway_for_main_vpc" {
  vpc_id = aws_vpc.main_vpc.id

  tags = { Name = "internet_gateway_for_main_vpc" }

}

resource "aws_subnet" "subnets_in_main_vpc" {
  for_each          = var.subnet_config_map
  vpc_id            = aws_vpc.main_vpc.id
  availability_zone = each.value.availability_zone

  tags = { Name = each.key }
}