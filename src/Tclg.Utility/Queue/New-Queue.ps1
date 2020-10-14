function New-Queue {
    [CmdletBinding(PositionalBinding=$false, DefaultParameterSetName='empty')]
    [OutputType([System.Collections.Generic.Queue[object]])]
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
        , [System.Collections.Generic.Queue[object]]::new($Collection)
    }
    elseif ($PSBoundParameters.ContainsKey('Size')) {
        , [System.Collections.Generic.Queue[object]]::new($Size)
    }
    else {
        , [System.Collections.Generic.Queue[object]]::new()
    }
}

Set-Alias -Name 'nqueue' -Value 'New-Queue' -ErrorAction SilentlyContinue
