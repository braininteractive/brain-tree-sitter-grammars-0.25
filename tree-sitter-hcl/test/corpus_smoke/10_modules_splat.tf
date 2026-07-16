module "network" {
  source     = "./modules/network"
  cidr_block = "10.0.0.0/16"
  azs        = ["eu-west-1a", "eu-west-1b"]
}

locals {
  subnet_ids  = module.network.subnets[*].id
  first_id    = module.network.subnets[0].id
  legacy_ids  = module.network.subnets.*.id
  attr_lookup = module.network.vpc["main"]
}
