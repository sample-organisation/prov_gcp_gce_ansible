#!/bin/bash
set -e
set -o pipefail

install_docker() {
  if ! [ -x "$(command -v docker)" ]; then
    sudo apt-get update
    sudo apt-get install -y docker.io
  fi
}

install_nexus() {
  has_nexus="docker inspect -f '{{.State.Running}}' nexus"
  if $has_nexus &>/dev/null; then
    echo "Nexus is already running. Hence skipping installation."
    exit 0
  fi
  sudo docker run -d -p 80:8081 --name nexus sonatype/nexus3
}

install_docker
install_nexus
