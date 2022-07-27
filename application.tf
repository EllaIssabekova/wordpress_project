module "app-terraform-k8s-namespace" {
  source               = "./modules/terraform-k8s-namespace/"
  deployment_namespace = var.namespace
}

module "choose_ur_password" {
  source               = "./modules/vaultandpass"
  google_domain_name = var.google_domain_name
  do_u_want_ur_own_password = var.do_u_want_ur_own_password
  user = var.user
  do_u_want_ur_own_root_password = var.do_u_want_ur_own_root_password
  db_root_password = var.db_root_password
  db_user_password = var.db_user_password
}

module "pvcs" {
  source               = "./modules/pvc/"
  app_zone = var.app_zone
  app_volume_size_gb = var.app_volume_size_gb
  app_labels = var.app_labels
  ####################
  db_zone = var.db_zone
  db_volume_size_gb = var.db_volume_size_gb
  db_labels = var.db_labels
  #######################
  project_id = var.project_id
  namespace = var.namespace
}

module "mysql" {
  source               = "./modules/terraform-helm/"
  deployment_name      = var.db_deployment_name
  deployment_namespace = var.namespace
  deployment_path      = "charts/mysql/"
  values_yaml          = <<EOF
replicaCount: "${var.db_replicaCount}"
image:
  registry:  "${var.db_registry}"
  repository: "${var.db_repository}"
  tag: "${var.db_tag}"

service:
  port: "${var.db_port}"

dbconfig:
  dbuser: "${var.user}"
  db_user_password: "${module.choose_ur_password.user_password}"
  dbrootpassword: "${module.choose_ur_password.root_password}"
  dbname: "${var.db_name}"
  dbhost: "${var.db_host_name}"
  dbdomain: "${var.db_deployment_name}.${var.google_domain_name}"

resources: 
  limits:
    cpu: "${var.db_cpu_limit}"
    memory: "${var.db_memory_limit}"
  requests:
    cpu: "${var.db_cpu_request}"
    memory: "${var.db_memory_request}"

persistence:
  type: pvc
  enabled: "${var.db_inhelm_pvc_enabled}"
  existingClaim: "${module.pvcs.db_pvc_name}"

ingress:
  enabled: "${var.db_ingress_enabled}"
  annotations: 
    ingress.kubernetes.io/ssl-redirect: "false"
    cert-manager.io/cluster-issuer: letsencrypt-prod
    acme.cert-manager.io/http01-edit-in-place: "true"
    kubernetes.io/ingress.class: nginx
    ingressClassName: nginx
  hosts:
    - host: "${var.db_deployment_name}.${var.google_domain_name}"
      paths:
        - path: /
          pathType: ImplementationSpecific
  tls: 
   - secretName: "${var.db_deployment_name}"
     hosts:
       - "${var.db_deployment_name}.${var.google_domain_name}"
  EOF
}


module "wordpress" {
  source               = "./modules/terraform-helm/"
  deployment_name      = var.app_deployment_name
  deployment_namespace = var.namespace
  deployment_path      = "charts/wordpress/"
  values_yaml          = <<EOF
replicaCount: "${var.app_replicaCount}"

image:
  registry:  "${var.app_registry}"
  repository: "${var.app_repository}"
  tag: "${var.app_tag}"

service:
  port: "${var.app_port}"

wpconfig:
  db_user_password: "${module.choose_ur_password.user_password}"
  wpuser: "${var.user}"
  dbhost: "${var.db_host_name}"
  dbname: "${var.db_name}"

resources: 
  limits:
    cpu: "${var.app_cpu_limit}"
    memory: "${var.app_memory_limit}"
  requests:
    cpu: "${var.app_cpu_request}"
    memory: "${var.app_memory_request}"

persistence:
  type: pvc
  enabled: "${var.app_inhelm_pvc_enabled}"
  existingClaim: "${module.pvcs.app_pvc_name}"

ingress:
  enabled: "${var.app_ingress_enabled}"
  annotations: 
    ingress.kubernetes.io/ssl-redirect: "false"
    cert-manager.io/cluster-issuer: letsencrypt-prod
    acme.cert-manager.io/http01-edit-in-place: "true"
    kubernetes.io/ingress.class: nginx
    ingressClassName: nginx
  hosts:
    - host: "${var.app_deployment_name}.${var.google_domain_name}"
      paths:
        - path: /
          pathType: ImplementationSpecific
  tls: 
   - secretName: "${var.app_deployment_name}"
     hosts:
       - "${var.app_deployment_name}.${var.google_domain_name}"
  EOF
}