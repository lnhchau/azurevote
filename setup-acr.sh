resourceGroup="rg26"
region="westeurope"
myAcrName="myacr202106"
clusterName="udacity-cluster"

az acr create --resource-group $resourceGroup --name $myAcrName --sku Basic
# Log in to the ACR
az acr login --name $myAcrName
# Get the ACR login server name
# To use the azure-vote-front container image with ACR, the image needs to be tagged
# Access the login server address of your registry
# Find the login server address of your registry
az acr show --name $myAcrName --query loginServer --output table

# Associate a tag to the local image
docker tag azure-vote-front:v1 $myAcrName.azurecr.io/azure-vote-front:v1
# Now you will see myacr202106.azurecr.io/azure-vote-front:v1 if you run docker images
# Push the local registry to remote
docker push $myAcrName.azurecr.io/azure-vote-front:v1

# Verify if your image is up in the cloud
az acr repository list --name $myAcrName --output table

# Associate the AKS cluster with the ACR
az aks update -n $clusterName -g $resourceGroup --attach-acr $myAcrName
