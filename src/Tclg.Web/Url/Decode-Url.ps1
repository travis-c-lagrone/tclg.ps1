function Decode-Url {
    <#
    .SYNOPSIS
        Decodes the input encoded URL(s).

    .PARAMETER Html
        The encoded URL(s) to decode.

    .INPUTS
        string
            The encoded URL(s) to decode.

    .OUTPUTS
        string
            The decoding of each input encoded URL(s).
    #>
    [CmdletBinding(PositionalBinding=$false, SupportsShouldProcess)]
    [OutputType([string])]
    param(
        # The encoded URL(s) to decode.
        [Parameter(Mandatory, Position=0, ValueFromPipeline)]
        [string[]]
        $Value
    )
    process {
        foreach ($string in $Value) {
            try {
                [System.Web.HttpUtility]::UrlDecode($string)
            } catch {
                Write-Error -Exception $_
                continue
            }
        }
    }
}
