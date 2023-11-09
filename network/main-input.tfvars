region                = "us-east-2"
azs_private           = ["us-east-2a", "us-east-2b", "us-east-2c"]
private_subnets       = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
vpc_private_cidr      = "10.10.0.0/16"
vpc_public_cidr       = "10.20.0.0/16"
azs_public            = ["us-east-2a"]
public_subnets        = ["10.20.1.0/24"]
bastion_host_key_name = "eks-terraform-key"
ssh_bastion_cidr      = ["0.0.0.0/0"]


