# Azure Private DNS Zones (pdnsz)

[![DEV - Deploy Azure Resource](https://github.com/ArtiomLK/azure-bicep-pdnsz/actions/workflows/dev.orchestrator.yml/badge.svg?branch=main&event=push)](https://github.com/ArtiomLK/azure-bicep-pdnsz/actions/workflows/dev.orchestrator.yml)

## Export All Records from one pdnsz to another pdnsz

```bash

```

## Deploy PDNSZ

### Inline Params

```bash
# download bicep deployment template file
curl -o pdnsz-deployment.bicep https://raw.githubusercontent.com/ArtiomLK/azure-bicep-pdnsz/main/deployment.bicep

az deployment group create \
  --name 'pdnsz-deployment-inline-params' \
  --resource-group 'rg-dns' \
  --template-file pdnsz-deployment.bicep \
  --parameters vnet_id=""
```

### Params File

```bash
# download bicep deployment template file
curl -o pdnsz-deployment.bicep https://raw.githubusercontent.com/ArtiomLK/azure-bicep-pdnsz/main/deployment.bicep

# download bicep parameters file
curl -o pdnsz-parameters.json https://raw.githubusercontent.com/ArtiomLK/azure-bicep-pdnsz/main/parameters/pdsnz-parameters.json

az deployment group create \
  --name 'pdnsz-deployment-file-params' \
  --resource-group 'rg-dns' \
  --template-file pdnsz-deployment.bicep \
  --parameters @pdnsz-parameters.json
```

## Additional Resources

- PDNSZ
- [MS | Docs | Azure Private Endpoint DNS configuration][3]
- [MS | Docs | Private Link and DNS integration at scale][4]
- Bicep
- [MS | Docs | Deployment functions for Bicep][1]
- [MS | Docs | Linter rule - no hardcoded environment URL][2]

[1]: https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/bicep-functions-deployment
[2]: https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/linter-rule-no-hardcoded-environment-urls
[3]: https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-dns
[4]: https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/private-link-and-dns-integration-at-scale
