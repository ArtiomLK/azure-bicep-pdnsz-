targetScope = 'resourceGroup'
// ------------------------------------------------------------------------------------------------
// Deployment parameters
// ------------------------------------------------------------------------------------------------
// Sample tags parameters
var tags = {
  project: 'bicephub'
  env: 'dev'
}

param location string = 'eastus2'

// ------------------------------------------------------------------------------------------------
// Sample Vnet
// ------------------------------------------------------------------------------------------------
var subnets = [
  {
    name: 'snet-a'
    subnetPrefix: '192.160.0.0/28'
    privateEndpointNetworkPolicies: 'Enabled'
    delegations: []
  }
]

resource vnetApp 'Microsoft.Network/virtualNetworks@2021-02-01' = {
  name: 'vnet-bicep'
  location: location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: [
        '192.160.0.0/24'
      ]
    }
    subnets: [for subnet in subnets: {
      name: subnet.name
      properties: {
        addressPrefix: subnet.subnetPrefix
        delegations: subnet.delegations
        privateEndpointNetworkPolicies: subnet.privateEndpointNetworkPolicies
      }
    }]
  }
}

var subnets2 = [
  {
    name: 'snet-a'
    subnetPrefix: '192.161.0.0/28'
    privateEndpointNetworkPolicies: 'Enabled'
    delegations: []
  }
]

resource vnetApp2 'Microsoft.Network/virtualNetworks@2021-02-01' = {
  name: 'vnet-bicep2'
  location: location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: [
        '192.161.0.0/24'
      ]
    }
    subnets: [for subnet in subnets2: {
      name: subnet.name
      properties: {
        addressPrefix: subnet.subnetPrefix
        delegations: subnet.delegations
        privateEndpointNetworkPolicies: subnet.privateEndpointNetworkPolicies
      }
    }]
  }
}

// ------------------------------------------------------------------------------------------------
// PDNSZ Deployment Examples
// ------------------------------------------------------------------------------------------------
module pdnsz '../main.bicep' = {
  name: 'pdnsz'
  params: {
    vnet_ids: [vnetApp.id, vnetApp2.id]
    location: location
    tags: tags
  }
}
