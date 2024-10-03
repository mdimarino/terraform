resource "aws_route53_zone" "phz_vpc" {

  name = "${local.name}.phz"

  vpc {
    vpc_id = module.vpc.vpc_id
  }

  # Prevent the deletion of associated VPCs after
  # the initial creation. See documentation on
  # aws_route53_zone_association for details
  lifecycle {
    ignore_changes = [vpc]
  }
}
