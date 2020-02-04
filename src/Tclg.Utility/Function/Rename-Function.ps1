function Rename-Function {
    [CmdletBinding(PositionalBinding=$false, SupportsShouldProcess, DefaultParameterSetName='Pipeline')]
    param(
        [Parameter(Mandatory, ValueFromPipeline, ParameterSetName='Pipeline')]
        [Parameter(Mandatory, Position=0, ParameterSetName='Positional')]
        [ValidateNotNullOrEmpty()]
        [string] $OldName,

        [Parameter(Mandatory, Position=0, ParameterSetName='Pipeline')]
        [Parameter(Mandatory, Position=1, ParameterSetName='Positional')]
        [ValidateNotNullOrEmpty()]
        [string] $NewName,

        [switch] $Force
    )

    Rename-Item "Function:\$OldName" $NewName -PassThru -Force:$Force
}

Set-Alias -Name 'rnf' -Value 'Rename-Function'
