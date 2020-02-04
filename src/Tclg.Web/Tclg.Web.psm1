$sources = @(
    'Html/Decode-Html.ps1'
    'Html/Encode-Html.ps1'
)

foreach ($path in $sources) {
    . (Join-Path $PSScriptRoot $path)
}
