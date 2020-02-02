function Rename-Variable {
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
            [System.Management.Automation.CompletionCompleters]::CompleteVariable($wordToComplete)
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
            $Scope = ($Scope -as [int]) + 1  # E.g. the caller's "0" is this function's "1".
        }

        $splatGet = @{}
        if ($Force) {
            $splatGet['Force'] = $true
        }

        $var = $null
        try {
            $var = Get-Variable @splatGet -Name $Name -Scope $Scope -ErrorAction Stop
        } catch {
            Write-Error -Exception $_
            return  # continue process
        }

        if ($var.Count -gt 1) {
            Write-Error "Multiple variables found for name ${Name}: $($var.Name -join ', ')"
            return  # continue process
        }

        $splatNew = $splatGet.Clone()
        if ($var.Description) {
            $splatNew['Description'] = $var.Description
        }
        if ($var.Options) {
            $splatNew['Option'] = $var.Options
        }
        if ($var.Visibility) {
            $splatNew['Visibility'] = $var.Visibility
        }

        try {
            New-Variable @splatNew -Name $NewName -Value $var.Value -Scope $Scope -PassThru -ErrorAction Stop
        } catch {
            Write-Error -Exception $_
            return  # continue process
        }

        $splatRemove = $splatGet
        Remove-Variable @splatRemove -Name $Name -Scope $Scope -ErrorAction Continue
    }
}

Set-Alias -Name 'rnv' -Value 'Rename-Variable'
