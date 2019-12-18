$ErrorActionPreference = 'Stop'

$packageName = 'intelCppZip'
$filePath    = [System.IO.Path]::GetFullPath("${Env:TEMP}\intelRedistributable")
$fileUrl    = "$filePath\ww_icl_redist_ia32_2019.5.281.msi"
$fileUrl64  = "$filePath\ww_icl_redist_intel64_2019.5.281.msi"
$checksum   = "9ec6f0594556eacdecc7f06bbe5471bd72c4d4a64d78731ad2a9e6faa360efe5"
$checksum64 = "96396b4225836a17e482abefbd0d575e56cb6329bd0302357aed4c97d04e17cd"

Install-ChocolateyZipPackage `
  -PackageName $packageName `
  -Url 'http://registrationcenter-download.intel.com/akdlm/irc_nas/tec/15799/ww_icl_redist_msi_2019.5.281.zip' `
  -UnzipLocation $filePath `
  -Checksum '880A8758F5B553BAB937D4C8DE3CA2243FB48678D120ECFB6B858CAB59E23FBE' `
  -ChecksumType 'sha256'

Install-ChocolateyInstallPackage `
  -PackageName $env:ChocolateyPackageName `
  -FileType 'msi' `
  -SilentArgs '/quiet' `
  -File64 $fileUrl64 `
  -File $fileUrl `
  -Checksum64 $checksum64 `
  -Checksum $checksum `
  -ValidExitCodes @(0, 3010)