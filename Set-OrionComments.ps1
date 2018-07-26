<#
.SYNOPSIS
Sets the Comments field via the Solarwinds API
.DESCRIPTION
Sets the Comments field via the Solarwinds API
This can be used in another function to call the data in.
For example, injecting VM Notes into solarwinds for alerting.
.PARAMETER Hostname
Hostname defines the name of the node in Orion
This must match the node name for the changes to be made
.EXAMPLE
Set-OrionComments -Hostname 'solarwinds.internal.com' -NodeName 'server1'
.LINK
https://repo.dpsk12.org/justin_leopold/VMWare/Set-OrionComments.ps1
.LINK
#>

Function Set-OrionComments {
    [CmdletBinding()]
    param
    (
        #Solarwinds Server name
        [Parameter(Mandatory)]
        [string]$Hostname,

        #Node Name
        [Parameter(Mandatory)]
        [string]$NodeName

    )

# Connect to SWIS API
#$hostname = "solarwinds.dpsk12.org"
#$username = "justin_leopold@dpsuser.dpsk12.org"
$cred = Get-credential
$swis = Connect-Swis -host $Hostname -cred $cred

# Gather node info from param block
$nodeIP = [Net.DNS]::GetHostEntry("$NodeName").addresslist.ipaddresstostring
$NodeID = (Get-OrionNode -IPAddress $nodeIP -SwisConnection $swis).NodeID

# InterfaceID of an interface on the node, not in use
#$ifaceId = 58

# prepare a custom property value, take this value from another module in the controller script
$CustomProps = @{
    Comments = "$Note";
}

# build the node URI
$uri = "swis://$Hostname/Orion/Orion.Nodes/NodeID=$($NodeID)/CustomProperties";

# set the custom property
Set-SwisObject $swis -Uri $uri -Properties $CustomProps

#Not in use, saved until additional module is written for interfaces
# build the interface URI
#$uri = "swis://localhost/Orion/Orion.Nodes/NodeID=$($nodeId)/Interfaces/InterfaceID=$($ifaceId)/CustomProperties";

# set the custom property
#Set-SwisObject $swis -Uri $uri -Properties $customProps

}#close function