$sources = @(
    'Alias/Rename-Alias.ps1'
    'Alias/Test-Alias.ps1'

    'Function/Export-Function.ps1'
    'Function/Get-Function.ps1'
    'Function/Import-Function.ps1'
    'Function/New-Function.ps1'
    'Function/Remove-Function.ps1'
    'Function/Rename-Function.ps1'
    'Function/Set-Function.ps1'
    'Function/Test-Function.ps1'

    'Noun/Get-Noun.ps1'
    'Noun/NounInfo.ps1'

    'RegexOptions/New-RegexOptions.ps1'

    'Variable/Rename-Variable.ps1'
    'Variable/Test-Variable.ps1'
)

foreach ($path in $sources) {
    . (Join-Path $PSScriptRoot $path)
}
