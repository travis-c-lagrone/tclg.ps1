$sources = @(
    'Item/Hide-Item.ps1'
)

foreach ($path in $sources) {
    . (Join-Path $PSScriptRoot $path)
}
