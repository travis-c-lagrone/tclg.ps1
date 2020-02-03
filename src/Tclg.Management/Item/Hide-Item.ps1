function Hide-Item {
    [CmdletBinding(DefaultParameterSetName='LiteralPath', PositionalBinding=$false, SupportsShouldProcess)]
    param(
        # The path of the item(s) to hide. Supports wildcards.
        [Parameter(ParameterSetName='Path', Mandatory, Position=0, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [SupportsWildcards()]
        [string[]]
        [ValidateScript({ Test-Path -Path $_ -IsValid })]
        $Path,

        # The literal path of the item(s) to hide.
        [Parameter(ParameterSetName='LiteralPath', Mandatory, ValueFromPipelineByPropertyName)]
        [string[]]
        [ValidateScript({ Test-Path -LiteralPath $_ -IsValid })]
        [Alias('PSPath')]
        $LiteralPath,

        [Parameter()]
        [SupportsWildcards()]
        [string]
        [ValidateScript({ Test-Path $_ -IsValid })]
        $Filter,

        [Parameter()]
        [SupportsWildcards()]
        [string[]]
        [ValidateScript({ Test-Path $_ -IsValid })]
        $Include,

        [Parameter()]
        [SupportsWildcards()]
        [string[]]
        [ValidateScript({ Test-Path $_ -IsValid })]
        $Exclude,

        [Parameter(ValueFromPipelineByPropertyName)]
        [PSCredential]
        [Alias('PSCredential')]
        $Credential,

        # Specifies that each item is accessed by force (as if by `Get-Item -Force`), and that erroneously processed items are still passed thru (if `-PassThru` is specified).
        [Parameter()]
        [switch]
        $Force,

        # Specifies that each item (not just path) is output to the pipeline after being hidden.
        [Parameter()]
        [switch]
        $PassThru
    )
    process {
        $splat = @{}
        foreach ($key in @('Path', 'LiteralPath', 'Filter', 'Include', 'Exclude', 'Credential', 'Force')) {
            if ($MyInvocation.BoundParameters.Contains($key)) {
                $splat[$key] = $MyInvocation.BoundParameters[$key]
            }
        }

        $items = Get-Item @splat
        foreach ($item in $items) {
            try {
                if ($item.Attributes -band [System.IO.FileAttributes]::Hidden) {
                    Write-Warning "$item is already hidden."
                }
                $item.Attributes = $item.Attributes -bor [System.IO.FileAttributes]::Hidden
                if ($PassThru) {
                    $item
                }
            }
            catch {
                Write-Error -Exception $_
                if ($PassThru -and $Force) {
                    $item
                }
                continue
            }
        }
    }
}

Set-Alias -Name 'hide' -Value 'Hide-Item'
