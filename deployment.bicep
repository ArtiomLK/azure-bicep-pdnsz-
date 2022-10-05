targetScope = 'resourceGroup'

@description('Resource tags')
param tags object = {}

@description('Virtual Networks ID')
param vnet_id string

module pdnsz 'br:bicephubdev.azurecr.io/bicep/modules/pdnsz:79104a59250ef12bbc4c4c30ec5a56f16ce104c2' = {
  name: 'pdnsz-deployment'
  params: {
    vnet_id: vnet_id
    tags: tags
  }
}
