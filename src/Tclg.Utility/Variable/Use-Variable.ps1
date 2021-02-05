function Use-Variable {
    [Alias('uv')]
    param(
        [Parameter(Mandatory, Position=0)]
        [string[]]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({ Test-Path -LiteralPath "Variable:$_" -PathType Leaf })]
        $private:Name,

        [Parameter(Mandatory, Position=1)]
        [ScriptBlock]
        [ValidateNotNull()]
        $private:ScriptBlock
    )

    Get-Variable $Name -Scope 1 |
        ForEach-Object `
            -Process { $ExecutionContext.SessionState.PSVariable.Set($_) } `
            -End $ScriptBlock
}
