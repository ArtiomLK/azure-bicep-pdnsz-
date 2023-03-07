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
// PDNSZ Deployment Examples
// ------------------------------------------------------------------------------------------------
module pdnsz '../main.bicep' = {
  name: 'pdnsz'
  params: {
    location: location
    tags: tags
  }
}
