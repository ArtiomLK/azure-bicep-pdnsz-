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

resource vnet1 'Microsoft.Network/virtualNetworks@2021-02-01' = {
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

resource vnet2 'Microsoft.Network/virtualNetworks@2021-02-01' = {
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

var subnets3 = [
  {
    name: 'snet-a'
    subnetPrefix: '192.161.0.0/28'
    privateEndpointNetworkPolicies: 'Enabled'
    delegations: []
  }
]

resource vnet3 'Microsoft.Network/virtualNetworks@2021-02-01' = {
  name: 'vnet-bicep3'
  location: location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: [
        '192.162.0.0/24'
      ]
    }
    subnets: [for subnet in subnets3: {
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
// DEPLOY 1 PDNSZ
// ------------------------------------------------------------------------------------------------
module onePdnsz '../main.bicep' = {
  name: 'one-pdnsz'
  params: {
    pdnszs: ['one-pdnsz.com']
    location: location
    tags: tags
  }
}

// DEPLOY 1 PDNSZ w vnet link
module onePdnszWvnetLink '../main.bicep' = {
  name: 'one-pdnsz-w-vnet-link'
  params: {
    pdnszs: ['one-pdnsz-w-vnetlink.com']
    vnet_ids: [
      {
        id: vnet1.id
        auto_registration: false
      }
      {
        id: vnet2.id
        auto_registration: true
      }
    ]
    location: location
    tags: tags
  }
}

// ------------------------------------------------------------------------------------------------
// DEPLOY N PDNSZ
// ------------------------------------------------------------------------------------------------
module nPdnsz '../main.bicep' = {
  name: 'n-pdnsz'
  params: {
    pdnszs: ['n-one-pdnsz.com', 'n-two-pdnsz.com', 'n-three-pdnsz.com']
    location: location
    tags: tags
  }
}

// DEPLOY N PDNSZ W vnetLink
module nPdnszWvnetLink '../main.bicep' = {
  name: 'n-pdnsz-w-vnet-link'
  params: {
    pdnszs: ['n-one-pdnsz-w-vnetlink.com', 'n-two-pdnsz-w-vnetlink.com', 'n-three-pdnsz-w-vnetlink.com']
    vnet_ids: [
      {
        id: vnet1.id
        auto_registration: false
      }
      {
        id: vnet2.id
        auto_registration: false
      }
    ]
    location: location
    tags: tags
  }
}

// ------------------------------------------------------------------------------------------------
// DEPLOY ALL PDNSZ W vnetLink
// ------------------------------------------------------------------------------------------------
module pdnsz '../main.bicep' = {
  name: 'pdnsz'
  params: {
    deploy_all_pdnszs: true
    vnet_ids: [
      {
        id: vnet3.id
        auto_registration: false
      }
    ]
    location: location
    tags: tags
  }
}
