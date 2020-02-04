function Set-Function ([string] $Name, [scriptblock] $Value, [System.Management.Automation.ScopedItemOptions[]] $Options, [switch] $Force) {
    $splat = @{}
    if ($Value) {
        $splat['Value'] = $Value
    }
    if ($Options) {
        $splat['Options'] = $Options
    }
    Set-Item @splat -LiteralPath "Function:\${Name}" -Force:$Force -PassThru
}

Set-Alias -Name 'sf' -Value 'Set-Function'
