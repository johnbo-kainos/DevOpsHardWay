locals {

  naming_prefix = "${var.name}-jb"
  acr_naming_prefix = replace(local.naming_prefix,"-","")
}