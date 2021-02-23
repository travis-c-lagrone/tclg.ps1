using namespace System.Collections.Generic
using namespace System.Management.Automation
using namespace System.Management.Automation.Language

function Set-EnvVariable {
    [Alias('sev')]
    [CmdletBinding(PositionalBinding=$false, SupportsShouldProcess)]
    [OutputType([void])]
    param(
        [Parameter(Mandatory, Position=0, ValueFromPipeline)]
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

        [Parameter(Mandatory, Position=1)]
        [AllowNull()]
        [AllowEmptyString()]
        [string]
        $Value,

        [Parameter()]
        [Alias('EnvironmentVariableTarget')]
        [ValidateNotNull()]
        [ValidateEnvironmentVariableTarget()]
        [EnvironmentVariableTarget]
        $Target = [EnvironmentVariableTarget]::Process
    )
    begin {
        if (-not $Value) {
            Write-Warning "The -Value argument is falsy, which will cause Env:$Name to be removed entirely."
        }
        $shouldProcessTargetName = $Target.ToString().ToLower()
    }
    process {
        $processedLiteralNames = [HashSet[string]]::new($script:EnvNameComparer)
        $envVars = $null
        foreach ($name_ in $Name) {
            $literalNames =
                if ([WildcardPattern]::ContainsWildcardCharacters($name_)) {
                    $pattern = [WildcardPattern]::Get($name_, $script:EnvNameWildcardOptions)
                    $envVars = [Environment]::GetEnvironmentVariables($Target)
                    foreach ($literalName in $envVars.Keys) {
                        if ($pattern.IsMatch($literalName)) {
                            $literalName
                        }
                    }
                }
                else {
                    $name_
                }
            foreach ($literalName in $literalNames) {
                if ($processedLiteralNames.Add($literalName)) {
                    $shouldProcessLiteralName = [CodeGeneration]::EscapeSingleQuotedStringContent($literalName)
                    if ($PSCmdlet.ShouldProcess(
                        "Setting $shouldProcessTargetName environment variable '$shouldProcessLiteralName'",  # verboseDescription
                        "Set $shouldProcessTargetName environment variable '$shouldProcessLiteralName'?",  # verboseWarning
                        "Set environment variable"  # caption
                    )) {
                        try {
                            [Environment]::SetEnvironmentVariable($literalName, $Value, $Target)
                        }
                        catch {
                            Write-Error -ErrorRecord $_
                        }
                    }
                }
            }
        }
    }
}
