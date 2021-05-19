## Microsoft Function Naming Convention: http://msdn.microsoft.com/en-us/library/ms714428(v=vs.85).aspx
Function Mount-Wim {
<#
.SYNOPSIS
.DESCRIPTION
.PARAMETER
.EXAMPLE
.NOTES
.LINK
.TODO
**Add checks for other mount status.
  *Check for Remount status and apply remounts
  *Check for invalid status and unmount and cleanup
  *check for unavailable, and fix?
  https://www.msigeek.com/2635/unmount-and-clean-up-a-wim-image-using-deployment-image-servicing-and-management-dism
  *Check and handle trying to mount to an already mounted WIM's to the MountPath
	http://psappdeploytoolkit.com
#>
	[CmdletBinding()]
	Param (
    [Parameter(Mandatory=$true)]
        [ValidateScript({Test-Path $_})]
        [string]$ImagePath,
    [Parameter(Mandatory=$true)]
        [ValidateScript({Test-Path $_})]
        [string]$MountPath,
    [Parameter(Mandatory=$false)]
        [ValidateSet("1")]
        [string]$Index = "1"
	)

	Begin {
		## Get the name of this function and write header
		[string]${CmdletName} = $PSCmdlet.MyInvocation.MyCommand.Name
		Write-FunctionHeaderOrFooter -CmdletName ${CmdletName} -CmdletBoundParameters $PSBoundParameters -Header
  }
	Process {
		Try {
      Write-Log -Message "Attempting to Mount Image $ImagePath to $MountPath as ReadOnly." -Severity 1 -LogType "CMTrace" -Source ${CmdletName}
      Mount-WindowsImage -ImagePath "$ImagePath" -Index $Index -Path "$MountPath" -ReadOnly

      Write-Log -Message "Checking Status of Mounted WIM image." -Severity 1 -LogType "CMTrace" -Source ${CmdletName}
      $WIMStatus = $(get-windowsimage -mounted | where-object ImagePath -Like "$ImagePath" | Select -ExpandProperty "MountStatus")
      If ($WIMStatus -eq "Ok") {
        Write-Log -Message "WIM Status is: Okay" -Severity 1 -LogType "CMTrace" -Source ${CmdletName}
      }
      Else {
        Write-Log -Message "WIM Status is not Okay, Error Mounting WIM File. Please Ensure WIM is unmounted, and then verify the integrity of the WIM before trying again." -Severity 3 -LogType "CMTrace" -Source ${CmdletName}
      }
		}
		Catch {
			Write-Log -Message "<error message>. `n$(Resolve-Error)" -Severity 3 -Source ${CmdletName}
		}
	}
	End {
		Write-FunctionHeaderOrFooter -CmdletName ${CmdletName} -Footer
	}
}
