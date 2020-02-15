function Select-RegexOptions {
    [CmdletBinding(PositionalBinding=$false)]
    param(
        [Parameter()]
        [SupportsWildcards()]
        [ArgumentCompleter({
            param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
            [System.Text.RegularExpressions.RegexOptions].GetEnumNames() -like "${wordToComplete}*" | ForEach-Object {
                [System.Management.Automation.CompletionResult]::new($_)
            }
        })]
        [string[]]
        $Include,

        [Parameter()]
        [SupportsWildcards()]
        [ArgumentCompleter({
            param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
            [System.Text.RegularExpressions.RegexOptions].GetEnumNames() -like "${wordToComplete}*" | ForEach-Object {
                [System.Management.Automation.CompletionResult]::new($_)
            }
        })]
        [string[]]
        $Exclude,

        [Parameter(Mandatory, Position=0, ValueFromPipeline)]
        [PSObject]
        $InputObject
    )
    begin {
        $RegexOptionsNames = [System.Text.RegularExpressions.RegexOptions].GetEnumNames()
        $WildcardOptions = [System.Management.Automation.WildcardOptions]::IgnoreCase

        $includeMask = $null
        $Include = $Include.ForEach{ $_.Trim() }.Where{ $_ }
        if ($Include) {
            $wildcardPatterns = $Include.ForEach{ [System.Management.Automation.WildcardPattern]::new($_, $WildcardOptions) }

            $notIncludedNames = [System.Collections.Generic.HashSet[string]]::new($RegexOptionsNames)
            $includedNames = [System.Collections.Generic.HashSet[string]]::new($RegexOptionsNames.Count)
            foreach ($wildcardPattern in $wildcardPatterns) {
                foreach ($name in @($notIncludedNames)) {
                    if ($wildcardPattern.IsMatch($name)) {
                        $notIncludedNames.Remove($name) > $null
                        $includedNames.Add($name) > $null
                    }
                }
                if ($notIncludedNames.Count -eq 0) {
                    break
                }
            }

            $includeMask = [System.Text.RegularExpressions.RegexOptions]::None
            foreach ($name in $includedNames) {
                $includeMask = $includeMask -bor [System.Text.RegularExpressions.RegexOptions]::$name
            }
        }

        $excludeMask = $null
        $Exclude = $Exclude.ForEach{ $_.Trim() }.Where{ $_ }
        if ($Exclude) {
            $wildcardPatterns = $Exclude.ForEach{ [System.Management.Automation.WildcardPattern]::new($_, $WildcardOptions) }

            $notExcludedNames = [System.Collections.Generic.HashSet[string]]::new($RegexOptionsNames)
            $excludedNames = [System.Collections.Generic.HashSet[string]]::new($RegexOptionsNames.Count)
            foreach ($wildcardPattern in $wildcardPatterns) {
                foreach ($name in @($notExcludedNames)) {
                    if ($wildcardPattern.IsMatch($name)) {
                        $notExcludedNames.Remove($name) > $null
                        $excludedNames.Add($name) > $null
                    }
                }
                if ($notExcludedNames.Count -eq 0) {
                    break
                }
            }

            $excludeMask = [System.Text.RegularExpressions.RegexOptions]::None
            foreach ($name in $excludedNames) {
                $excludeMask = $excludeMask -bor [System.Text.RegularExpressions.RegexOptions]::$name
            }
        }
    }
    process {
        try {
            $regexOptions = [System.Text.RegularExpressions.RegexOptions] $InputObject
        } catch {
            Write-Error -ErrorRecord $_
            return
        }

        if ($includeMask -ne $null) {
            $regexOptions = $regexOptions -band $includeMask
        }
        if ($excludeMask -ne $null) {
            $regexOptions = $regexOptions -band -bnot $excludeMask
        }
        $regexOptions
    }
}
