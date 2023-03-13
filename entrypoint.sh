sudo apt update
sudo apt -y full-upgrade
sudo apt install -y zsh \
    unzip zip curl \
    net-tools procps

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# awscli ----------------------------------
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
# awscli ----------------------------------
# docker ----------------------------------
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
# sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
mkdir -p /home/"$USER"/.docker
sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
sudo chmod g+rwx "$HOME/.docker" -R
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
# sudo reboot
# docker ----------------------------------
# microk8s --------------------------------
sudo snap install microk8s --classic
mkdir -p ~/.kube
sudo usermod -a -G microk8s $USER
sudo chown -R $USER ~/.kube
microk8s status --wait-ready
cp /var/snap/microk8s/current/args/kube-apiserver /var/snap/microk8s/current/args/kube-apiserver.backup
cp kube-apiserver /var/snap/microk8s/current/args/kube-apiserver
# microk8s --------------------------------
# nvm -------------------------------------
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
# nvm -------------------------------------
# sdkman ----------------------------------
curl -s "https://get.sdkman.io" | bash
# sdkman ----------------------------------
# zshrc -----------------------------------
cp $HOME/.zshrc $HOME/.zshrc.backup
cp zshrc $HOME/.zshrc
# zshrc -----------------------------------