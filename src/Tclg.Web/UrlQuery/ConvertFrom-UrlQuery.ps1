function ConvertFrom-UrlQuery {
    <#
    .SYNOPSIS
        Parses the input URL query string(s) into dictionaries.

    .DESCRIPTION
    Long description

    .PARAMETER UrlQuery
    Parameter description

    .EXAMPLE
        PS> ConvertFrom-UrlQuery '?var1=1&var2=2+2%2f3&var1=3'

        Name                           Value
        ----                           -----
        var2                           2 2/3
        var1                           1,3

    .INPUTS
        string
            URL query string to parse.

    .OUTPUTS
        hashtable
            Hashtable representation of the input URL query string.
            If a key appears multiple times in the URL query string, then the corresponding values are consolidated into a single comma-delimited entry.
    #>
    [CmdletBinding(PositionalBinding=$false, SupportsShouldProcess)]
    [OutputType([hashtable])]
    param(
        # The URL query string(s) to parse. Each string is parsed separately and must individually be a _complete_ query string, e.g. "?var1=1&var2=2+2%2f3&var1=3".
        [Parameter(Mandatory, Position=0, ValueFromPipeline)]
        [string[]]
        [Alias('Query')]
        $UrlQuery
    )
    process {
        foreach ($queryString in $UrlQuery) {
            try {
                $customDict = [System.Web.HttpUtility]::ParseQueryString($queryString)
                $hashTable = @{}
                foreach ($key in $customDict.Keys) {
                    $hashTable[$key] = $customDict[$key]
                }
                $hashTable
            } catch {
                Write-Error $_
                continue
            }
        }
    }
}
