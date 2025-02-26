#!/bin/bash

######################################################################
# Script must run with sudo permissions.
sudo -v
# create new root directory for project and enter it
mkdir SE2_IoT_Hub && cd SE2_IoT_Hub
# get updated package lists
apt-get update
# upgrade existing packages
apt-get upgrade -y
# grab Visual Studio Code .deb binary
wget "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
# resulting download is a valid .deb binary, but must be renamed for 
# recognition by apt
mv 'download?build=stable&os=linux-deb-x64' vscode.deb
# install freshly renamed deb file
apt-get install ./vscode.deb

# verify vs code was successfully installed to the system
vs_code_version=$(code --version)
if [[ $vs_code_version == ".*not found*" ]]; then
  echo "Visual Studio Code install failed"
  exit 1
fi

# install .NET SDK v8.0, github cli tools (for authentication)
apt-get install -y dotnet-sdk-8.0 gh

# use Visual Studio Code's provided commands to install
# requisite extensions
code --install-extension ms-dotnettools.csdevkit github.vscode-github-actions aliasadidev.nugetpackagemanagergui 

# Install MongoDB Server Community Edition
wget "https://repo.mongodb.org/apt/ubuntu/dists/noble/mongodb-org/8.0/multiverse/binary-amd64/mongodb-org-server_8.0.5_amd64.deb"
apt-get install ./mongodb-org-server_8.0.5_amd64.deb

# Install MongoDB Compass
wget "https://downloads.mongodb.com/compass/mongodb-compass_1.45.3_amd64.deb"
apt-get install ./mongodb-compass_1.45.3_amd64.deb

# get github credentials 
yellow='\033[0;33m'
clear='\033[0m'
echo -e "${yellow}If you're already logged into Github, you can press CTRL+C to skip the following login prompt.${clear}"
gh auth login

# clone project (currently smarthub repo) 

git clone https://github.com/IoTHub-SE2/smartHub

# success message
green='\033[0;32m'
echo -e "${green}###################\n# Setup Complete! #\n###################${clear}"

exit 0
