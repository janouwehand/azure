-- log in
az login

-- get subscription ad
$SUB = az account show --query id -o tsv
echo $SUB

-- create resource group
az group create --name rg-aca-demo-01 --location westeurope

-- create storage account
az storage account create `
  --name acastorage01xyz `
  --resource-group rg-aca-demo-01 `
  --location westeurope `
  --sku Standard_LRS

-- create file share within storage account to be used by container
az storage share-rm create `
  --resource-group rg-aca-demo-01 `
  --storage-account acastorage01xyz `
  --name shared


-- create container registry
az acr create `
  --name acrdemo01xyz `
  --resource-group rg-aca-demo-01 `
  --sku Basic `
  --admin-enabled true

-- log in
az acr login --name acrdemo01xyz

-- build web
docker build -t web:v1 .\web

-- tag web
docker tag web:v1 acrdemo01xyz.azurecr.io/web:v1

-- push image to registry
docker push acrdemo01xyz.azurecr.io/web:v1

-- build writer
docker build -t writer:v1 .\writer

-- tag writer
docker tag writer:v1 acrdemo01xyz.azurecr.io/writer:v1

-- push writer image to registry
docker push acrdemo01xyz.azurecr.io/writer:v1

-- create aca environment
az containerapp env create `
  --name aca-env-demo-01 `
  --resource-group rg-aca-demo-01 `
  --location westeurope

-- obtain the storage key
$KEY = az storage account keys list `
  --account-name acastorage01xyz `
  --resource-group rg-aca-demo-01 `
  --query "[0].value" -o tsv
echo $KEY

-- set storage
az containerapp env storage set `
  --name aca-env-demo-01 `
  --resource-group rg-aca-demo-01 `
  --storage-name sharedfiles `
  --azure-file-account-name acastorage01xyz `
  --azure-file-account-key "$KEY" `
  --azure-file-share-name shared `
  --access-mode ReadWrite

-- enable admin
az acr update --name acrdemo01xyz --admin-enabled true

$ACR_USER = az acr credential show `
  --name acrdemo01xyz `
  --query username `
  -o tsv

$ACR_PASS = az acr credential show `
  --name acrdemo01xyz `
  --query "passwords[0].value" `
  -o tsv

echo $ACR_PASS

az containerapp create `
  --name test-app `
  --resource-group rg-aca-demo-01 `
  --environment aca-env-demo-01 `
  --image mcr.microsoft.com/azuredocs/containerapps-helloworld:latest `
  --target-port 80 `
  --ingress external

  docker pull nginx
docker tag nginx acrdemo01xyz.azurecr.io/nginx:v1
docker push acrdemo01xyz.azurecr.io/nginx:v1