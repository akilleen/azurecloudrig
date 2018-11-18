#!/bin/bash

snapshotName='gaming'
resourceGroupName='GAMING'
diskName='gaming-disk'
storageType='Standard_LRS'
diskSize='127'
virtualMachineName='azuregaming'

snapshotId=$(az snapshot show --name $snapshotName \
    --resource-group $resourceGroupName \
    --query [id] --output tsv)
az disk create \
    --resource-group $resourceGroupName \
    --name $diskName \
    --sku $storageType \
    --size-gb $diskSize \
    --source $snapshotId
managedDiskId=$(az disk show --name $diskName \
    --resource-group $resourceGroupName \
    --query [id] --output tsv) 
az vm create --name $virtualMachineName \
    --resource-group $resourceGroupName \
    --attach-os-disk $managedDiskId \
    --os-type Windows \
    --size Standard_NV6 \
    --public-ip-address-allocation dynamic