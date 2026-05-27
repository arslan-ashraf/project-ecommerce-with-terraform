# # allocate elastic IP (EIP) for the nat gateway
# resource "aws_eip" "nat_gateway_eip" {
#   domain     = "vpc"
#   depends_on = [aws_internet_gateway.internet_gateway_for_main_vpc]

#   tags = { Name = "nat_gateway_eip" }
# }

# # NAT Gateway in the public subnet 
# resource "aws_nat_gateway" "nat_gateway" {
#   allocation_id = aws_eip.nat_gateway_eip.id
#   subnet_id     = aws_subnet.subnets_in_main_vpc["AZ_a_public_subnet_1"].id

#   tags = { Name = "nat_gateway" }

#   # Explicit dependency to ensure proper ordering during creation/destruction
#   depends_on = [aws_internet_gateway.internet_gateway_for_main_vpc]
# }