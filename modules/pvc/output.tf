output "db_pvc_name" {
value = kubernetes_persistent_volume_claim.db.metadata.0.name
}

output "app_pvc_name" {
value = kubernetes_persistent_volume_claim.app.metadata.0.name
}