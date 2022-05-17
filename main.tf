terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.16.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

# Pulls the image
resource "docker_image" "web-app" {
  name         = "robcecc/node-web-app:latest"
  keep_locally = true
}


resource "docker_container" "docker_web_app" {
  image   = docker_image.web-app.latest
  name    = "web-app-container"
  restart = "always"
  volumes {
    container_path = "/myapp"
    # replace the host_path with full path for your project directory starting from root directory /
    host_path = "/home/robcecc/Docker/node_project"
    read_only = false
  }
  ports {
    internal = 8080
    external = 8080
  }
}