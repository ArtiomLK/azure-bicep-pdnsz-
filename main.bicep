targetScope = 'resourceGroup'
// ------------------------------------------------------------------------------------------------
// Deployment parameters
// ------------------------------------------------------------------------------------------------
param location string = resourceGroup().location

@description('Az Resources tags')
param tags object = {}

// ------------------------------------------------------------------------------------------------
// PDNSZ configuration parameters
// ------------------------------------------------------------------------------------------------
param vnet_id string

var pdnsz_list = [
  'privatelink.azure-automation.net'
  'privatelink.${environment().suffixes.sqlServerHostname}'
  'privatelink.sql.azuresynapse.net'
  'privatelink.dev.azuresynapse.net'
  'privatelink.azuresynapse.net'
  'privatelink.blob.${environment().suffixes.storage}'
  'privatelink.table.${environment().suffixes.storage}'
  'privatelink.queue.${environment().suffixes.storage}'
  'privatelink.file.${environment().suffixes.storage}'
  'privatelink.web.${environment().suffixes.storage}'
  'privatelink.dfs.${environment().suffixes.storage}'
  'privatelink.documents.azure.com'
  'privatelink.mongo.cosmos.azure.com'
  'privatelink.cassandra.cosmos.azure.com'
  'privatelink.gremlin.cosmos.azure.com'
  'privatelink.table.cosmos.azure.com'
  'privatelink.${location}.batch.azure.com'
  'privatelink.postgres.database.azure.com'
  'privatelink.mysql.database.azure.com'
  'privatelink.mariadb.database.azure.com'
  'privatelink.vaultcore.azure.net'
  'privatelink.managedhsm.azure.net'
  'privatelink.${location}.azmk8s.io'
  'privatelink.search.windows.net'
  'privatelink.${environment().suffixes.acrLoginServer}'
  'privatelink.azconfig.io'
  'privatelink.siterecovery.windowsazure.com'
  'privatelink.servicebus.windows.net'
  'privatelink.azure-devices.net'
  'privatelink.eventgrid.azure.net'
  'privatelink.azurewebsites.net'
  'privatelink.api.azureml.ms'
  'privatelink.notebooks.azure.net'
  'privatelink.service.signalr.net'
  'privatelink.monitor.azure.com'
  'privatelink.oms.opinsights.azure.com'
  'privatelink.ods.opinsights.azure.com'
  'privatelink.agentsvc.azure-automation.net'
  'privatelink.cognitiveservices.azure.com'
  'privatelink.afs.azure.net'
  'privatelink.datafactory.azure.net'
  'privatelink.adf.azure.com'
  'privatelink.redis.cache.windows.net'
  'privatelink.redisenterprise.cache.azure.net'
  'privatelink.purview.azure.com'
  'privatelink.purviewstudio.azure.com'
  'privatelink.digitaltwins.azure.net'
  'privatelink.azurehdinsight.net'
  'privatelink.his.arc.azure.com'
  'privatelink.guestconfiguration.azure.com'
  'privatelink.media.azure.net'
]

// ------------------------------------------------------------------------------------------------
// Private DNS zones
// ------------------------------------------------------------------------------------------------
module pdnszDeploy 'components/pdnsz/pdnsz.bicep' = [for pdnsz_n in pdnsz_list: {
  name: 'pdnsz-deployment-${pdnsz_n}'
  params: {
    tags: tags
    pdnsz_n: pdnsz_n
    vnet_id: vnet_id
  }
}]
