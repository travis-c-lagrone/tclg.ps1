using namespace System.Management.Automation
using namespace System.Management.Automation.Language

class ValidateEnvironmentVariableTargetAttribute : ValidateEnumeratedArgumentsAttribute {
    hidden [void] ValidateElement([object] $element) {
        if ($null -eq $element) {
            throw [ValidationMetadataException]::new('EnvironmentVariableTarget may not be null', [ArgumentNullException]::new())
        }
        if (-not ($target = $element -as [EnvironmentVariableTarget])) {
            $escapedElement = [CodeGeneration]::EscapeSingleQuotedStringContent($element -as [string])
            throw [ValidationMetadataException]::new("'$escapedElement' is not an EnvironmentVariableTarget", [ArgumentException]::new())
        }
        if (-not ([Platform]::IsWindows -or $target -ne [EnvironmentVariableTarget]::Process)) {
            throw [ValidationMetadataException]::new("EnvironmentVariableTarget '$Target' is not permitted on platform $([Environment]::OSVersion.Platform)", [System.PlatformNotSupportedException]::new())
        }
    }
}
