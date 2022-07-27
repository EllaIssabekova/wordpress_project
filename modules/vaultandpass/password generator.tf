locals {
   user_password = "${var.do_u_want_ur_own_password == true ? var.db_user_password : random_password.random.result}" 
   root_password = "${var.do_u_want_ur_own_root_password == true ? var.db_root_password : random_password.random_root.result}" 
}

provider "vault" {
    address = "https://vault.${var.google_domain_name}"
}

resource "random_password" "random" {
  length           = 32
  special          = false
  override_special = "!#$%&*()-_=+[]{}<>:?"
  upper            = false
}

resource "random_password" "random_root" {
  length           = 32
  special          = false
  override_special = "!#$%&*()-_=+[]{}<>:?"
  upper            = false
}


resource "vault_generic_secret" "mysql_for_wordpress_user" {
  depends_on = [random_password.random]
  path = "company_credentials/mysql_for_wordpress"

  data_json = <<EOT
{
  "username":   "${var.user}",
  "password": "${local.user_password}"
}
EOT
}

resource "vault_generic_secret" "mysql_for_wordpress_root" {
  depends_on = [random_password.random_root]
  path = "company_credentials/mysql_for_wordpress_root"

  data_json = <<EOT
{
  "username":   "root",
  "password": "${local.root_password}"
}
EOT
}