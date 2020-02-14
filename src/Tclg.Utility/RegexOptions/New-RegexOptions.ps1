function New-RegexOptions {
    param(
        [System.Text.RegularExpressions.RegexOptions]
        [ValidateNotNull()]
        $Value = [System.Text.RegularExpressions.RegexOptions]::None
    )
    $Value
}
