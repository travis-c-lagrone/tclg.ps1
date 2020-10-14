function Get-EnvVariable {
    [CmdletBinding(PositionalBinding=$false, DefaultParameterSetName='NoName')]
    [OutputType([hashtable], ParameterSetName='NoName')]
    [OutputType([string], ParameterSetName='Name')]
    param(
        [Parameter(ParameterSetName='Name', Mandatory, Position=0, ValueFromPipeline)]
        [string]
        [ValidateNotNullOrEmpty()]
        [ArgumentCompleter({
            param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
            $names =
                if ('Target' -in $fakeBoundParameters.Keys) {
                    $target = $fakeBoundParameters['Target'] -as [System.EnvironmentVariableTarget]
                    if ($null -ne $target) {
                        [System.Environment]::GetEnvironmentVariables($target).Keys
                    } else {
                        [System.Environment]::GetEnvironmentVariables().Keys
                    }
                } else {
                    [System.Environment]::GetEnvironmentVariables().Keys
                }
            foreach ($name in $names) {
                if ($name -like "$wordToComplete*") {
                    [System.Management.Automation.CompletionResult]::new($name)
                }
            }
        })]
        $Name,

        [Parameter(ParameterSetName='Name')]
        [Parameter(ParameterSetName='NoName')]
        [System.EnvironmentVariableTarget]
        [ValidateNotNull()]
        [Alias('EnvironmentVariableTarget')]
        $Target = [System.EnvironmentVariableTarget]::Process
    )
    process {
        if ($Name) {
            [System.Environment]::GetEnvironmentVariable($Name, $Target)
        } else {
            [System.Environment]::GetEnvironmentVariables($Target)
        }
    }
}

Set-Alias -Name 'gev' -Value 'Get-EnvVariable'
