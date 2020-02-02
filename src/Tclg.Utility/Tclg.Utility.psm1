$sources = @(
    'Noun/Get-Noun.ps1'
)

foreach ($path in $sources) {
    . (Join-Path $PSScriptRoot $path)
}
