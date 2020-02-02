filter Test-Variable ([string[]] $Name) {
    ($Name ?? $Input) | ForEach-Object { "Variable:\$_" } | Test-Path
}

Set-Alias -Name 'tv' -Value 'Test-Variable'
