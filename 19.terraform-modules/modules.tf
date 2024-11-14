/*
    We can have module block in
    Local Path :
    module "consul" {
      source = "./consul"
    }
    Terraform Registry
    module "consul" {
      source = "hashicorp/consul/aws"
      version = "0.1.0"
    }
    Github :
    module "consul" {
      source = "github.com/hashicorp/example"
    }
    Bitbucket:
    module "consul" {
      source = "bitbucket.org/hashicorp/terraform-consul-aws"
    }
    Generic Git Repository
    module "vpc" {
      source = "git::https://example.com/vpc.git"
    }
    module "storage" {
      source = "git::ssh://username@example.com/storage.git"
    }

 */

/*
  publishing modules
  public github repo
  named: terraform-PROVIDER-modulename
  Repo Description: short description of the module in terraform registry
  Standard module version
  minimal
  .
  |- README.md
  |- main.tf
  |- variables.tf
  |- outputs.tf
  |- ...
  |- modules/
  |- |- m1/
  |- |  |- main.tf
  |- |  |- variables.tf
  |- |  |- outputs.tf
  |- |  |- README.md
  |- |- m2/
  |- ...
  |- examples/
  |- |- ex1/
  |- |  |- main.tf
  |- |- ex2/
  |- ...

  x.y.z tags for releases
 */

/*

terraform workspace select dev
terraform workspace select prod
terraform workspace list
terraform workspace delete dev
terraform workspace new sit


terraform backends
s3
kubernetes
consul
git
gcs
http
etc.
 */
