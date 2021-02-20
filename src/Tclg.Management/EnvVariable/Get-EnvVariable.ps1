function Get-EnvVariable {
    [CmdletBinding(PositionalBinding=$false, DefaultParameterSetName='NoName')]
    [OutputType([Collections.Specialized.OrderedDictionary], ParameterSetName='NoName')]
    [OutputType([string], [Collections.Specialized.OrderedDictionary], ParameterSetName='Name')]  # which type depends on -AsDictionary switch parameter
    param(
        [Parameter(ParameterSetName='Name', Mandatory, Position=0, ValueFromPipeline)]
        [string]
        [ValidateNotNullOrEmpty()]
        [ArgumentCompleter({
            param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
            $names =
                if ('Target' -in $fakeBoundParameters.Keys) {
                    $target = $fakeBoundParameters['Target'] -as [EnvironmentVariableTarget]
                    if ($null -ne $target) {
                        [Environment]::GetEnvironmentVariables($target).Keys
                    } else {
                        [Environment]::GetEnvironmentVariables().Keys
                    }
                } else {
                    [Environment]::GetEnvironmentVariables().Keys
                }
            foreach ($name in $names) {
                if ($name -like "$wordToComplete*") {
                    [Management.Automation.CompletionResult]::new($name)
                }
            }
        })]
        $Name,

        [Parameter(ParameterSetName='Name')]
        [Parameter(ParameterSetName='NoName')]
        [EnvironmentVariableTarget]
        [ValidateNotNull()]
        [Alias('EnvironmentVariableTarget')]
        $Target = [EnvironmentVariableTarget]::Process,

        [Parameter(ParameterSetName='Name')]
        [switch]
        $AsDictionary
    )
    process {
        if ($Name) {
            if ($AsDictionary) {
                $ordered = [Collections.Specialized.OrderedDictionary]::new($Name.Count)
                foreach ($name_ in $Name) {
                    $ordered[$name_] = [Environment]::GetEnvironmentVariable($name_, $Target)
                }
                $ordered
            }
            else {
                foreach ($name_ in $Name) {
                    [Environment]::GetEnvironmentVariable($name_, $Target)
                }
            }
        }
        else {
            $hashtable = [Environment]::GetEnvironmentVariables($Target)
            $ordered = [Collections.Specialized.OrderedDictionary]::new($hashtable.Count)
            foreach ($entry in $hashtable.GetEnumerator()) {
                $ordered[$entry.Key] = $entry.Value
            }
            $ordered
        }
    }
}

Set-Alias -Name 'gev' -Value 'Get-EnvVariable'
