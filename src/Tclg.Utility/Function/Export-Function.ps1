function Export-Function ([string[]] $Name, [string] $Directory = $PWD, [switch] $Force) {
    begin {
        function createDirectory { [void]$( New-Item $Directory -ItemType 'Directory' -Force:$Force ) }
        if (-not (Test-Path -LiteralPath $Directory)) {
            createDirectory
        }
        if (-not (Test-Path -LiteralPath $Directory -PathType Container)) {
            if ($Force) {
                createDirectory
            } else {
                throw "$Directory is not a container item!"
            }
        }
    }
    process {
        ($Name ?? $_) | Get-Item "Function:\${_}" -Force:$Force | ForEach-Object {
            New-Item -Path $Directory -Name "$($_.Name).ps1" -Value $_.Definition -Force:$Force
        }
    }
}

Set-Alias -Name 'epf' -Value 'Export-Function'
