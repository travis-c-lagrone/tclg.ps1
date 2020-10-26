$TimestampRegex = [regex]::new(@'
(?nx)
^
\s*
(?<Year> \d{4} )
(
    -?
    (?<Month> \d{2} )
    (
        -?
        (?<Day> \d{2} )
        (# Time
            ( T | \s | \sT\s )
            (?<Hour> \d{1,2} )
            (
                :?
                (?<Minute> \d{2} )
                (
                    :?
                    (?<Second> \d{2} )
                    (
                        \.?
                        (?<Millisecond> \d{1,4} )
                    )?
                )?
            )?
        )?
        (# TimeZone
            \s?
            (
                (?<Universal> [Zz] | UTC | GMT )
                |
                (# Offset
                    (?<OffsetSign> [+-] )
                    (?<OffsetHour> \d{1,2} )
                    (
                        :?
                        (?<OffsetMinute> \d{2} )
                    )?
                )
            )
        )?
    )?
)?
\s*
$
'@)

function ConvertFrom-Timestamp {
    [CmdletBinding(PositionalBinding = $false)]
    [OutputType([DateTime], [DateTimeOffset])]
    param(
        [Parameter(Mandatory, Position = 0, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Timestamp
    )
    process {
        $match = $TimestampRegex.Match($Timestamp)
        if (-not $match.Success) {
            Write-Error `
                -Message "Argument not parseable as a timestamp." `
                -Category InvalidArgument `
                -CategoryActivity 'System.Text.RegularExpressions.Regex.Match' `
                -CategoryReason 'Match failed.' `
                -CategoryTargetName 'Timestamp' `
                -CategoryTargetType ([string]) `
                -TargetObject $Timestamp
            return
        }
        try {
            $groups = $match.Groups
            return $(
                if ($groups['Offset'].Success) {
                    $datetime = [DateTime]::new(
                        $groups['Year'].Success       ? [int] $groups['Year'].Value       : 0,
                        $groups['Month'].Success      ? [int] $groups['Month'].Value      : 0,
                        $groups['Day'].Success        ? [int] $groups['Day'].Value        : 0,
                        $groups['Hour'].Success       ? [int] $groups['Hour'].Value       : 0,
                        $groups['Minute'].Success     ? [int] $groups['Minute'].Value     : 0,
                        $groups['Second'].Success     ? [int] $groups['Second'].Value     : 0,
                        $groups['Millsecond'].Success ? [int] $groups['Millsecond'].Value : 0
                    )
                    $signum = [int] ($groups['OffsetSign'].Value + '1')
                    $offset = [TimeSpan]::new(
                        $groups['OffsetHour'].Success   ? $signum * ([int] $groups['OffsetHour'].Value)   : 0,
                        $groups['OffsetMinute'].Success ? $signum * ([int] $groups['OffsetMinute'].Value) : 0,
                        $groups['OffsetSecond'].Success ? $signum * ([int] $groups['OffsetSecond'].Value) : 0
                    )
                    [DateTimeOffset]::($datetime, $offset)
                }
                else {
                    [DateTime]::new(
                        $groups['Year'].Success       ? [int] $groups['Year'].Value       : 0,
                        $groups['Month'].Success      ? [int] $groups['Month'].Value      : 0,
                        $groups['Day'].Success        ? [int] $groups['Day'].Value        : 0,
                        $groups['Hour'].Success       ? [int] $groups['Hour'].Value       : 0,
                        $groups['Minute'].Success     ? [int] $groups['Minute'].Value     : 0,
                        $groups['Second'].Success     ? [int] $groups['Second'].Value     : 0,
                        $groups['Millsecond'].Success ? [int] $groups['Millsecond'].Value : 0,
                        $groups['Universal'].Success ? [DateTimeKind]::Utc : [DateTimeKind]::Unspecified
                    )
                }
            )
        }
        catch {
            Write-Error $_
        }
    }
}
