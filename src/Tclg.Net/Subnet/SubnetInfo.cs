using System;
using System.Collections;
using System.Net;
using System.Net.Sockets;

#nullable enable
namespace Tclg.Net
{
    public class SubnetInfo
    {
        private const char CidrSeparator = '/';
        private const int MinimumMaskLength = 8;  // Every classful network mask is at least 8 bits in length.

        public SubnetInfo(IPAddress ipAddress, int maskLength)
        {
            IPVersion = (IPVersion) ipAddress.AddressFamily;
            ValidateIPVersion(IPVersion, ipAddress.AddressFamily)

            MaskLength = maskLength;
            ValidateMaskLength(MaskLength, IPVersion);

            var maskBits = NewSubnetMaskBits(MaskLength, IPVersion);
            Mask = (IPAddress) maskBits;

            var ipAddressBits = (BitArray) ipAddress;

            NetworkAddress = ConvertToNetworkAddress(ipAddressBits, maskBits)
            ValidateNetworkAddress(NetworkAddress, MaskLength);

            BroadcastAddress = ConvertToBroadcastAddress(ipAddressBits, maskBits);
        }

        public IPVersion IPVersion { get; init; }

        public int MaskLength { get; init; }
        public IPAddress Mask { get; init; }

        public IPAddress NetworkAddress { get; init; }
        public IPAddress BroadcastAddress { get; init; }

        private Lazy<IList<IPAddress>> _hostAddresses = () => null;  // TODO _hostAddresses
        public IList<IPAddress> HostAddresses => _hostAddresses.Value;

        protected static void ValidateIPVersion(IPVersion ipVersion, AddressFamily addressFamily)
        {
            if (ipVersion == IPVersion.Unspecified || ipVersion == IPVersion.Unknown)
            {
                throw new ArgumentException($"Expected a specific IP version, but found that it was {ipVersion} for the address family {addressFamily}.");
            }
        }

        protected static void ValidateMaskLength(int maskLength, IPVersion ipVersion)
        {
            if (maskLength < MinimumMaskLength)
            {
                throw new ArgumentException($"Expected a mask length of at least {MinimumMaskLength}, but found that it was {maskLength}.");
            }

            int maximumMaskLength = ipVersion.Bits - 1;
            if (maskLength > maximumMaskLength)
            {
                throw new ArgumentException($"Expected a mask length of at most {maximumMaskLength}, but found that it was {maskLength}.");
            }
        }

        protected static BitArray NewSubnetMaskBits(int maskLength, IPVersion ipVersion = IPVersion.IPv4) =>
                new BitArray(ipVersion.Bits, true).LeftShift(ipVersion.Bits - maskLength);

        protected static IPAddress ConvertToNetworkAddress(BitArray ipAddressBits, BitArray maskBits) =>
                (IPAddress) ipAddressBits.And(maskBits);

        protected static IPAddress ConvertToBroadcastAddress(BitArray ipAddressBits, BitArray maskBits) =>
                (IPAddress) ipAddressBits.Or(maskBits.Not());

        public static SubnetInfo Parse(string cidrIPAddress)
        {
            var parts = cidrIPAddress.Split(CidrSeparator);
            if (parts.Length != 2)
                throw new ArgumentException($"Invalid CIDR notation: {cidrIPAddress}");

            var ipAddress = IPAddress.Parse(parts[0]);
            var maskLength = int.Parse(parts[1]);

            var subnet = new SubnetInfo(ipAddress, maskLength);
            return subnet;
        }
    }

    public enum IPVersion
    {
        IPv4 = 4,
        IPv6 = 6,
        Unspecified = 0,
        Unknown = -1
    }

    public static class IPVersionExtensions
    {
        public static int Bits(this IPVersion ipVersion) => ipVersion switch
        {
            IPVersion.IPv4 =>  32,
            IPVersion.IPv6 => 128,
            default => 0
        };

        public static int Bytes(this IPVersion ipVersion) => ipVersion switch
        {
            IPVersion.IPv4 =>  4,
            IPVersion.IPv6 => 16,
            default => 0
        };

        public static implicit operator AddressFamily(this IPVersion ipVersion) => ipVersion switch
        {
            IPVersion.IPv4 => AddressFamily.InterNetwork,
            IPVersion.IPv6 => AddressFamily.InterNetworkV6,
            IPVersion.Unspecified => AddressFamily.Unspecified,
            default => AddressFamily.Unknown
        };

        public static implicit operator ProtocolFamily(this IPVersion ipVersion) => ipVersion switch
        {
            IPVersion.IPv4 => ProtocolFamily.InterNetwork,
            IPVersion.IPv6 => ProtocolFamily.InterNetworkV6,
            IPVersion.Unspecified => ProtocolFamily.Unspecified,
            default => ProtocolFamily.Unknown
        };

        public static implicit operator ProtocolType(this IPVersion ipVersion) => ipVersion switch
        {
            IPVersion.IPv4 => ProtocolType.IPv4,
            IPVersion.IPv6 => ProtocolType.IPv6,
            default => ProtocolType.IP
        };

        public static explicit operator IPVersion(this AddressFamily addressFamily) => addressFamily switch
        {
            AddressFamily.InterNetwork => IPVersion.IPv4,
            AddressFamily.InterNetworkV6 => IPVersion.IPv6,
            default => IPVersion.Unknown
        };

        public static explicit operator IPVersion(this ProtocolFamily protocolFamily) => protocolFamily switch
        {
            ProtocolFamily.InterNetwork => IPVersion.IPv4,
            ProtocolFamily.InterNetworkV6 => IPVersion.IPv6,
            default => IPVersion.Unknown
        };

        public static explicit operator IPVersion(this ProtocolType protocolType) => protocolType switch
        {
            ProtocolType.IP => IPVersion.Unspecified,
            ProtocolType.IPv4 => IPVersion.IPv4,
            ProtocolType.IPSecAuthenticationHeader         => IPVersion.IPv6,
            ProtocolType.IPSecEncapsulatingSecurityPayload => IPVersion.IPv6,
            ProtocolType.IPv6                              => IPVersion.IPv6,
            ProtocolType.IPv6DestinationOptions            => IPVersion.IPv6,
            ProtocolType.IPv6FragmentHeader                => IPVersion.IPv6,
            ProtocolType.IPv6HopByHopOptions               => IPVersion.IPv6,
            ProtocolType.IPv6NoNextHeader                  => IPVersion.IPv6,
            ProtocolType.IPv6RoutingHeader                 => IPVersion.IPv6,
            default => IPVersion.Unknown
        };
    }

    internal partial static class IPAddressExtensions
    {
        public static implicit operator BitArray(this IPAddress ipAddress) => new BitArray(ipAddress.GetAddressBytes());

        public static explicit operator IPAddress(this BitArray bitArray)
        {
            byte[] bytes = new byte[bitArray.Length / 8];
            bitArray.CopyTo(bytes, 0);
            return new IPAddress(bytes);
        }
    }
}
