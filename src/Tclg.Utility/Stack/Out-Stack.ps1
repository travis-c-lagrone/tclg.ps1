function Out-Stack {
    [CmdletBinding(PositionalBinding=$false)]
    [OutputType([System.Collections.Generic.Stack[object]])]
    param(
        [Parameter()]
        [int]
        [ValidateRange('NonNegative')]
        $Size,

        [Parameter(ValueFromPipeline)]
        [object]
        $InputObject
    )
    begin {
        $stack =
            if ($PSBoundParameters.ContainsKey('Size')) {
                , [System.Collections.Generic.Stack[object]]::new($Size)
            } else {
                , [System.Collections.Generic.Stack[object]]::new()
            }
    }
    process {
        [void] $stack.Add($InputObject)
    }
    end {
        , $stack
    }
}

Set-Alias -Name 'ostack' -Value 'Out-Stack' -ErrorAction SilentlyContinue
