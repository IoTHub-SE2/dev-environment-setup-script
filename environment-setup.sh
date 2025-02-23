#!/bin/bash

# Script must run with sudo permissions.
######################################################################

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

# install .NET SDK v8.0
apt-get install dotnet-sdk-8.0

# use Visual Studio Code's provided commands to install
# requisite extensions
# DEV NOTE: There are several addons for NuGet, find optimal one to include here
code --install-extension ms-dotnettools.csdevkit github.vscode-github-actions  

# Install MongoDB Server Community Edition

# Install MongoDB Compass

# Install requisite NuGet packages for working with MongoDB in VS Code


exit 0
