$sources = @(
    'Alias/Rename-Alias.ps1'
    'Alias/Test-Alias.ps1'

    'ArgumentList/ConvertTo-ArgumentList.ps1'
    'ArgumentList/New-ArgumentList.ps1'

    'Dictionary/New-Dictionary.ps1'
    'Dictionary/Out-Dictionary.ps1'

    'Function/Export-Function.ps1'
    'Function/Get-Function.ps1'
    'Function/Import-Function.ps1'
    'Function/New-Function.ps1'
    'Function/Remove-Function.ps1'
    'Function/Rename-Function.ps1'
    'Function/Set-Function.ps1'
    'Function/Test-Function.ps1'

    'List/New-List.ps1'
    'List/Out-List.ps1'

    'Noun/Get-Noun.ps1'
    'Noun/NounInfo.ps1'

    'RegexOptions/New-RegexOptions.ps1'

    'Set/New-Set.ps1'
    'Set/Out-Set.ps1'

    'Variable/Rename-Variable.ps1'
    'Variable/Test-Variable.ps1'
    'Variable/Use-Variable.ps1'
)

foreach ($path in $sources) {
    . (Join-Path $PSScriptRoot $path)
}
