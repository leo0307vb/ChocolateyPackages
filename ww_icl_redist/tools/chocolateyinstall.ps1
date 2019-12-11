$ErrorActionPreference = 'Stop'; # stop on all errors

$tempPath = [System.IO.Path]::GetFullPath("${Env:TEMP}\intelRedistributable")

$fileUrl    = "$tempPath\ww_icl_redist_msi\ww_icl_redist_ia32_2019.5.281.msi"
$fileUrl64  = "$tempPath\ww_icl_redist_msi\ww_icl_redist_intel64_2019.5.281.msi"
$checksum   = "9ec6f0594556eacdecc7f06bbe5471bd72c4d4a64d78731ad2a9e6faa360efe5"
$checksum64 = "96396b4225836a17e482abefbd0d575e56cb6329bd0302357aed4c97d04e17cd"

$url        = 'http://registrationcenter-download.intel.com/akdlm/irc_nas/tec/15799/ww_icl_redist_msi_2019.5.281.zip'

$archiveFile = "$tempPath\ww_icl_redist_msi_2019.5.281.zip"

if (-not (Test-Path -Path $archiveFile))
{
    Remove-Item -Path $tempPath -Recurse -ErrorAction SilentlyContinue
    New-Item -ItemType Directory -Path $tempPath | Out-Null
    Write-Verbose "Downloading '$url' to '$archiveFile.tmp'"
    (New-Object Net.WebClient).DownloadFile($url, "$archiveFile.tmp")
    Write-Verbose "Renaming '$archiveFile.tmp' to '$archiveFile'"
    Rename-Item -Path "$archiveFile.tmp" -NewName (Split-Path -Leaf -Path $archiveFile)
}
$extractionDirectory = "$tempPath\ww_icl_redist_msi"

if ((-not (Test-Path -Path $fileUrl)) -AND (-not (Test-Path -Path $fileUrl64)))
{
  Add-Type -AssemblyName System.IO.Compression.FileSystem | Out-Null
  Write-Verbose "Extracting '$archiveFile' to '$extractionDirectory'"
  [System.IO.Compression.ZipFile]::ExtractToDirectory($archiveFile, $extractionDirectory)
}


Install-ChocolateyInstallPackage `
  -PackageName $env:ChocolateyPackageName `
  -FileType 'msi' `
  -SilentArgs '/quiet' `
  -File64 $fileUrl64 `
  -File $fileUrl `
  -Checksum64 $checksum `
  -Checksum $checksum `
  -ValidExitCodes @(0, 3010)