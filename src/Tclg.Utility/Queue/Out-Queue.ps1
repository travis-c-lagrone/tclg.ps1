function Out-Queue {
    [CmdletBinding(PositionalBinding=$false)]
    [OutputType([System.Collections.Generic.Queue[object]])]
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
        $queue =
            if ($PSBoundParameters.ContainsKey('Size')) {
                , [System.Collections.Generic.Queue[object]]::new($Size)
            } else {
                , [System.Collections.Generic.Queue[object]]::new()
            }
    }
    process {
        [void] $queue.Add($InputObject)
    }
    end {
        , $queue
    }
}

Set-Alias -Name 'oqueue' -Value 'Out-Queue' -ErrorAction SilentlyContinue
