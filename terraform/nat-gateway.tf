# # allocate elastic IP (EIP) for the nat gateway
# resource "aws_eip" "nat_gateway_eip" {
#   domain     = "vpc"
#   depends_on = [aws_internet_gateway.internet_gateway_for_main_vpc]

#   tags = { Name = "nat_gateway_eip" }
# }

# # NAT Gateway in the public subnet 
# resource "aws_nat_gateway" "nat_gateway" {
#   allocation_id = aws_eip.nat_gateway_eip.id
#   subnet_id     = aws_subnet.subnets_in_main_vpc["AZ_a_public_subnet"].id

#   # availability_mode defaults to zonal, other option is "regional" for region
#   # level high availability of the NAT Gateway, but higher costs
#   availability_mode = "zonal"   

#   tags = { Name = "nat_gateway" }

#   # Explicit dependency to ensure proper ordering during creation/destruction
#   depends_on = [aws_internet_gateway.internet_gateway_for_main_vpc]
# }