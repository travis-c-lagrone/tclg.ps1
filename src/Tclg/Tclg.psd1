@{
    RootModule = 'Tclg.psm1'
    ModuleVersion = '0.0.2'

    GUID = '927604ec-8b1d-4f98-8353-1469171e44cd'
    Author = 'Travis C. LaGrone'
    Copyright = @'
Copyright 2020 Travis C. LaGrone

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
'@
    Description = 'Utilities, helpers, sugar, etc. for Travis C. LaGrone'

    CompatiblePSEditions = @('Core')
    PowerShellVersion = '7.1'

    # PowerShellHostName = ''
    # PowerShellHostVersion = ''

    RequiredModules = @(
        'Tclg.Core'
        'Tclg.Management'
        'Tclg.Security'
        'Tclg.Utility'
        'Tclg.Web'
    )
    RequiredAssemblies = @()
    ScriptsToProcess = @('Scripts/Add-TclgProjectSrcToEnvPATH.ps1')
    TypesToProcess = @()
    FormatsToProcess = @()

    NestedModules = @()

    FunctionsToExport = @()
    CmdletsToExport = @()
    VariablesToExport = @()
    AliasesToExport = @()
    DscResourcesToExport = @()

    ModuleList = @('Tclg')
    FileList = @(
        'Tclg.psd1'
        'Tclg.psm1'
        'Scripts/Add-TclgProjectSrcToEnvPATH.ps1'
    )

    PrivateData = @{
        PSData = @{
            # Tags = @()
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
