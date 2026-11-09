provider "google" {
  project = var.project_id
  region  = var.region
}

//calling the module to create a vpc network
module "vpc" {
  source   = "git::https://github.com/ballas1983/kn-terraform-modules.git//vpc?ref=v1.0.0"
  vpc_name = var.local_vpc_name

}

//calling the module to create a subnet
module "subnet" {
  source      = "git::https://github.com/ballas1983/kn-terraform-modules.git//subnet?ref=v1.0.0"
  subnet_name = var.local_subnet_name
  subnet_cidr = var.local_subnet_cidr
  region      = var.region
  vpc_id      = module.vpc.vpc_id
  depends_on  = [module.vpc]
}

//calling the module to create a gce instance
module "gce" {
  source        = "git::https://github.com/ballas1983/kn-terraform-modules.git//gce?ref=v1.0.0"
  instance_name = var.local_instance_name
  zone          = var.local_instance_zone
  instance_type = var.local_instance_type
  subnet_id     = module.subnet.subnet_id
  depends_on    = [module.subnet]

}


