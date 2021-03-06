using namespace System.Collections

function New-DictionaryEntry {
    [Alias('New-Entry')]
    [CmdletBinding(PositionalBinding = $false, DefaultParameterSetName = 'ValueFromArguments')]
    [OutputType([DictionaryEntry])]
    param(
        [Parameter(ParameterSetName = 'ValueFromArguments', Mandatory, Position = 0)]
        [Parameter(ParameterSetName = 'ValueFromPipelineByPropertyName', Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('Name')]
        [ValidateNotNull()]
        [AllowEmptyCollection()]
        [AllowEmptyString()]
        $Key,

        [Parameter(ParameterSetName = 'ValueFromArguments', Mandatory, Position = 1)]
        [Parameter(ParameterSetName = 'ValueFromPipelineByPropertyName', Mandatory, ValueFromPipelineByPropertyName)]
        [AllowNull()]
        [AllowEmptyCollection()]
        [AllowEmptyString()]
        $Value,

        [Parameter(ParameterSetName = 'ValueFromPipeline', Mandatory, ValueFromPipeline)]
        $InputObject
    )
    process {
        if ($PSBoundParameters.ContainsKey('InputObject')) {
            $entry = $null
            $entry = $InputObject -as [DictionaryEntry]
            if ($entry) {
                return $entry
            }

            $dict = $null
            $dict = $InputObject -as [Hashtable]
            if ($null -ne $dict) {

                if ($dict.Count -eq 1) {
                    return ($dict.GetEnumerator())
                }

                if (('Key' -in $dict.Keys -or $Name -in $dict.Keys) -and 'Value' -in $dict.Keys) {
                    return [DictionaryEntry]::new($dict.Key ?? $dict.Name, $dict.Value)
                }

                Write-Error -Exception ([ArgumentException]::new("Dictionary-like input object does not contain Key and Value keys: $InputObject"))
                return
            }

            Write-Error -Exception ([NotSupportedException]::new("Converting to DictionaryEntry from input objet type is unsupported: $($InputObject.GetType())"))
            return
        }

        [DictionaryEntry]::new($Key, $Value)
    }
}
