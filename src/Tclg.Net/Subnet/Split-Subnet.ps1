#Requires -Module Subnet
function Split-Subnet {
    [CmdletBinding(PositionalBinding = $false)]
    param(
        [Parameter(Mandatory, Position = 0)]
        [Alias('Address', 'IP')]
        [ValidateScript({ $_.AddressFamily -eq [Net.Sockets.AddressFamily]::InterNetwork })]
        [IPAddress]
        $NetworkAddress,

        [Parameter(Mandatory, Position = 1)]
        [Alias('NetMask', 'MaskBits')]
        [ValidateRange(8, 31)]
        [int]
        $MaskLength,

        [Parameter(Mandatory, HelpMessage = 'The count of subnets to return. Equal to one fewer than the count of splits to perform.')]
        [Alias('Subnets')]
        [ValidateRange('Positive')]
        [ValidateScript({ $_ -eq 1 -or [Math]::IEEERemainder($_, 2) -eq 0.0 })]
        [int]
        $Count
    )

    function ConvertTo-IPAddress ([Collections.BitArray] $Bits) {
        # TODO
    }

    $net = [Collections.BitArray]::new($NetworkAddress.GetAddressBytes())
    $netMask = [Collections.BitArray]::new(32, $true).RightShift(32 - $MaskLength)
    $prefix = $net.And($netMask)

    $netLength = [Math]::Pow(2, 32 - $MaskLength)
    $subnetLength = $netLength / $Count

    $bytes = [byte[]]::new(32 / 8)
    for ($i = 0; $i -lt $Count; $i++) {
        $suffix = [Collections.BitArray]::new([BitConverter]::GetBytes(32 - $subnetLength * $i))
        $subnet = $prefix.Or($suffix)

        $subnet.CopyTo($bytes, 0)
        Get-Subnet -IP ([IPAddress]::new($bytes).ToString()) -MaskBits $MaskLength
    }
}
