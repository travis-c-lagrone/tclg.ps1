using namespace System.Collections.Specialized
using namespace System.Management.Automation

function Get-EnvVariable {
    [Alias('env')]
    [CmdletBinding(PositionalBinding=$false, DefaultParameterSetName='All')]
    [OutputType([OrderedDictionary], ParameterSetName='All')]
    [OutputType([string], [OrderedDictionary], ParameterSetName='ByName')]  # which type depends on -AsDictionary switch parameter
    param(
        [Parameter(ParameterSetName='ByName', Mandatory, Position=0, ValueFromPipeline)]
        [SupportsWildcards()]
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
            $pattern = [WildcardPattern]::new("$wordToComplete*", $IsWindows ? [WildcardOptions]::IgnoreCase : [WildcardOptions]::None)
            foreach ($name in $names) {
                if ($pattern.IsMatch($name)) {
                    [CompletionResult]::new($name)
                }
            }
        })]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $Name,

        [Parameter(ParameterSetName='All')]
        [Parameter(ParameterSetName='ByName')]
        [Alias('EnvironmentVariableTarget')]
        [ValidateNotNull()]
        [ValidateScript({ $IsWindows -or $_ -eq [EnvironmentVariableTarget]::Process },
                        ErrorMessage='The environment variable target ''{0}'' is supported only on Windows.')]
        [EnvironmentVariableTarget]
        $Target = [EnvironmentVariableTarget]::Process,

        [Parameter(ParameterSetName='ByName')]
        [switch]
        $AsDictionary
    )
    begin {
        $Options = $IsWindows ? [WildcardOptions]::IgnoreCase : [WildcardOptions]::None
        $dictionary = if ($AsDictionary) {
            $nameComparer = $IsWindows ? [StringComparer]::CurrentCultureIgnoreCase : [StringComparer]::CurrentCulture
            if ($Name.Count) {
                [OrderedDictionary]::new($Name.Count, $nameComparer)
            } else {
                [OrderedDictionary]::new($nameComparer)
            }
        }
    }
    process {
        $envVars = $null
        foreach ($name_ in $Name) {
            if ([WildcardPattern]::ContainsWildcardCharacters($name_)) {
                $pattern = [WildcardPattern]::Get($name_, $Options)
                $envVars ??= [Environment]::GetEnvironmentVariables($Target)
                foreach ($literalName in $envVars.Keys) {
                    if ($pattern.IsMatch($literalName)) {
                        if ($AsDictionary -and -not $dictionary.Contains($literalName)) {
                            $dictionary.Add($literalName, $envVars[$literalName])
                        }
                        else {
                            $envVars[$literalName]
                        }
                    }
                }
            }
            else {
                if ($AsDictionary -and -not $dictionary.Contains($name_)) {
                    $dictionary.Add($name_, [Environment]::GetEnvironmentVariable($name_, $Target))
                }
                else {
                    [Environment]::GetEnvironmentVariable($name_, $Target)
                }
            }
        }
    }
    end {
        if ($AsDictionary) {
            $dictionary
        }
        elseif ($PSCmdlet.ParameterSetName -eq 'All') {
            $envVars = [Environment]::GetEnvironmentVariables($Target)
            $dictionary = [OrderedDictionary]::new($envVars.Count)
            foreach ($literalName in ($envVars.Keys | Sort-Object)) {
                $dictionary.Add($literalName, $envVars[$literalName])
            }
            $dictionary
        }
    }
}
