targetScope = 'resourceGroup'

@description('Resource tags')
param tags object = {}

@description('Virtual Networks ID')
param vnet_id string = ''

module pdnsz 'br:bicephubdev.azurecr.io/bicep/modules/pdnsz:0cedf10f8a190b2e01d9005cb3d386f28c329261' = {
  name: 'pdnsz-deployment'
  params: {
    vnet_id: vnet_id
    tags: tags
  }
}
