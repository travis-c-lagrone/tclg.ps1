function New-Set {
    [CmdletBinding(PositionalBinding=$false, DefaultParameterSetName='empty')]
    [OutputType([System.Collections.Generic.ISet[object]])]
    param(
        [Parameter(ParameterSetName='Collection', Mandatory, Position=0)]
        [System.Collections.IEnumerable]
        [ValidateNotNull()]
        $Collection,

        [Parameter(ParameterSetName='Size', Mandatory)]
        [int]
        [ValidateRange('NonNegative')]
        $Size
    )

    if ($PSBoundParameters.ContainsKey('Collection')) {
        , [System.Collections.Generic.HashSet[object]]::new($Collection)
    }
    elseif ($PSBoundParameters.ContainsKey('Size')) {
        , [System.Collections.Generic.HashSet[object]]::new($Size)
    }
    else {
        , [System.Collections.Generic.HashSet[object]]::new()
    }
}

Set-Alias -Name 'nset' -Value 'New-Set' -ErrorAction SilentlyContinue
