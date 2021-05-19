## Microsoft Function Naming Convention: http://msdn.microsoft.com/en-us/library/ms714428(v=vs.85).aspx
Function Get-Wim {
<#
.SYNOPSIS
.DESCRIPTION
.PARAMETER
.EXAMPLE
.NOTES
.LINK
.TODO
-Add More verbose logs to help with troubleshooting
-Add error handling
-Add instructions
	http://psappdeploytoolkit.com
#>
	[CmdletBinding()]
	Param (
    [Parameter(Mandatory=$true)]
        [ValidateSet("Path", "ImagePath", "ImageIndex", "MountMode", "MountStatus", ignorecase=$true)]
        [string]$Property,
    [Parameter(Mandatory=$True)]
        [ValidateNotNullorEmpty()]
        [string]$Name
	)

	Begin {
		## Get the name of this function and write header
		[string]${CmdletName} = $PSCmdlet.MyInvocation.MyCommand.Name
		Write-FunctionHeaderOrFooter -CmdletName ${CmdletName} -CmdletBoundParameters $PSBoundParameters -Header
	}
	Process {
		Try {
      $result = "$(get-windowsimage -mounted | where-object ImagePath -Match "*$Name*" | Select -ExpandProperty "$Property")"
		}
		Catch {
			Write-Log -Message "<error message>. `n$(Resolve-Error)" -Severity 3 -Source ${CmdletName}
		}

    Return $result
	}
	End {
		Write-FunctionHeaderOrFooter -CmdletName ${CmdletName} -Footer
	}
}
