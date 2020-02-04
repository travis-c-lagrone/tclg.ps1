filter Split-FileAttributes ([System.IO.FileAttributes] $Attributes) {
    if ($_ -and $Attributes) {
        throw "May not pass both `$Attributes argument and pipeline input"
    }

    $Attributes = ($_ ?? $Attributes)
    $EnumValues = [System.IO.FileAttributes].GetEnumValues()

    $split = [System.Collections.Generic.List[System.IO.FileAttributes]]::new($EnumValues.Count)
    foreach ($enumValue in $EnumValues) {
        if ($enumValue -band $Attributes) {
            $split.Add($enumValue)
        }
    }
    $split
}
