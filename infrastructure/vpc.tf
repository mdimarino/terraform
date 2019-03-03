# Exemplos de subredes usando CIDR 172.16.

# Cada subrede terá 4091 endereços para hosts.
# A AWS reserva os IPs .1(VPC router), .2(Amazon-provided DNS) e .3(uso futuro).
# Netmask: 255.255.240.0 = 20

# zona a publica 01 172.16.0.0/20 - 172.16.0.4 a 172.16.15.254
# zona a privada 01 172.16.16.0/20 - 172.16.16.4 a 172.16.31.254

# zona b publica 02 172.16.32.0/20 - 172.16.32.4 a 172.16.47.254
# zona b privada 02 172.16.48.0/20 - 172.16.48.4 a 172.16.63.254

# zona c publica 03 172.16.64.0/20 - 172.16.64.4 a 172.16.79.254
# zona c privada 03 172.16.80.0/20 - 172.16.80.4 a 172.16.95.254

# zona e publica 04 172.16.96.0/20 - 172.16.96.4 a 172.16.111.254
# zona e privada 04 172.16.112.0/20 - 172.16.112.4 a 172.16.127.254

resource "aws_vpc" "vpc" {
  cidr_block = "${var.vpc-cidr-block}"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.vpc-name}",
    Environment = "${var.environment}",
    Billing = "${var.billing}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags = {
    Name = "${var.vpc-name}-igw",
    Environment = "${var.environment}",
    Billing = "${var.billing}"
  }
}

# resource "aws_subnet" "subnet_private_01" {
#   vpc_id     = "${aws_vpc.vpc.id}"
#   cidr_block = "172.19.0.0/20"
#   tags = {
#     Name = "${var.vpc-name} Subrede Privada 01"
#   }
# }
