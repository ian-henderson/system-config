#!/usr/bin/env fish

sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

sudo systemctl enable --now docker.service
sudo systemctl enable --now containerd.service
