# terraformOnAzure

#Install Terraform on Ubuntu 18.04
https://computingforgeeks.com/how-to-install-terraform-on-ubuntu-centos-7/

#Clone Repo
git clone https://igetit41@github.com/igetit41/terraformOnAzure.git

#Append to end of .bashrc and then "sudo reboot"
ARM_CLIENT_ID=<CLIENT_ID>
ARM_CLIENT_SECRET=<CLIENT_SECRET>
ARM_TENANT_ID=<TENANT_ID>
subscription_id01=<subscription_id01>
subscription_id02=<subscription_id01>

#Check it
cd terraformOnAzure
terraform init
TF_VAR_subscription_id01=$subscription_id01 TF_VAR_subscription_id02=$subscription_id02 terraform plan

#Apply it
cd terraformOnAzure
TF_VAR_subscription_id01=$subscription_id01 TF_VAR_subscription_id02=$subscription_id02 terraform apply
