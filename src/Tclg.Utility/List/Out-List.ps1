function Out-List {
    [CmdletBinding(PositionalBinding=$false)]
    [OutputType([System.Collections.Generic.IList[object]])]
    param(
        [Parameter()]
        [ValidateRange('NonNegative')]
        [int]
        $Size
    )
    begin {
        $list =
            if ($PSBoundParameters.Contains('Size')) {
                [System.Collections.Generic.List[object]]::new($Size)
            } else {
                [System.Collections.Generic.List[object]]::new()
            }
    }
    process {
        $list.Add($_)
    }
    end {
        $list
    }
}

Set-Alias -Name 'olist' -Value 'Out-List' -ErrorAction SilentlyContinue
