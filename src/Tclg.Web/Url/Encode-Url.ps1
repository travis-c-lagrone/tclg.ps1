function Encode-Url {
    <#
    .SYNOPSIS
        URL-encodes the input string(s).

    .PARAMETER Value
        The string(s) to URL-encode.

    .INPUTS
        string
            The string(s) to URL-encode.

    .OUTPUTS
        string
            The URL-encoding of the input string(s).
    #>
    [CmdletBinding(PositionalBinding=$false, SupportsShouldProcess)]
    [OutputType([string])]
    param(
        # The string(s) to URL-encode.
        [Parameter(Mandatory, Position=0, ValueFromPipeline)]
        [string[]]
        $Value
    )
    process {
        foreach ($string in $Value) {
            try {
                [System.Web.HttpUtility]::UrlEncode($string)
            } catch {
                Write-Error -Exception $_
                continue
            }
        }
    }
}
