module "eks" {
  source = "./eks"
}

module "namespace" {
  source       = "./namespace"
}

# module "monitoring" {
#   source       = "./monitoring"
# }

module "vault" {
  source       = "./vault"
}

module "harbor" {
  source       = "./harbor"
}