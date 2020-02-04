filter Import-Function ([string[]] $Path, [switch] $Force) {
    ($Path ?? $Input) | Get-Item -Force:$Force | ForEach-Object {
        New-Item -Path 'Function:\' -Name $_.BaseName -Value (Get-Content $_ -Raw) -Force:$Force
    }
}

Set-Alias -Name 'ipf' -Value 'Import-Function'
