## Microsoft Function Naming Convention: http://msdn.microsoft.com/en-us/library/ms714428(v=vs.85).aspx
Function Unmount-Wim {
<#
.SYNOPSIS
.DESCRIPTION
.PARAMETER
.EXAMPLE
.NOTES
.LINK
.TODO
#Add Error handling for unmounting wims (I.E. Retrying unmounts or take other actions)
https://www.msigeek.com/2635/unmount-and-clean-up-a-wim-image-using-deployment-image-servicing-and-management-dism
#Add more log writing to provide easier troubleshooting to the user
	http://psappdeploytoolkit.com
#>
	[CmdletBinding()]
	Param (
    [Parameter(Mandatory=$true)]
        [ValidateScript({Test-Path $_})]
        [string]$MountPath
	)

	Begin {
		## Get the name of this function and write header
		[string]${CmdletName} = $PSCmdlet.MyInvocation.MyCommand.Name
		Write-FunctionHeaderOrFooter -CmdletName ${CmdletName} -CmdletBoundParameters $PSBoundParameters -Header
	}
	Process {
		Try {

      Dismount-WindowsImage -Path "$MountPath" -Discard

      $Mounted = "$(get-windowsimage -mounted | where-object ImagePath -Like "$MountPath")"
      If ($Mounted -eq "" -OR $Mounted -eq $null) {
        Write-Log -Message "WIM has successfully Unmounted." -Severity 1 -LogType "CMTrace" -Source ${CmdletName}
      }
      Else {
        Write-Log -Message "WIM Failed to unmount. Please manually unmount and cleanup WIM." -Severity 3 -LogType "CMTrace" -Source ${CmdletName}
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
