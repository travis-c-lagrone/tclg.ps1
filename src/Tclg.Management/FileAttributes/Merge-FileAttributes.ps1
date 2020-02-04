function Merge-FileAttributes ([System.IO.FileAttributes[]] $Attributeses) {
    $Input = @($Input)
    if ($Input -and $Attributses) {
        throw "May not pass both `$Attributses argument and pipeline input"
    }
    if ($Input) {
        $Attributses = $Input
    }

    $merged = [System.IO.FileAttributes] 0
    foreach ($attributes in $Attributses) {
        $merged = $merged -bor $attributes
    }
    $merged
}
