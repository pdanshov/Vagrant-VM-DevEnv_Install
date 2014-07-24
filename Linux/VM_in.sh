#!/bin/bash

source ./getinfo.sh

sudo apt-get install dkms # Ubuntu/Debian users might want to install the dkms package to ensure that the VirtualBox host kernel modules (vboxdrv, vboxnetflt and vboxnetadp) are properly updated if the linux kernel version changes during the next apt-get upgrade.
sudo apt-get -y -f install virtualbox
wget http://download.virtualbox.org/virtualbox/4.3.10/virtualbox-4.3_4.3.10-93012~Ubuntu~precise_amd64.deb
sudo dpkg -i virtualbox-4.3_4.3.10-93012~Ubuntu~precise_amd64.deb
wget http://download.virtualbox.org/virtualbox/4.3.10/Oracle_VM_VirtualBox_Extension_Pack-4.3.10-93012.vbox-extpack
sudo vboxmanage extpack install Oracle_VM_VirtualBox_Extension_Pack-4.3.10-93012.vbox-extpack

sudo apt-get -y -f install vagrant

thisdir="$(pwd)"

mkdir ~/vms
mkdir ~/vms/nyccttutsys
#mkdir ~/vms/nyccttutsys/shared_folder

cd ~/vms/nyccttutsys/

vagrant init precise64 http://files.vagrantup.com/precise64.box

cd "$thisdir"
cp ../Vagrantfile ~/vms/nyccttutsys/Vagrantfile
cp ../ShellProvision.sh ~/vms/nyccttutsys/ShellProvision.sh
#cp ../setup_ror.sh ~/vms/nyccttutsys/shared_folder/setup_ror.sh
#cp ../start_ror.sh ~/vms/nyccttutsys/shared_folder/start_ror.sh
cd ~/vms/nyccttutsys/
sudo chmod +x ShellProvision.sh

#ssh-keygen -t rsa -C "$keys_email" -N "" -f ./shared_folder/github_id_rsa
#echo -e "Host github.com\n\tHostName github.com\n\tIdentityFile ~/.ssh/github_id_rsa\n\tUser $github_un" > ./shared_folder/config
#cp ~/shared_folder/config ~/vms/nyccttutsys/shared_folder/config
#cp ~/shared_folder/github_id_rsa ~/vms/nyccttutsys/shared_folder/github_id_rsa
#cp ~/shared_folder/github_id_rsa.pub ~/vms/nyccttutsys/shared_folder/github_id_rsa.pub
#mail -s "NYCCT Tut Sys Git Authorization Request from: $github_un" pdanshv@gmail.com < ./shared_folder/github_id_rsa.pub

vagrant up

