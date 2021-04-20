#!/bin/bash

echo "     ____             __             ____                  "
echo "    / __ \____  _____/ /_____  _____/ __ )____  __________ "
echo "   / / / / __ \/ ___/ //_/ _ \/ ___/ __  / __ \/ ___/ ___/ "
echo "  / /_/ / /_/ / /__/ ,< /  __/ /  / /_/ / /_/ (__  |__  )  "
echo " /_____/\____/\___/_/|_|\___/_/  /_____/\____/____/____/   "



sleep 3

if [ "$EUID" -ne 0 ]
  then echo "[ Necesitas tener privilegios de root ]"
  exit
fi

echo "[*] Eliminando versiones anteriores de docker"
apt-get remove docker docker-engine docker.io containerd runc
echo "[*] Actualizando repositorios"
apt-get update
echo "[*] Instalando requisitos"
apt-get install\
apt-transport-https \
ca-certificates \
curl \
gnupg \
lsb-release
echo "[*] Instalando curl"
apt install curl

echo "[*] Copiando clave PGP de Docker"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo -e "[*] Cargando repositorios de docker"
 echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo -e "[*] Instalando dockers"
apt-get update
apt-get install docker-ce docker-ce-cli containerd.io
