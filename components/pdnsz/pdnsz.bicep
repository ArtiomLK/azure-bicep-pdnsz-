param tags object
param pdnsz_n string
@description('virtual network id')
param vnet_id string = ''

resource pdnsz 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: pdnsz_n
  location: 'global'
  tags: tags
}

resource vnLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = if(!empty(vnet_id)) {
  parent: pdnsz
  name: '${pdnsz_n}-link'
  location: 'global'
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: vnet_id
    }
  }
  tags: tags
}
