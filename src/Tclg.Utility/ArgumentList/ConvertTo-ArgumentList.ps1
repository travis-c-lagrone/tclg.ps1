function ConvertTo-ArgumentList ([hashtable] $Parameters) { New-ArgumentList @Parameters }

Set-Alias -Name 'ConvertTo-Args' -Value 'ConvertTo-ArgumentList' -Description 'Sugar'
