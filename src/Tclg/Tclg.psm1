using namespace System.Management.Automation.Language

$ExecutionContext.SessionState.Module.OnRemove = {
    $srcPath = $PSScriptRoot
    while ($srcPath -and (Split-Path $srcPath -Leaf) -ne 'src') {
        $srcPath = Split-Path $srcPath
    }
    $Env:PSModulePath = ($Env:PSModulePath -split ([IO.Path]::PathSeparator)).Where{ $_ -ne $srcPath } -join ([IO.Path]::PathSeparator)
} |
    ForEach-Object ToString |
    ForEach-Object Replace '$PSScriptRoot', "'$([CodeGeneration]::EscapeSingleQuotedStringContent($PSScriptRoot))'" |
    ForEach-Object { [ScriptBlock]::Create($_) }
