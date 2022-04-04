@{
    RootModule = 'Tclg.Security.psm1'
    ModuleVersion = '0.0.1'
    GUID = 'f6191800-65ab-46b3-bb90-cd8b6661c693'
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
    TypesToProcess = @()
    FormatsToProcess = @()

    NestedModules = @()

    FunctionsToExport = @(
        'Compare-SecureString'
    )
    AliasesToExport = @()
    CmdletsToExport = @()
    VariablesToExport = @()
    DscResourcesToExport = @()

    ModuleList = @()
    FileList = @()

    PrivateData = @{
        PSData = @{
            Tags = @()

            LicenseUri = 'https://raw.githubusercontent.com/travis-c-lagrone/tclg.ps1/master/LICENSE.txt'
            ProjectUri = 'https://github.com/travis-c-lagrone/tclg.ps1'
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
