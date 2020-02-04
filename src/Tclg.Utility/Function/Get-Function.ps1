filter Get-Function ([string[]] $Name, [switch] $Force) {
    ($Name ?? $Input) | ForEach-Object { "Function:\$_" } | Get-Item -Force:$Force
}

Set-Alias -Name 'gf' -Value 'Get-Function'
