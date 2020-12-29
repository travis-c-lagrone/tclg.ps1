@{
RootModule = 'Tclg.PSScriptAnalyzer.psm1'
ModuleVersion = '0.0.1'
GUID = '13c91ebd-07d4-4497-bb88-775eed5917a8'

Author = 'Travis C. LaGrone'
Copyright = '2020 (c) Travis C. LaGrone. All rights reserved.'
# TODO Description = ''

PowerShellVersion = '7.1'
RequiredModules = @('PSScriptAnalyzer')
RequiredAssemblies = @()
ScriptsToProcess = @()
TypesToProcess = @()
FormatsToProcess = @()
NestedModules = @()

FunctionsToExport = @()
CmdletsToExport = @()
VariablesToExport = @()
AliasesToExport = @(
    'gsar'
    'ifr'
    'isa'
)
DscResourcesToExport = @()

ModuleList = @('Tclg.PSScriptAnalyzer')
FileList = @(
    'aliases.csv'
    'Tclg.PSScriptAnalyzer.psd1'
    'Tclg.PSScriptAnalyzer.psm1'
)

PrivateData = @{
    PSData = @{
        Tags = @('PSScriptAnalyzer')
        # TODO LicenseUri = ''
        # TODO ProjectUri = ''
        # TODO ReleaseNotes = ''
        # TODO Prerelease = ''
        RequireLicenseAcceptance = $false
        ExternalModuleDependencies = @()
    }
}

# TODO HelpInfoURI = ''
}
