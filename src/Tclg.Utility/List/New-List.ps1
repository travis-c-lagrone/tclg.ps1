function New-List {
    [CmdletBinding(PositionalBinding=$false, DefaultParameterSetName='empty')]
    [OutputType([System.Collections.Generic.IList[object]])]
    param(
        [Parameter(ParameterSetName='Collection', Mandatory, Position=0)]
        [System.Collections.IEnumerable]
        $Collection,

        [Parameter(ParameterSetName='Size', Mandatory)]
        [ValidateRange('NonNegative')]
        [int]
        $Size
    )

    if ($PSBoundParameters.ContainsKey('Collection')) {
        [System.Collections.Generic.List[object]]::new($Collection)
    }
    elseif ($PSBoundParameters.ContainsKey('Size')) {
        [System.Collections.Generic.List[object]]::new($Size)
    }
    else {
        [System.Collections.Generic.List[object]]::new()
    }
}

Set-Alias -Name 'nlist' -Value 'New-List' -ErrorAction SilentlyContinue
