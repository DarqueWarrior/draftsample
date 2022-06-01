targetScope = 'subscription'

param location string = 'eastus'
param k8sversion string = '1.23.5'
param rgName string = 'draft_demo'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: rgName
  location: location
}

module aks_aci './aks_aci.bicep' = {
  name: 'aks_aci'
  scope: resourceGroup(rg.name)
  params: {
    location: location
    k8sversion: k8sversion
  }
}

output aksName string = aks_aci.outputs.clusterName
output acrName string = aks_aci.outputs.registryName
