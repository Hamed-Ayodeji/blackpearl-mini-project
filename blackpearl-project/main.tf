module "vpc" {
  source                = "../modules/vpc"
  cidr_block            = var.cidr_block
  project-name          = var.project-name
}

module "sg" {
  source                = "../modules/sg"
  project-name          = var.project-name
  vpc-id                = module.vpc.vpc-id
}

module "ec2" {
  source                = "../modules/ec2"
  project-name          = var.project-name
  instance_type         = var.instance_type
  subnet_ids            = [module.vpc.subnet-ids[0], module.vpc.subnet-ids[1], module.vpc.subnet-ids[2]]
  public-instance-sg-id = module.sg.public-instance-sg-id
}

module "elb" {
  source                = "../modules/elb"
  project-name          = var.project-name
  subnet-ids            = [module.vpc.subnet-ids[0], module.vpc.subnet-ids[1], module.vpc.subnet-ids[2]]
  elb-sg-id             = module.sg.elb-sg-id
  vpc-id                = module.vpc.vpc-id
  instance_ids          = module.ec2.instance_ids
}

module "route53" {
  source                = "../modules/route53"
  project-name          = var.project-name
  domain-name           = var.domain-name
  subdomain-name        = var.subdomain-name
  elb-dns-name          = module.elb.elb-dns-name
  elb-zone-id           = module.elb.elb-zone-id
}