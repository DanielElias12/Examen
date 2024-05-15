provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "docker-desktop"
} 


resource "kubernetes_deployment" "hola-mundo-new" {
  metadata {
    name = "api"
    labels = {
      App = "ScalableNginx"
    }
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        App = "ScalableNginx"
      }
    }
    template {
      metadata {
        labels = {
          App = "ScalableNginx"
        }
      }
      spec {
        container {
          image = "daec1234/hello-world-react:1.0"
          name  = "example"

          port {
            container_port = 3000
          }

          resources {
            limits = {
              cpu    = "500m"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "hola-mundo-new" {
  metadata {
    name = "hola-mundo-new"
  }
  spec {
    selector = {
      App = kubernetes_deployment.hola-mundo-new.spec.0.template.0.metadata[0].labels.App
    }
    port {
      node_port   = 30209
      port        = 5000
      target_port = 5000
    }

    type = "NodePort"
  }
}

resource "kubernetes_deployment" "mongodb" {
  metadata {
    name = "mongodb"
    labels = {
      App = "MongoDB"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        App = "MongoDB"
      }
    }
    template {
      metadata {
        labels = {
          App = "MongoDB"
        }
      }
      spec {
        container {
          image = "mongo:latest"
          name  = "mongodb"

          port {
            container_port = 27017
          }

          resources {
            limits = {
              cpu    = "500m"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "mongodb" {
  metadata {
    name = "mongodb"
  }
  spec {
    selector = {
      App = kubernetes_deployment.mongodb.spec.0.template.0.metadata[0].labels.App
    }
    port {
      node_port   = 30205
      port        = 27017
      target_port = 27017
    }

    type = "NodePort"
  }
}

resource "kubernetes_deployment" "apache" {
  metadata {
    name = "apache"
    labels = {
      App = "Apache"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        App = "Apache"
      }
    }
    template {
      metadata {
        labels = {
          App = "Apache"
        }
      }
      spec {
        container {
          image = "httpd:latest"
          name  = "apache"

          port {
            container_port = 80
          }

          resources {
            limits = {
              cpu    = "500m"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "apache" {
  metadata {
    name = "apache"
  }
  spec {
    selector = {
      App = kubernetes_deployment.apache.spec.0.template.0.metadata[0].labels.App
    }
    port {
      node_port   = 30204
      port        = 80
      target_port = 80
    }

    type = "NodePort"
  }
}
