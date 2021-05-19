#======================#
#     Extract-Zip      #
#======================#
#Version: 0.1
Function Extract-Zip {
<#
.SYNOPSIS
##Uses Expand-Archive Function for Extracting Zip files natively by PowerShell
.DESCRIPTION
## Function to Extract zip files natively through powershell and place them in desired directory.
.PARAMETER
# -Path <Path of zip file>
# -Destination <Path to Extract zip to>
# -Parameters can either use -Force (Default option) or -Confirm or no paramter. Force will overwrite the directory if there are duplicates.DESCRIPTION
# Confirm will ask for confirmation before executing (Not really used) and no parameter will attempt to extract but fail if there are files to overwrite.
.EXAMPLE
## Exract-Zip -Path "C:\Test\testzip.zip" -Destination "C:\test" -Parameters "-Force"
.NOTES
## WIP
Installation:
The following needs to be added to the "AppDeployToolkitExtensions.ps1", under the "# <Your custom functions go here>".

If (Test-Path -LiteralPath "$scriptDirectory\CustomExtensions\Extract-Zip\Extract-Zip.ps1" -PathType 'Leaf') {
  . "$scriptDirectory\CustomExtensions\Extract-Zip\Extract-Zip.ps1"
  	Write-Log -Message "Loaded Extension: Extract-Zip." -Severity 1 -LogType "CMTrace" -Source $appDeployToolkitExtName
}

Please post issues witht the script to the github repo for issue tracking and bug fixing.
.LINK
	http://psappdeploytoolkit.com
.TODO
##Push Checks for PS version 5.0 as function prerequisite
##Push Checks for .NET 4.5 as function prerequisite
##Allow switching between PSv5 and .NET 4.5 functions for extracting archives based on detected prerequisite
##Add more verbose logging
##Fix -Confirm parameter to allow confirmation through GUI
#>
  [CmdletBinding()]
  Param (
    [Parameter(Mandatory=$true)]
        [ValidateScript({Test-Path $_})]
        [string]$Path,
    [Parameter(Mandatory=$true)]
        [ValidateNotNullorEmpty()]
        [string]$Destination,
    [Parameter(Mandatory=$false)]
        [ValidateSet("-Force", "-Confirm", "", ignorecase=$true)]
        [string]$Parameters = ""
  )

	Begin {
		## Get the name of this function and write header
		[string]${CmdletName} = $PSCmdlet.MyInvocation.MyCommand.Name
		Write-FunctionHeaderOrFooter -CmdletName ${CmdletName} -CmdletBoundParameters $PSBoundParameters -Header

    ##Test if path is valid
    if (!(Test-Path $Destination)) {
      ##If path is not valid, log result and create the directory
      Write-Log -Message "Destination does not exist. Creating Directory." -Severity 1 -LogType "CMTrace" -Source ${CmdletName}
    }
    Elseif (Test-Path $Destination) {
      ##If path is valid, log result and continue on to extract anyways
      Write-Log -Message "Destination path exists. Extracting to $Destination anyway." -Severity 1 -LogType "CMTrace" -Source ${CmdletName}
    }
	Else {
    ## write to log that destination path could not be verified
	  Write-Log -Message "Error Validating Destination." -Severity 2 -LogType "CMTrace" -Source ${CmdletName}
	}

    ##Convert Parameter to lowercase
    $Parameters = $Parameters.ToLower()
  }
	Process {
		Try {
      Write-Log -Message "Attempting to Extract: $Path, to $Destination, with switches $Parameters" -Severity 1 -LogType "CMTrace" -Source ${CmdletName}
      if ($Parameters -eq "-force"){
        ##Execute command with "-Force" parameter (Default)
        Write-Log -Message '"-Force" Parameter Specified, Overriding Destination.' -Severity 2 -LogType "CMTrace" -Source ${CmdletName}
        Expand-Archive -Path "$Path" -DestinationPath "$Destination" -Force
      }
      elseif ($Parameters -eq "-confirm"){
        ##Execute command with "-Confirm" parameter
        Write-Log -Message '"-Confirm" Parameter Specified,This may cause the installation to fail.' -Severity 3 -LogType "CMTrace" -Source ${CmdletName}
        Expand-Archive -Path "$Path" -DestinationPath "$Destination" -Confirm
      }
      else{
        ##Execute command without any parameters
        Write-Log -Message 'No Parameter Specified, Running Extract-Zip without any Parameters.' -Severity 2 -LogType "CMTrace" -Source ${CmdletName}
        Expand-Archive -Path "$Path" -DestinationPath "$Destination"
      }
		}
		Catch {
			Write-Log -Message "Failed to Extract zip to specified Directory. `n$(Resolve-Error)" -Severity 3 -Source ${CmdletName}
    }
	}
	End {
		Write-FunctionHeaderOrFooter -CmdletName ${CmdletName} -Footer
	}
}
##End Function
