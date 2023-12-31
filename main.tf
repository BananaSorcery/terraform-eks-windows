terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.3.0"
    }
  }
}
provider "aws" {
  region = var.region
}

//Modify the bucket and dynamoDB table that are used by Terraform
terraform {
  backend "s3" {
    bucket         = "hau-s3-tfstate"
    key            = "private-windows-eks.tfstate"
    region         = "us-east-2"
    dynamodb_table = "hau-tfstatelock"
  }
}

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "hau-s3-tfstate"
    key    = "network.tfstate"
    region = "us-east-2"
  }
}

module "cluster" {
  source              = "./eks/cluster"
  region              = var.region
  eks_cluster_name    = var.eks_cluster_name
  eks_cluster_version = var.eks_cluster_version
  private_subnet_ids  = data.terraform_remote_state.network.outputs.out_private_vpc.private_subnets
  vpc_id              = data.terraform_remote_state.network.outputs.out_private_vpc.vpc_id
  bastion_host_SG_id  = data.terraform_remote_state.network.outputs.out_bastion_host_security_group_id
  lin_desired_size    = var.lin_desired_size
  lin_max_size        = var.lin_max_size
  lin_min_size        = var.lin_min_size
  lin_instance_type   = var.lin_instance_type
  win_desired_size    = var.win_desired_size
  win_max_size        = var.win_max_size
  win_min_size        = var.win_min_size
  win_instance_type   = var.win_instance_type
  node_host_key_name  = var.node_host_key_name
}


