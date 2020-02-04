$sources = @(
    'Html/Decode-Html.ps1'
    'Html/Encode-Html.ps1'

    'Url/Decode-Url.ps1'
    'Url/Encode-Url.ps1'

    'UrlQuery/ConvertFrom-UrlQuery.ps1'
)

foreach ($path in $sources) {
    . (Join-Path $PSScriptRoot $path)
}
