function New-Function ([string] $Name, [scriptblock] $Value, [System.Management.Automation.ScopedItemOptions[]] $Options, [switch] $Force) {
    $splat = @{}
    if ($Value) {
        $splat['Value'] = $Value
    }
    if ($Options) {
        $splat['Options'] = $Options
    }
    New-Item @splat -LiteralPath 'Function:\' -Name $Name -Force:$Force
}

Set-Alias -Name 'nf' -Value 'New-Function'
