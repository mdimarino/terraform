provider "aws" {

  profile = "acg-sandbox"

  region = local.region

  default_tags {
    tags = {
      Billing       = "infrastructure"
      Provisioner   = "terraform"
      Environment   = local.environment
      ResourceGroup = local.name
      Repository    = "https://github.com/mdimarino/terraform"
    }
  }
}
