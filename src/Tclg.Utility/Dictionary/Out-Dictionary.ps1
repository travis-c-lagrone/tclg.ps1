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
        [ScriptBlock]
        $KeyScript,

        [Parameter(ParameterSetName='KeyProperty_ValueProperty', Mandatory, Position=1)]
        [Parameter(ParameterSetName='KeyScript_ValueProperty', Mandatory, Position=1)]
        [ValidateNotNullOrEmpty()]
        [string]
        $ValueProperty,

        [Parameter(ParameterSetName='KeyProperty_ValueScript', Mandatory, Position=1)]
        [Parameter(ParameterSetName='KeyScript_ValueScript', Mandatory, Position=1)]
        [ValidateNotNull()]
        [ScriptBlock]
        $ValueScript,

        [Parameter()]
        [ValidateRange('NonNegative')]
        [int]
        $Size,

        [Parameter(ValueFromPipeline)]
        [PSObject]
        $InputObject
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
                $dictionary[$InputObject.$KeyProperty] = $InputObject.$ValueProperty
                break
            }
            'KeyProperty_ValueScript' {
                $dictionary[$InputObject.$KeyProperty] = $ValueScript.Invoke($InputObject)
            }
            'KeyScript_ValueProperty' {
                $dictionary[$KeyScript.Invoke($InputObject)] = $InputObject.$ValueProperty
            }
            'KeyScript_ValueScript' {
                $dictionary[$KeyScript.Invoke($InputObject)] = $ValueScript.Invoke($InputObject)
            }
            default {
                $dictionary[$InputObject.Key] = $InputObject.Value
            }
        }
    }
    end {
        $dictionary
    }
}

Set-Alias -Name 'odict' -Value 'Out-Dictionary' -ErrorAction SilentlyContinue
