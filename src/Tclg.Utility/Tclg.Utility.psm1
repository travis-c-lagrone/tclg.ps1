$sources = @(
    'Noun/Get-Noun.ps1'
    'Variable/Rename-Variable.ps1'
    'Variable/Test-Variable.ps1'
)

foreach ($path in $sources) {
    . (Join-Path $PSScriptRoot $path)
}
