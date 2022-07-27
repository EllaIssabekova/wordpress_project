provider "kubernetes" {
  config_path    = "~/.kube/config"
}

resource "google_compute_disk" "app" {
  name = "app-${var.project_id}"
  type = "pd-standard"
  zone = var.app_zone
  size = var.app_volume_size_gb
  labels = var.app_labels
}

resource "kubernetes_persistent_volume" "app" {
  metadata {
    name = "app-${var.project_id}"
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    capacity = {
      storage = "${var.app_volume_size_gb}Gi"
    }
    persistent_volume_source {
      gce_persistent_disk {
        pd_name = google_compute_disk.app.name
      }
    }
    storage_class_name = "standard"
  }
}

resource "kubernetes_persistent_volume_claim" "app" {
  metadata {
    name = "app-${var.project_id}"
    namespace = "${var.namespace}"
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "${var.app_volume_size_gb}Gi"
      }
    }
    volume_name = kubernetes_persistent_volume.app.metadata.0.name
    storage_class_name = "standard"
  }
}

resource "google_compute_disk" "db" {
  name = "db-${var.project_id}"
  type = "pd-standard"
  zone = var.db_zone
  size = var.db_volume_size_gb
  labels = var.db_labels
}

resource "kubernetes_persistent_volume" "db" {
  metadata {
    name = "db-${var.project_id}"
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    capacity = {
      storage = "${var.db_volume_size_gb}Gi"
    }
    persistent_volume_source {
      gce_persistent_disk {
        pd_name = google_compute_disk.db.name
      }
    }
    storage_class_name = "standard"
  }
}

resource "kubernetes_persistent_volume_claim" "db" {
  metadata {
    name = "db-${var.project_id}"
    namespace = "${var.namespace}"
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "${var.db_volume_size_gb}Gi"
      }
    }
    volume_name = kubernetes_persistent_volume.db.metadata.0.name
    storage_class_name = "standard"
  }
}