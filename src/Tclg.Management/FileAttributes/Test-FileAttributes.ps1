function Test-FileAttributes {
    [CmdletBinding(DefaultParameterSetName='Normal', PositionalBinding=$false, SupportsShouldProcess)]
    [OutputType([bool])]
    param(
        [Parameter(Mandatory, Position=0, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [System.IO.FileAttributes]
        [Alias('FileAttributes', 'InputObject')]
        $Attributes,

        [Parameter(ParameterSetName='All', Mandatory)]
        [AllowEmptyCollection()]
        [System.IO.FileAttributes[]]
        $All,

        [Parameter(ParameterSetName='Any', Mandatory)]
        [AllowEmptyCollection()]
        [System.IO.FileAttributes[]]
        $Any,

        [Parameter(ParameterSetName='None', Mandatory)]
        [AllowEmptyCollection()]
        [System.IO.FileAttributes[]]
        $None
    )
    begin {
        $EnumValues = [System.IO.FileAttributes].GetEnumValues()

        function Merge-FileAttributes {
            $merged = [System.IO.FileAttributes] 0
            foreach ($fileAttributes in $Input) {
                $merged = $merged -bor $fileAttributes
            }
            $merged
        }

        filter Split-FileAttributes {
            $split = [System.Collections.Generic.List[System.IO.FileAttributes]]::new($EnumValues.Count)
            foreach ($enumValue in $EnumValues) {
                if ($enumValue -band $_) {
                    $split.Add($enumValue)
                }
            }
            $split
        }

        function Measure-All {
            [bool] $all = $true
            foreach ($proposition in $Input) {
                $all = $all -and $proposition
                if (-not $all) {
                    return $false
                }
            }
            return $true
        }

        function Measure-Any {
            [bool] $any = $false
            foreach ($proposition in $Input) {
                $any = $any -or $proposition
                if ($any) {
                    return $true
                }
            }
            return $false
        }

        function Measure-None {
            [bool] $none = $true
            foreach ($proposition in $Input) {
                $none = $none -and -not $proposition
                if (-not $none) {
                    return $false
                }
            }
            return $true
        }

        $test = switch ($PSCmdlet.ParameterSetName) {
            'All' {
                $partition = $All | Merge-FileAttributes | Split-FileAttributes
                { param($Attributes) $partition | ForEach-Object { $_ -band $Attributes } | Measure-All }
            }
            'Any' {
                $union = $Any | Merge-FileAttributes
                { param($Attributes) $union | ForEach-Object { $_ -band $Attributes } | Measure-Any }
            }
            'None' {
                $union = $None | Merge-FileAttributes
                { param($Attributes) $union | ForEach-Object { $_ -band $Attributes } | Measure-None }

            }
            default {
                { param($Attributes) [System.IO.FileAttributes]::Normal -eq $Attributes }
            }
        }
    }
    process {
        & $test $Attributes
    }
}
