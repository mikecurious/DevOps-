# Update and upgrade packages
resource "null_resource" "update_upgrade" {
  provisioner "local-exec" {
    command = "sudo apt update -y && sudo apt upgrade -y"
  }
}

# Install Python3.10
resource "null_resource" "install_python" {
  provisioner "local-exec" {
    command = <<EOT
      sudo add-apt-repository --yes ppa:deadsnakes/ppa
      sudo apt update -y
      sudo apt install -y python3.10
    EOT
  }
}

# Download and install Nodejs 18, install npm
resource "null_resource" "install_nodejs" {
  provisioner "local-exec" {
    command = "curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash - && sudo apt install -y nodejs npm"
  }
}

# Install Java
resource "null_resource" "install_java" {
  provisioner "local-exec" {
    command = "sudo apt install -y openjdk-11-jre-headless"
  }
}

# Install Docker
resource "null_resource" "install_docker" {
  provisioner "local-exec" {
    command = <<EOT
      sudo apt-get install -y ca-certificates curl gnupg
      sudo install -m 0755 -d /etc/apt/keyrings
      curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
      sudo chmod a+r /etc/apt/keyrings/docker.gpg
      echo \
        "deb [arch=\"$(dpkg --print-architecture)\" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
        $(. /etc/os-release && echo \"$VERSION_CODENAME\") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
      sudo apt-get update
      sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose
    EOT
  }
}
