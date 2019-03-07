# terraformOnAzure

#Install Terraform on Ubuntu 18.04
https://computingforgeeks.com/how-to-install-terraform-on-ubuntu-centos-7/

#Append to end of .bashrc and then "sudo reboot"
ARM_CLIENT_ID=<CLIENT_ID>
ARM_CLIENT_SECRET=<CLIENT_SECRET>
ARM_TENANT_ID=<TENANT_ID>
subscription_id01=<subscription_id01>
subscription_id02=<subscription_id01>

#Pass Subscriptions 
TF_VAR_subscription_id01=$subscription_id01 TF_VAR_subscription_id02=$subscription_id02 terraform plan
