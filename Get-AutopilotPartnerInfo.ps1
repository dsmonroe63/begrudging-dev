<### Get-AutopilotPartnerInfo by Sam Monroe

Partner Center allows Microsoft Partners to upload existing devices into Autopilot without gathering the hardware hash. I have found that getting the hash is a bit
of a challenge for our MSP for various reasons. This creates a simple .csv that can be uploaded to each of your customers Autopilot environment. Just enter the Path 
parameter. This file can be hosted on a network share and run from a device management solution (GPO, SCCM, etc.) or just run on an individual machine.

###>

function Get-AutopilotPartnerInfo {

[Cmdletbinding()]

param (
    [Parameter(Mandatory)]
    [string]$Path
    )

$BIOSInfo = Get-CimInstance -ClassName Win32_BIOS
$ModelInfo = Get-CimInstance -ClassName Win32_ComputerSystem

$AutopilotDevices = @(

[pscustomobject]@{

"Device serial number" = $BIOSInfo.SerialNumber
"Windows product ID" = $null
"Hardware hash" = $null
"Manufacturer name" = $BIOSInfo.Manufacturer
"Device Model" = $ModelInfo.Model

}
)

$AutopilotDevices | Export-Csv -Path $Path\AutopilotMachine.csv -NoTypeInformation

}
