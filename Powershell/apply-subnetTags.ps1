# Applies a network tag to all Instances in a given subnet
param (
    $subnetname,
    $tagname
)
$instances = get-gceinstance
foreach ($instance in $instances){
$subnetstring = $instance.networkinterfaces.subnetwork
$zonestring = $instance.zone
$spos = $subnetstring.indexOf("subnetworks/")
$zpos = $zonestring.indexOf("zones/")
$zone = $zonestring.Substring($zpos+6)
if ($subnetstring.Substring($spos+12) -match $subnetname){
    set-gceinstance -Name $instance.Name -Zone $zone -AddTag $tagname
}
}