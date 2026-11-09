variable "project_id" {
  description = "The ID of the project in which to provision resources."
  type        = string
}

variable "region" {
  description = "The region in which to provision resources."
  type        = string
  default     = "us-central1"
}

variable "local_vpc_name" {
  description = "The name of the VPC network to create."
  type        = string
}

// calling  the varaible module to create for subnet
variable "local_subnet_name" {
  description = "The name of the subnet to create."
  type        = string
}
variable "local_subnet_cidr" {
  description = "The CIDR range of the subnet to create."
  type        = string
}

//calling the variable module to create for gce instance
variable "local_instance_name" {
  description = "The name of the instance to create."
  type        = string
}

variable "local_instance_zone" {
  description = "The zone where the instance will be created."
  type        = string
}

variable "local_instance_type" {
  description = "The machine type for the instance."
  type        = string
}