function Get-EnvPath {
    [CmdletBinding(PositionalBinding=$false, DefaultParameterSetName='Split')]
    [OutputType([string[]], ParameterSetName='Split')]
    [OutputType([string], ParameterSetName='Raw')]
    param(
        [Parameter(ParameterSetName='Split', Position=0)]
        [Parameter(ParameterSetName='Raw', Position=0)]
        [System.EnvironmentVariableTarget]
        [ValidateNotNull()]
        [Alias('EnvironmentVariableTarget')]
        $Target = [System.EnvironmentVariableTarget]::Process,

        [Parameter(ParameterSetName='Raw', Mandatory)]
        [switch]
        $Raw
    )

    $envPath = [System.Environment]::GetEnvironmentVariable('Path', $Target)
    if ($Raw) {
        return $envPath
    }

    ($envPath -split ([System.IO.Path]::PathSeparator)).ForEach{ $_.Trim() }.Where{ $_ }
}

Set-Alias -Name 'gep' -Value 'Get-EnvPath'
