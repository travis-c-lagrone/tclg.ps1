@{
    RootModule = 'Tclg.Utility.psm1'
    ModuleVersion = '0.0.1'
    GUID = '376a69b5-06ba-467d-87ac-931892f53fcf'
    Author = 'Travis C. LaGrone'
    Copyright = @'
Copyright 2020 Travis C. LaGrone

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
'@
    Description = '#TODO'
    PowerShellVersion = '7.0.0'

    RequiredModules = @()
    RequiredAssemblies = @()

    ScriptsToProcess = @()
    TypesToProcess = @(
        'Hashtable/Hashtable.type.ps1xml'
        'Noun/NounInfo.type.ps1xml'
        'String/String.type.ps1xml'
    )
    FormatsToProcess = @()

    NestedModules = @()

    FunctionsToExport = @(
        'Rename-Alias'
        'Test-Alias'

        'New-Dictionary'
        'Out-Dictionary'

        'Export-Function'
        'Get-Function'
        'Import-Function'
        'New-Function'
        'Remove-Function'
        'Rename-Function'
        'Set-Function'
        'Test-Function'

        'Get-Noun'

        'New-List'
        'Out-List'

        'New-RegexOptions'

        'New-Set'
        'Out-Set'

        'Rename-Variable'
        'Test-Variable'
        'Use-Variable'
    )
    AliasesToExport = @(
        'rnal'  # Rename-Alias
        'tal'   # Test-Alias

        'ndict'  # New-Dictionary
        'odict'  # Out-Dictionary

        'epf'  # Export-Function
        'gf'   # Get-Function
        'ipf'  # Import-Function
        'nf'   # New-Function
        'rf'   # Remove-Function
        'rnf'  # Rename-Function
        'sf'   # Set-Function
        'tf'   # Test-Function

        'nlist'  # New-List
        'olist'  # Out-List

        'nset'  # New-Set
        'oset'  # Out-Set

        'rnv'  # Rename-Variable
        'tv'   # Test-Variable
        'uv'   # Use-Variable
    )
    CmdletsToExport = @()
    VariablesToExport = @()
    DscResourcesToExport = @()

    ModuleList = @()
    FileList = @()

    PrivateData = @{
        PSData = @{
            Tags = @('Alias', 'Collections', 'Function', 'Hashtable', 'List', 'Noun', 'RegexOptions', 'Set', 'String', 'Variable')

            LicenseUri = 'https://raw.githubusercontent.com/travis-c-lagrone/powershell-tclg/master/LICENSE.txt'
            ProjectUri = 'https://github.com/travis-c-lagrone/powershell-tclg'
            # IconUri = ''

            # ReleaseNotes = ''
            # Prerelease = ''

            RequireLicenseAcceptance = $false

            # ExternalModuleDependencies = @()
        }
    }
    # HelpInfoURI = ''
    # DefaultCommandPrefix = ''
}
