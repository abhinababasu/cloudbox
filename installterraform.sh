#!/bin/bash

# ==============================================================i
# Terraform

terraform_url=$(curl -s https://releases.hashicorp.com/index.json | jq '{terraform}' | egrep "linux.*amd64" | sort --version-sort -r | head -1 | awk -F[\"] '{print $4}')
echo "Installing from $terraform_url"
f=$(mktemp)
echo "Downloading"
curl -s -o $f $terraform_url
echo "Downloaded"
pushd /usr/local/bin
unzip -u $f
rm -f $f
popd
