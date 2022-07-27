terraform {
  backend "gcs" {
    bucket = "backend-fldysuflrnbjibrc"
    prefix = "/dev/home/skachdevops/wordpress_infrastructure/WordpressMySqlhelm"
  }
}