Repository for custom PSAppDeploy Toolkit with custom extensions.

*Disclaimer: This is personal code shared to allow other users to modularize and use extensions that will be natively available in PSADT. Use at your own risk and recognize that I am not responsible for any issues that arise from the use of this code. Please ensure you validate all code before using in a produciton environment.

1. Copy the Custom Extensions folder with any extensions you wish to use into your PSADT folder.
2. Copy all functions into AppDeployToolkitExtensions.ps1 under the " <Your custom functions go here\>" comment.
3. This should complete installation of modular extensions

### CHANGELOG
List of Exenstions and AppDeployToolkitExtensions changes.

### 11/24/2020
**Extension Added**\
Mount-Wim extension added.\
Following Code Block added to AppDeployToolkitExtensions.ps1
```
##=================##
##   Mount-Wim     ##
##=================##
## Mount-Wim Function dot source to keep extensions modularized and this script cleaner
If (Test-Path -LiteralPath "$scriptDirectory\CustomExtensions\Wim-Tools\Mount-Wim.ps1" -PathType 'Leaf') {
  . "$scriptDirectory\CustomExtensions\Wim-Tools\Mount-Wim.ps1"
  	Write-Log -Message "Loaded Extension: Mount-Wim." -Severity 1 -LogType "CMTrace" -Source $appDeployToolkitExtName
}
##==End Function==##
```

Unmount-Wim extension added.\
Following Code Block added to AppDeployToolkitExtensions.ps1
```
##=================##
##   Unmount-Wim   ##
##=================##
## Unmount-Wim Function dot source to keep extensions modularized and this script cleaner
If (Test-Path -LiteralPath "$scriptDirectory\CustomExtensions\Wim-Tools\Unmount-Wim.ps1" -PathType 'Leaf') {
  . "$scriptDirectory\CustomExtensions\Wim-Tools\Unmount-Wim.ps1"
  	Write-Log -Message "Loaded Extension: Unmount-Wim." -Severity 1 -LogType "CMTrace" -Source $appDeployToolkitExtName
}
##==End Function==##
```

Get-Wim extension added.\
Following Code Block added to AppDeployToolkitExtensions.ps1
```
##=================##
##   Get-Wim       ##
##=================##
## Get-Wim Function dot source to keep extensions modularized and this script cleaner
If (Test-Path -LiteralPath "$scriptDirectory\CustomExtensions\Wim-Tools\Get-Wim.ps1" -PathType 'Leaf') {
  . "$scriptDirectory\CustomExtensions\Wim-Tools\Get-Wim.ps1"
  	Write-Log -Message "Loaded Extension: Get-Wim." -Severity 1 -LogType "CMTrace" -Source $appDeployToolkitExtName
}
##==End Function==##
```

### 11/18/2020
**Extension Added**\
Extract-Zip extension added.\
Following Code Block added to AppDeployToolkitExtensions.ps1
```
##=================##
##   Extract-Zip   ##
##=================##
## Extract-Zip Function dot source to keep extensions modularized and this script cleaner
If (Test-Path -LiteralPath "$scriptDirectory\CustomExtensions\Extract-Zip\Extract-Zip.ps1" -PathType 'Leaf') {
  . "$scriptDirectory\CustomExtensions\Extract-Zip\Extract-Zip.ps1"
  	Write-Log -Message "Loaded Extension: Extract-Zip." -Severity 1 -LogType "CMTrace" -Source $appDeployToolkitExtName
}
##==End Function==##
```
