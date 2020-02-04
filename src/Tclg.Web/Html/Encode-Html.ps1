function Encode-Html {
    <#
    .SYNOPSIS
        HTML-encodes the input string(s).

    .PARAMETER Value
        The string(s) to HTML-encode.

    .INPUTS
        string
            The string(s) to HTML-encode.

    .OUTPUTS
        string
            The HTML-encoding of the input string(s).
    #>
    [CmdletBinding(PositionalBinding=$false, SupportsShouldProcess)]
    [OutputType([string])]
    param(
        # The string(s) to HTML-encode.
        [Parameter(Mandatory, Position=0, ValueFromPipeline)]
        [ValidateNotNull()]
        [string[]]
        $Value
    )
    process {
        foreach ($rawString in $Value) {
            try {
                [System.Web.HttpUtility]::HtmlEncode($rawString)
            } catch {
                Write-Error -Exception $_
                continue
            }
        }
    }
}
