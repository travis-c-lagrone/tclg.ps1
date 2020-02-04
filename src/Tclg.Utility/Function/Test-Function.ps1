filter Test-Function ([string[]] $Name, [switch] $IsValid) {
    $splat = @{}
    if ($IsValid) {
        $splat['IsValid'] = $true
    }
    ($Name ?? $Input) | ForEach-Object { "Function:\$_" } | Test-Path @splat
}

Set-Alias -Name 'tf' -Value 'Test-Function'
