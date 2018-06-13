Cloud Dev Box
=============

Terraform based infrastructure to deploy RDP-able VMs in Azure. cloudVM.tf contains the main terraform script for deploying the VM

1. The scripts main parameter is a `userName` and `password`
2. userName is used to derive most of the resources used. E.g. the resource group
   is named `<<userName>>CloudDevBoxRG`
3. NSG rules are used to lock down the VM with no internet access. Additional
   `network_allow_rules` parameter can be passed to open up safe ip-ranges, e.g.
   the corp ip-range or home ip-range from where ssh and rdp is used to login
4. By default Standard_F8s VM size is used. Override `vm_size` to choose bigger
   machines for better remoting experience

You can download the files in this folder and directly use terraform to run it.

    terraform apply -var 'userName=cooldev' -var 'network_allow_rules=[\"131.107.0.0/16,22,TCP\", \"131.107.0.0/16,3389,TCP\"]'

This will prompt for password. The `network_allow_rules` is arrays of strings of format <ip-range,port,protocol>.

A wrapper script cloudshelldeploy.sh is provided. Currently it is specific to
Microsoft corporate ip-ranges being opened. This script is designed to be 
run from https://shell.azure.com. It can be run from any dev box as well. 
The requirements is that az CLI is installed and so is terraform. Just ensure
you have used the following to login and setup the right subscription under which the VM will be created.

    az login # NOT required in shell.azure.com as you already logged in
    az account set --subscription="<your subscription ID>"

Once that is done you can simply run the following to use the script as is 
(only make sense for MSFT developers) or make changes to support your own 
custom IP-ranges

    curl -O https://raw.githubusercontent.com/bonggeek/share/master/cloudbox/cloudshelldeploy.sh

    chmod +x cloudshelldeploy.sh
    # Make changes to cloudshelldeploy if needed
    ./cloudshelldeploy.sh abhinab

Once terraform is done installing RDP from windows machine using mstsc.exe.

**NOTE: In my experience 1080p resolution works well**, 4K lags too much to be 
useful. Since mstsc default is full-screen be careful if you are working 
on hi-res display and explicitly use 1080p resolution.
