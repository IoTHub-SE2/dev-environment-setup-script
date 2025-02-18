#!/bin/bash

# Script must run with sudo permissions.
#
# Project template will be created in the current directory of the
# terminal invoking this script.
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
if [[ $vs_code_version == *"not found"* ]]; then
  echo "Visual Studio Code install failed"
  exit 1
fi

# install .NET SDK v8.0
apt-get install dotnet-sdk-8.0

# use Visual Studio Code's provided commands to install
# requisite extensions
code --install-extension ms-dotnettools.csdevkit github.vscode-github-actions 

# create the project directory structure
mkdir ProjectRoot
cd ProjectRoot
mkdir ConsoleAppProj AppTestProj
cd ConsoleAppProj
# create console app from .NET template (.NET v8.0, no top-level statements)
dotnet new console -f net8.0 --use-program-main

# create separate project for unit testing
cd ../AppTestProj
dotnet new mstest -f net8.0 

# add reference of Console App to Test Project in .csproj of the latter
dotnet add AppTestProj.csproj reference ../ConsoleAppProj/ConsoleAppProj.csproj

# build project to create .sln file and verify correct project structure 
#cd ..
dotnet build

exit 0
