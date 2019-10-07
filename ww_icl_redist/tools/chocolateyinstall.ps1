$ErrorActionPreference = 'Stop'; # stop on all errors

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url        = 'https://storage.googleapis.com/win-installers.admobilize.com/thirdParty/ww_icl_redist_ia32_2019.5.281.msi'
$url64      = 'https://storage.googleapis.com/win-installers.admobilize.com/thirdParty/ww_icl_redist_intel64_2019.5.281.msi'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'MSI'
  url           = $url
  url64         = $url64
  softwareName  = 'intel-redistributable-cpp*'
  checksum      = '9EC6F0594556EACDECC7F06BBE5471BD72C4D4A64D78731AD2A9E6FAA360EFE5'
  checksum64    = '96396B4225836A17E482ABEFBD0D575E56CB6329BD0302357AED4C97D04E17CD'
  checksumType  = 'sha256'
  silentArgs    = "/quiet"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs