function New-Dictionary {
    [CmdletBinding(PositionalBinding=$false, DefaultParameterSetName='empty')]
    [OutputType([System.Collections.Generic.IDictionary[object, object]])]
    param(
        [Parameter(ParameterSetName='Dictionary', Mandatory, Position=0)]
        [System.Collections.IDictionary]
        [ValidateNotNull()]
        $Dictionary,

        [Parameter(ParameterSetName='Size', Mandatory)]
        [int]
        [ValidateRange('NonNegative')]
        $Size
    )

    if ($PSBoundParameters.ContainsKey('Dictionary')) {
        [System.Collections.Generic.Dictionary[object, object]]::new($Dictionary)
    }
    elseif ($PSBoundParameters.ContainsKey('Size')) {
        [System.Collections.Generic.Dictionary[object, object]]::new($Size)
    }
    else {
        [System.Collections.Generic.Dictionary[object, object]]::new()
    }
}

Set-Alias -Name 'ndict' -Value 'New-Dictionary' -ErrorAction SilentlyContinue
