@{
    RootModule = 'Tclg.Management.psm1'
    ModuleVersion = '0.0.2'
    GUID = '68b83a6a-eefa-43ce-89e3-102fdf35a0d7'
    Author = 'Travis C. LaGrone'
    Copyright = @'
Copyright 2020 Travis C. LaGrone

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
'@
    Description = '#TODO'
    PowerShellVersion = '7.1.2'

    RequiredModules = @()
    RequiredAssemblies = @()

    ScriptsToProcess = @()
    TypesToProcess = @()
    FormatsToProcess = @()

    NestedModules = @()

    FunctionsToExport = @(
        'Get-EnvPath'

        'Get-EnvVariable'
        'Set-EnvVariable'

        'Merge-FileAttributes'
        'New-FileAttributes'
        'Split-FileAttributes'
        'Test-FileAttributes'

        'Hide-Item'
        'Lock-Item'
        'Protect-Item'
        'Show-Item'
        'Unlock-Item'
        'Unprotect-Item'
    )
    AliasesToExport = @(
        'gep'  # Get-EnvPath

        'gev'  # Get-EnvVariable
        'sev'  # Set-EnvVariable

        'hi'   # Hide-Item
        'lki'  # Lock-Item
        'pti'  # Protect-Item
        'shi'  # Show-Item
        'uki'  # Unlock-Item
        'upi'  # Unprotect-Item
    )
    CmdletsToExport = @()
    VariablesToExport = @()
    DscResourcesToExport = @()

    ModuleList = @()
    FileList = @()

    PrivateData = @{
        PSData = @{
            Tags = @(
                'file'
                'attributes'
                'FileAttributes'
                'item'
                'management'
                'ReadOnly'
                'Hidden'
                'Encrypted'
                'env'
                'environment'
                'path'
                'variable'
            )

            LicenseUri = 'https://raw.githubusercontent.com/travis-c-lagrone/powershell-tclg/master/LICENSE.txt'
            ProjectUri = 'https://github.com/travis-c-lagrone/powershell-tclg'
            # IconUri = ''

            # ReleaseNotes = ''
            Prerelease = '20210223'

            RequireLicenseAcceptance = $false

            # ExternalModuleDependencies = @()
        }
    }
    # HelpInfoURI = ''
    # DefaultCommandPrefix = ''
}
