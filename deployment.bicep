targetScope = 'resourceGroup'

@description('Resource tags')
param tags object = {}

@description('Virtual Networks ID')
param vnet_id string

module pdnsz 'br:bicephubdev.azurecr.io/bicep/modules/pdnsz:a5bdb9c494b08157eb0771c18c4afbe3c1fb0887' = {
  name: take('pdnsz-${string(resourceGroup().id)}', 64)
  params: {
    vnet_id: vnet_id
    tags: tags
  }
}
