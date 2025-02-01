module "wandb_infra" {
  source  = "wandb/wandb/aws"
  version = "~>2.0"

  namespace   = var.namespace
  domain_name = var.domain_name
  subdomain   = var.subdomain
  zone_id     = var.zone_id

  allowed_inbound_cidr           = var.allowed_inbound_cidr
  allowed_inbound_ipv6_cidr      = var.allowed_inbound_ipv6_cidr

  public_access                  = true
  external_dns                   = true
  kubernetes_public_access       = true
  kubernetes_public_access_cidrs = ["0.0.0.0/0"]
  eks_cluster_version = 1.32 #var.eks_cluster_version
}

data "aws_eks_cluster" "app_cluster" {
  name = module.wandb_infra.cluster_id
}

data "aws_eks_cluster_auth" "app_cluster" {
  name = module.wandb_infra.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.app_cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.app_cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.app_cluster.token
}

module "wandb_app" {
  source  = "wandb/wandb/kubernetes"
  version = "~>1.0"

  license                    = var.license
  host                       = module.wandb_infra.url
  bucket                     = "s3://${module.wandb_infra.bucket_name}"
  bucket_aws_region          = module.wandb_infra.bucket_region
  bucket_queue               = "internal://"
  database_connection_string = "mysql://${module.wandb_infra.database_connection_string}"

  # TF attempts to deploy while the work group is
  # still spinning up if you do not wait
  depends_on = [module.wandb_infra]
}

output "bucket_name" {
  value = module.wandb_infra.bucket_name
}

output "url" {
  value = module.wandb_infra.url
}