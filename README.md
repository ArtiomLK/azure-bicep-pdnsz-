# Azure Private DNS Zones (pdnsz)

[![DEV - Deploy Azure Resource](https://github.com/ArtiomLK/azure-bicep-pdnsz/actions/workflows/dev.orchestrator.yml/badge.svg?branch=main&event=push)](https://github.com/ArtiomLK/azure-bicep-pdnsz/actions/workflows/dev.orchestrator.yml)

## Deploy PDNSZ

### Inline Params

```bash
# download bicep deployment template file
curl -o pdnsz-deployment.bicep https://raw.githubusercontent.com/ArtiomLK/azure-bicep-pdnsz/main/deployment.bicep

az deployment group create \
  --name 'pdnsz-deployment' \
  --resource-group 'rg-dns' \
  --template-file pdnsz-deployment.bicep \
  --parameters vnet_id="/subscriptions/########-####-####-####-############/resourceGroups/<rg-name>/providers/Microsoft.Network/virtualNetworks/<vnet-name>"
```

### Params File

```bash
# download bicep deployment template file
curl -o pdnsz-deployment.bicep https://raw.githubusercontent.com/ArtiomLK/azure-bicep-pdnsz/main/deployment.bicep

# download bicep parameters file
curl -o pdnsz-parameters.json https://raw.githubusercontent.com/ArtiomLK/azure-bicep-pdnsz/main/parameters/pdsnz-parameters.json

az deployment group create \
  --name 'pdnsz-deployment' \
  --resource-group 'rg-dns' \
  --template-file pdnsz-deployment.bicep \
  --parameters @pdnsz-parameters.json
```

## Combine multiple az pdnsz into a single pdnsz

```bash
rg_names=(
rg-a
rg-b
rg-n
);

i=1; echo $i
for rg_n in "${rg_names[@]}"
do
  echo Number: $i;
  echo "vm_n: $vm_arc_n";
  az network private-dns zone export \
  -g $rg_n \
  -n privatelink.azurewebsites.net \
  -f "${i}-privatelink.azurewebsites.net.txt" \
  --subscription '########-####-####-####-############'
  echo "";
  ((i++))
done

e=1; echo $e
while [ $e -lt $i ]
do
  echo File: "${e}-privatelink.azurewebsites.net.txt";
  az network private-dns zone import \
  -g rg-alz-pdnsz \
  -n privatelink.azurewebsites.net \
  -f "${e}-privatelink.azurewebsites.net.txt" \
  --subscription '########-####-####-####-############'
  echo "";
  ((e++))
done
```

## Additional Resources

- PDNSZ
- [MS | Docs | Azure Private Endpoint DNS configuration][3]
- [MS | Docs | Private Link and DNS integration at scale][4]
- [MS | Docs | Import and export a private DNS zone file for Azure private DNS][5]
- Bicep
- [MS | Docs | Deployment functions for Bicep][1]
- [MS | Docs | Linter rule - no hardcoded environment URL][2]

[1]: https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/bicep-functions-deployment
[2]: https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/linter-rule-no-hardcoded-environment-urls
[3]: https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-dns
[4]: https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/private-link-and-dns-integration-at-scale
[5]: https://learn.microsoft.com/en-us/azure/dns/private-dns-import-export
