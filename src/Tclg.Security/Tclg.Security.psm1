$sources = @(
    'SecureString/Compare-SecureString.ps1'
)

foreach ($path in $sources) {
    . (Join-Path $PSScriptRoot $path)
}
