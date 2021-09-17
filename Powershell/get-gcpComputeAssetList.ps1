<#
    This script retrieves compute engine assets via the Asset Manager API. Requirments to use this script include:
    1.) Account with Cloud Asset Viewer role assigned at the Organization level
    2.) Gcloud SDK installed and initiated with authentication to your organization. 

    Asset types can be viewed here: 
    https://cloud.google.com/asset-inventory/docs/supported-asset-types

    Example:

    ./get-gcpComputeAssetList.ps1 -orgid <organization ID> -resource <compute resource, i.e firewall or interconnect>
#>

param (
    $orgid,
    $resource
)

$resources = gcloud asset list --organization $orgid --filter=assetType:compute.googleapis.com/$resource --format="json" 
$resourceList = $resources | ConvertFrom-Json
return $resourceList
