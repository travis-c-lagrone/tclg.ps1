function Compare-SecureString {
    <#
    .SYNOPSIS
        Compares two [SecureString]s for case-sensitive equality of their underlying plain text value.

    .PARAMETER ReferenceSecureString
        The reference [SecureString] to compare.
        Is desecured as a plain text [string] before comparison.
        May not be null.

        Accepts input from the pipeline.
        Aliased as InputObject.

    .PARAMETER DifferenceSecureString
        The difference [SecureString] against which to compare each ReferenceSecureString.
        Is desecured as a plain text [string] before comparison.
        May not be null.

    .EXAMPLE
        PS> Compare-SecureString (Read-Host 'Enter your password:' -AsSecureString) (Read-Host 'Enter your password again:' -AsSecureString)

    .INPUTS
        SecureString
            The ReferenceSecureString to compare.

    .OUTPUTS
        bool
            Whether the desecured ReferenceSecureString is case-sensitively equal to the desecured DifferenceSecureString.

    .NOTES
        Each [SecureString] is converted to [string] by the command `ConvertFrom-SecureString -AsPlainText`.

        [string] comparison is performed by the operator `-ceq`.
    #>
    [CmdletBinding(DefaultParameterSetName='ReferenceSecureString, DifferenceSecureString', PositionalBinding=$false, SupportsShouldProcess)]
    [OutputType([bool])]
    param(
        [Parameter(ParameterSetName='ReferenceSecureString, DifferenceSecureString', Mandatory, Position=0)]
        [Parameter(ParameterSetName='InputObject, DifferenceSecureString', Mandatory, ValueFromPipeline)]
        [ValidateNotNull()]
        [SecureString]
        [Alias('InputObject')]
        $ReferenceSecureString,

        [Parameter(ParameterSetName='ReferenceSecureString, DifferenceSecureString', Mandatory, Position=1)]
        [Parameter(ParameterSetName='InputObject, DifferenceSecureString', Mandatory, Position=0)]
        [ValidateNotNull()]
        [SecureString]
        $DifferenceSecureString
    )
    begin {
        $differenceString = ConvertFrom-SecureString $DifferenceSecureString -AsPlainText -WarningAction Ignore
    }
    process {
        $referenceString = ConvertFrom-SecureString $ReferenceSecureString -AsPlainText -WarningAction Ignore
        ($referenceString -ceq $differenceString)
    }
}
