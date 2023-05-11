param tags object
param pdnsz_n string
@description('virtual network ids')
param vnet_ids array = []

resource pdnsz 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: pdnsz_n
  location: 'global'
  tags: tags
}

resource vnLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = [for i in range(0, length(vnet_ids)) : if(!empty(vnet_ids[i])) {
  parent: pdnsz
  name: '${last(split(vnet_ids[i], '/'))}-link'
  location: 'global'
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: vnet_ids[i]
    }
  }
  tags: tags
}]
