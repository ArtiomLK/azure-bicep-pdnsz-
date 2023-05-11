targetScope = 'resourceGroup'

@description('Resource tags')
param tags object = {}

@description('Virtual Networks ID')
param vnet_ids array = []

module pdnsz 'br:bicephubdev.azurecr.io/bicep/modules/pdnsz:185462bc91fee795d8ff7d848980f7f2a67ff4be' = {
  name: 'pdnsz-deployment'
  params: {
    vnet_ids: vnet_ids
    tags: tags
  }
}
