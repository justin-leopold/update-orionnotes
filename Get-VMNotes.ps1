<#
.SYNOPSIS
    This script gathers the VM Notes for insertion elsewhere.
    Used as part of a controller script.
.PARAMETER VMName
 	Name of the Virtual Machine
.PARAMETER vCenterServer
    Name of the vCenter server where the VM(s) resides
    #>

Function Get-VMNotes {
    [CmdletBinding()]
    param
    (
        #Virtual machine name
        [Parameter(Mandatory)]
        [string[]]$Global:NodeName,

        #vCenter Server Name
        [Parameter(Mandatory)]
        [ValidateSet('pdcvcenter', 'sdcvcenter')]
        [string]$Global:vCenterServer

    )

    #Connect to vCenter
    Write-Verbose "Enter vCenter Credential"
    $credentials = Get-Credential
    Connect-VIServer -Server $Global:vCenterServer -Credential $credentials
    $global:Note = (Get-VM -Name $Global:NodeName).Notes

    #Information gathering begins here

}   #close function