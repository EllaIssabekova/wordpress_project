output user_password {
value = "${vault_generic_secret.mysql_for_wordpress_user.data["password"]}"
}

output root_password {
value = "${vault_generic_secret.mysql_for_wordpress_root.data["password"]}"
}