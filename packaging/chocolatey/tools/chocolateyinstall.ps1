$ErrorActionPreference = 'Stop'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageName = 'google-messages-app'
$version = '1.0.0'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'exe'
  url64bit      = "https://github.com/cwahlfeldt/google-messages/releases/download/v$version/GoogleMessages-v$version-win.exe"
  
  softwareName  = 'Google Messages*'
  
  checksum64    = 'PUT_ACTUAL_CHECKSUM_HERE'
  checksumType64= 'sha256'
  
  silentArgs    = '/S'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs