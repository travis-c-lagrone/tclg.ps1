function Out-Dictionary {
    [CmdletBinding(PositionalBinding=$false, DefaultParameterSetName='default')]
    [OutputType([System.Collections.Generic.IDictionary[object, object]])]
    param(
        [Parameter(ParameterSetName='KeyProperty_ValueProperty', Mandatory, Position=0)]
        [Parameter(ParameterSetName='KeyProperty_ValueScript', Mandatory, Position=0)]
        [ValidateNotNullOrEmpty()]
        [string]
        $KeyProperty,

        [Parameter(ParameterSetName='KeyScript_ValueProperty', Mandatory, Position=0)]
        [Parameter(ParameterSetName='KeyScript_ValueScript', Mandatory, Position=0)]
        [ValidateNotNull()]
        [scriptblock]
        $KeyScript,

        [Parameter(ParameterSetName='KeyProperty_ValueProperty', Mandatory, Position=1)]
        [Parameter(ParameterSetName='KeyScript_ValueProperty', Mandatory, Position=1)]
        [ValidateNotNullOrEmpty()]
        [string]
        $ValueProperty,

        [Parameter(ParameterSetName='KeyProperty_ValueScript', Mandatory, Position=1)]
        [Parameter(ParameterSetName='KeyScript_ValueScript', Mandatory, Position=1)]
        [ValidateNotNull()]
        [scriptblock]
        $ValueScript,

        [Parameter()]
        [ValidateRange('NonNegative')]
        [int]
        $Size
    )
    begin {
        $dictionary =
            if ($PSBoundParameters.Contains('Size')) {
                [System.Collections.Generic.Dictionary[object, object]]::new($Size)
            } else {
                [System.Collections.Generic.Dictionary[object, object]]::new()
            }
    }
    process {
        switch ($PSCmdlet.ParameterSetName) {
            'KeyProperty_ValueProperty' {
                $dictionary[$_.$KeyProperty] = $_.$ValueProperty
                break
            }
            'KeyProperty_ValueScript' {
                $dictionary[$_.$KeyProperty] = $ValueScript.Invoke($_)
            }
            'KeyScript_ValueProperty' {
                $dictionary[$KeyScript.Invoke($_)] = $_.$ValueProperty
            }
            'KeyScript_ValueScript' {
                $dictionary[$KeyScript.Invoke($_)] = $ValueScript.Invoke($_)
            }
            default {
                $dictionary[$_.Key] = $_.Value
            }
        }
    }
    end {
        $dictionary
    }
}

Set-Alias -Name 'odict' -Value 'Out-Dictionary' -ErrorAction SilentlyContinue
