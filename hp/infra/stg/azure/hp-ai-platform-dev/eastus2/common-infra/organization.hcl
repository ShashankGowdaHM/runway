locals {
  organization_name       = "hp-ai-platform"
  organization_short_name = "hpaip"
  org_primary_admins      = "gautham-kamath.k-b@hp.com,sudharsan.n@hp.com,aman.rathore@hp.com"
  org_manager             = "deepak.mandaknale@hp.com"
  org_tags = {
    "org_name"           = local.organization_name
    "org_short_name"     = local.organization_short_name
    "org_primary_admins" = local.org_primary_admins
    "org_manager"        = local.org_manager
  }

  org_custom_tags = {
    "org_location" = "bangalore",
    "org_purpose"  = "hpaip-common-infra"
  }

}