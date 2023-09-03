#!/bin/bash

sudo apt update

# Remuevo paquetes oficiales por si estaban instalados
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; 
do 
    sudo apt remove $pkg; 
done 

# Paso 1
sudo apt  install -y ca-certificates curl gnupg

# Paso 2
sudo install -m 0755 -d /etc/apt/keyrings

# Bajo la key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Agrego key que usa el desarrollador para firmar los paquetes
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Agrego el repositorio oficial
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Despues de agregar el repo tengo que actualizar el listado de paquetes disponibles
sudo apt-get update

# instalo docker y los plugin
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
