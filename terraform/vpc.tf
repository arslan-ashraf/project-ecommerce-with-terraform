resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"
  tags       = { Name = "main_vpc" }
}

resource "aws_internet_gateway" "internet_gateway_for_example_vpc" {
  vpc_id = aws_vpc.example_vpc.id

  tags = { Name = "internet_gateway_for_example_vpc" }

}