$sources = @(
)

foreach ($path in $sources) {
    . (Join-Path $PSScriptRoot $path)
}
