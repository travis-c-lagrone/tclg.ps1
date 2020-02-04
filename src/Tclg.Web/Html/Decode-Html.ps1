function Decode-Html {
    <#
    .SYNOPSIS
        HTML-decodes the input HTML string(s).

    .PARAMETER Html
        The HTML string(s) to HTML-decode.

    .INPUTS
        string
            The HTML string(s) to HTML-decode.

    .OUTPUTS
        string
            The HTML-decoding of the input HTML string(s).
    #>
    [CmdletBinding(PositionalBinding=$false, SupportsShouldProcess)]
    [OutputType([string])]
    param(
        # The HTML string(s) to HTML-decode.
        [Parameter(Mandatory, Position=0, ValueFromPipeline)]
        [string[]]
        $Value
    )
    process {
        foreach ($string in $Value) {
            try {
                [System.Web.HttpUtility]::HtmlDecode($string)
            } catch {
                Write-Error -Exception $_
                continue
            }
        }
    }
}
