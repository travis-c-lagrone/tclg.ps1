$sources = @(
    './EnvPath/Get-EnvPath.ps1'

    './EnvVariable/EnvNameComparer.ps1'
    './EnvVariable/EnvNameWildcardOptions.ps1'
    './EnvVariable/Get-EnvVariable.ps1'
    './EnvVariable/Set-EnvVariable.ps1'

    './FileAttributes/Merge-FileAttributes.ps1'
    './FileAttributes/New-FileAttributes.ps1'
    './FileAttributes/Split-FileAttributes.ps1'
    './FileAttributes/Test-FileAttributes.ps1'

    './Item/Hide-Item.ps1'
    './Item/Lock-Item.ps1'
    './Item/Protect-Item.ps1'
    './Item/Show-Item.ps1'
    './Item/Unlock-Item.ps1'
    './Item/Unprotect-Item.ps1'
)

foreach ($path in $sources) {
    . (Join-Path $PSScriptRoot $path)
}
