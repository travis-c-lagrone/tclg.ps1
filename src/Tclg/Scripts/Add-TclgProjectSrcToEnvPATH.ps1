#Requires -Version 7.1
using namespace System.IO
using namespace System.Management.Automation

$srcPath = $PSScriptRoot
while ($srcPath -and (Split-Path $srcPath -Leaf) -ne 'src') {
    $srcPath = Split-Path $srcPath
}
if (-not $srcPath) {
    $exception = [DirectoryNotFoundException]::new('powershell-tclg/src')
    $id = 'PowerShellTclgProjectSrcDirectoryNotFound'
    $category = [ErrorCategory]::ObjectNotFound
    $target = $PSScriptRoot
    $record = [ErrorRecord]::new($exception, $id, $category, $target)
    $PSCmdlet.ThrowTerminatingError($record)
}

$Env:PSModulePath = @($Env:PSModulePath, $srcPath) -join ([Path]::PathSeparator)
