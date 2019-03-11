# terraformOnAzure

#Install Terraform on Ubuntu 18.04
https://computingforgeeks.com/how-to-install-terraform-on-ubuntu-centos-7/

sudo apt-get install wget
export VER="0.11.10"
wget https://releases.hashicorp.com/terraform/${VER}/terraform_${VER}_linux_amd64.zip
sudo apt-get install unzip
unzip terraform_${VER}_linux_amd64.zip
sudo mv terraform /usr/local/bin/

#run the following exports
export ARM_CLIENT_ID=<CLIENT_ID>
export ARM_CLIENT_SECRET=<CLIENT_SECRET>
export ARM_TENANT_ID=<TENANT_ID>
export subscription_id01=<subscription_id01>
export subscription_id02=<subscription_id01>

#Clone Repo
git clone https://igetit41@github.com/igetit41/terraformOnAzure.git

#Check it
cd terraformOnAzure
terraform init
TF_VAR_subscription_id01=$subscription_id01 TF_VAR_subscription_id02=$subscription_id02 terraform plan




#Apply it
cd terraformOnAzure
TF_VAR_subscription_id01=$subscription_id01 TF_VAR_subscription_id02=$subscription_id02 terraform apply
