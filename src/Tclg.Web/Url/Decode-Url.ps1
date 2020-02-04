function Decode-Url {
    <#
    .SYNOPSIS
        Decodes the input encoded URL(s).

    .PARAMETER Url
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
        [ValidateNotNull()]
        [string[]]
        $Url
    )
    process {
        foreach ($encodedString in $Url) {
            try {
                [System.Web.HttpUtility]::UrlDecode($encodedString)
            } catch {
                Write-Error -Exception $_
                continue
            }
        }
    }
}
