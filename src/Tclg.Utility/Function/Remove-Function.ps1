filter Remove-Function ([string[]] $Name, [switch] $Force) {
    ($Name ?? $Input) | ForEach-Object { "Function:\$_" } | Remove-Item -Force:$Force
}

Set-Alias -Name 'rf' -Value 'Remove-Function'
