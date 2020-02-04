function New-FileAttributes {
    [CmdletBinding(PositionalBinding=$false, SupportsShouldProcess)]
    [OutputType([System.IO.FileAttributes])]
    param(
        # The FileAttributes flags to combine into a single FileAttributes object.
        [Parameter(Position=0, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [System.IO.FileAttributes[]]
        [Alias('FileAttributes')]
        $Attributes
    )
    begin {
        $list = [System.Collections.Generic.LinkedList[object]]::new()
    }
    process {
        foreach ($eachAttributes in $Attributes) {
            [void] $list.Add($eachAttributes)
        }
    }
    end {
        if (-not $list.Count) {
            [System.IO.FileAttributes]::Normal
            return
        }

        $union = [System.IO.FileAttributes] 0
        foreach ($eachAttributes in $list) {
            $union = $union -bor $eachAttributes
        }
        $union
    }
}
