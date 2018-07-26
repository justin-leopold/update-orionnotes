<#
.SYNOPSIS
    This script calls two controller scripts to
    get notes from vCenter and add them to Solarwinds Orion.
    This allows alerts to be more useful.
.PARAMETER VMName
 	Name of the Virtual Machine
.PARAMETER vCenterServer
    Name of the vCenter server where the VM(s) resides
    #>

Function Update-OrionNotes {
    [CmdletBinding()]
    param()

#Call the ancillary functions
#BETA, needs global variable passing setup still

Get-VMNotes -VmName $Global:NodeName -vCenterServer $Global:vCenterServer

Set-OrionComments -Hostname $Global:HostName -MonitoredNode $Global:NodeName

}   #close function