function Out-Dictionary {
    [CmdletBinding(PositionalBinding=$false)]
    [OutputType([System.Collections.Generic.IDictionary[object, object]])]
    param(
        [Parameter(Position=0)]
        [string]
        [ValidateNotNullOrEmpty()]
        $KeyProperty = 'Key',

        [Parameter(Position=1)]
        [string]
        [ValidateNotNullOrEmpty()]
        $ValueProperty = 'Value',

        [Parameter()]
        [int]
        [ValidateRange('NonNegative')]
        $Size,

        [Parameter(ValueFromPipeline)]
        [PSObject]
        $InputObject
    )
    begin {
        $dictionary =
            if ($PSBoundParameters.ContainsKey('Size')) {
                [System.Collections.Generic.Dictionary[object, object]]::new($Size)
            } else {
                [System.Collections.Generic.Dictionary[object, object]]::new()
            }
    }
    process {
        $dictionary[$_.$KeyProperty] = $_.$ValueProperty
    }
    end {
        $dictionary
    }
}

Set-Alias -Name 'odict' -Value 'Out-Dictionary' -ErrorAction SilentlyContinue
