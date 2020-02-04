filter Test-Alias ([string[]] $Name) {
    ($Name ?? $Input) | ForEach-Object { "Alias:\$_" } | Test-Path
}

Set-Alias -Name 'tal' -Value 'Test-Alias'
