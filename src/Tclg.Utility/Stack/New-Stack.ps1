function New-Stack {
    [CmdletBinding(PositionalBinding=$false, DefaultParameterSetName='empty')]
    [OutputType([System.Collections.Generic.Stack[object]])]
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
        , [System.Collections.Generic.Stack[object]]::new($Collection)
    }
    elseif ($PSBoundParameters.ContainsKey('Size')) {
        , [System.Collections.Generic.Stack[object]]::new($Size)
    }
    else {
        , [System.Collections.Generic.Stack[object]]::new()
    }
}

Set-Alias -Name 'nstack' -Value 'New-Stack' -ErrorAction SilentlyContinue
