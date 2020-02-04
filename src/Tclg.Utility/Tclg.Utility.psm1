$sources = @(
    'Alias/Rename-Alias.ps1'
    'Alias/Test-Alias.ps1'
    'Noun/Get-Noun.ps1'
    'Variable/Rename-Variable.ps1'
    'Variable/Test-Variable.ps1'
)

foreach ($path in $sources) {
    . (Join-Path $PSScriptRoot $path)
}
