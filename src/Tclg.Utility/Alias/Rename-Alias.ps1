function Rename-Alias {
    [CmdletBinding(DefaultParameterSetName='Position', PositionalBinding=$false, SupportsShouldProcess)]
    param(
        [Parameter(ParameterSetName='ValueFromPipelineByPropertyName', Mandatory, ValueFromPipelineByPropertyName)]
        [Parameter(ParameterSetName='ValueFromPipeline', Mandatory, ValueFromPipeline)]
        [Parameter(ParameterSetName='Position', Mandatory, Position=0)]
        [SupportsWildcards()]
        [string]
        [ValidateNotNullOrEmpty()]
        [ArgumentCompleter({
            param ($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)

            $splat = @{
                Name = "${wordToComplete}*"
            }
            if ($fakeBoundParameters.Contains('Scope')) {
                $splat['Scope'] = $fakeBoundParameters['Scope']
            }

            $aliases = Get-Alias @splat
            foreach ($alias in $aliases) {
                [System.Management.Automation.CompletionResult]::new(
                    $alias.Name,  # completionText
                    $alias.Name,  # listItemText
                    [System.Management.Automation.CompletionResult]::Command,  # resultType
                    $alias.DisplayName  # toolTip
                )
            }
        })]
        $Name,

        [Parameter(ParameterSetName='ValueFromPipelineByPropertyName', Mandatory, Position=0)]
        [Parameter(ParameterSetName='ValueFromPipeline', Mandatory, Position=0)]
        [Parameter(ParameterSetName='Position', Mandatory, Position=1)]
        [string]
        [ValidateNotNullOrEmpty()]
        $NewName,

        [Parameter()]
        [string]
        [ValidateScript({ ($_ -in @('Global', 'Local', 'Private', 'Script')) -or (($_ -as [int]) -ge 0) })]
        [ArgumentCompletions('Global', 'Local', 'Private', 'Script')]
        $Scope = 'Local',

        [Parameter()]
        [switch]
        $Force
    )
    process {
        if ($Scope -eq 'Local') {
            $Scope = 0
        }
        if ($Scope -as [int] -ne $null) {
            $Scope = ($Scope -as [int]) + 1  # E.g. the caller's "0" is this command's "1".
        }

        $splatGet = @{}
        if ($Force) {
            $splatGet['Force'] = $true
        }

        $alias = $null
        try {
            $alias = Get-Alias @splatGet -Name $Name -Scope $Scope -ErrorAction Stop
        } catch {
            Write-Error -Exception $_
            return  # continue process
        }

        if ($alias.Count -gt 1) {
            Write-Error "Multiple variables found for name ${Name}: $($alias.Name -join ', ')"
            return  # continue process
        }

        $splatNew = $splatGet.Clone()
        if ($alias.Description) {
            $splatNew['Description'] = $alias.Description
        }
        if ($alias.Options) {
            $splatNew['Option'] = $alias.Options
        }
        if ($alias.Visibility) {
            $splatNew['Visibility'] = $alias.Visibility
        }

        try {
            New-Alias @splatNew -Name $NewName -Value $alias.Value -Scope $Scope -PassThru -ErrorAction Stop
        } catch {
            Write-Error -Exception $_
            return  # continue process
        }

        $splatRemove = $splatGet
        Remove-Alias @splatRemove -Name $Name -Scope $Scope -ErrorAction Continue
    }
}

Set-Alias -Name 'rnal' -Value 'Rename-Alias'
