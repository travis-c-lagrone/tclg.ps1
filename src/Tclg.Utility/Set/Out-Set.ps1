function Out-Set {
    [CmdletBinding(PositionalBinding=$false)]
    [OutputType([System.Collections.Generic.ISet[object]])]
    param(
        [Parameter()]
        [ValidateRange('NonNegative')]
        [int]
        $Size
    )
    begin {
        $set =
            if ($PSBoundParameters.Contains('Size')) {
                [System.Collections.Generic.HashSet[object]]::new($Size)
            } else {
                [System.Collections.Generic.HashSet[object]]::new()
            }
    }
    process {
        $set.Add($_)
    }
    end {
        $set
    }
}

Set-Alias -Name 'oset' -Value 'Out-Set' -ErrorAction SilentlyContinue
