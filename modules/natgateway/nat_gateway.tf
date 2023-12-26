resource "aws_nat_gateway" "nat_gateway" {
    subnet_id = var.subnet_id
    tags = {
      Name = "gw NAT"
    }
    #allocation_id = var.allocation_id // provide Elastic IP
}
