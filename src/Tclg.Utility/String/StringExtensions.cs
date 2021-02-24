namespace Tclg.Utility
{
    using System;
    using System.Management.Automation;

    public static class StringExtensions
    {
        public static string AddPrefix(this string @this, string value, string separator = "") => String.Join(separator, value, @this);
        public static string AddPrefixIfAbsent(this string @this, string value, string separator = "") => @this.StartsWith(value) ? @this : @this.AddPrefix(value, separator);
        public static string AddSuffix(this string @this, string value, string separator = "") => String.Join(separator, @this, value);
        public static string AddSuffixIfAbsent(this string @this, string value, string separator = "") => @this.EndsWith(value) ? @this : @this.AddSuffix(value, separator);
        public static string Remove(this string @this, string value) => @this.Replace(value, String.Empty);
        public static string RemoveFirst(this string @this, string value) { int index = @this.IndexOf(value); return index >= 0 ? @this.Remove(index, value.Length) : @this; }
        public static string RemoveLast(this string @this, string value) { int index = @this.LastIndexOf(value); return index >= 0 ? @this.Remove(index, value.Length) : @this; }
        public static string RemovePrefix(this string @this, int length) => @this.Substring(Math.Clamp(length, 0, @this.Length));
        public static string RemovePrefixIfPresent(this string @this, string value) => @this.StartsWith(value) ? @this.Substring(value.Length) : @this;
        public static string RemoveSuffix(this string @this, int length) => @this.Substring(0, @this.Length - Math.Clamp(length, 0, @this.Length));
        public static string RemoveSuffixIfPresent(this string @this, string value) => @this.EndsWith(value) ? @this.Substring(0, @this.Length - value.Length) : @this;
        public static string ReplacePrefix(this string @this, int length, string newValue) => @this.RemovePrefix(length).AddPrefix(newValue);
        public static string ReplacePrefixIfPresent(this string @this, string oldValue, string newValue) => @this.StartsWith(oldValue) ? @this.RemovePrefix(oldValue.Length).AddPrefix(newValue) : @this;
        public static string ReplaceSuffix(this string @this, int length, string newValue) => @this.RemoveSuffix(length).AddSuffix(newValue);
        public static string ReplaceSuffixIfPresent(this string @this, string oldValue, string newValue) => @this.EndsWith(oldValue) ? @this.RemoveSuffix(oldValue.Length).AddSuffix(newValue) : @this;
        public static string SubstringFrom(this string @this, string value) { int index = @this.IndexOf(value); return index >= 0 ? @this.Substring(index) : String.Empty; }
        public static string SubstringFromLast(this string @this, string value) { int index = @this.LastIndexOf(value); return index >= 0 ? @this.Substring(index) : String.Empty; }
        public static string SubstringUntil(this string @this, string value) { int index = @this.IndexOf(value); return index >= 0 ? @this.Substring(0, index) : String.Empty; }
        public static string SubstringUntilLast(this string @this, string value) { int index = @this.LastIndexOf(value); return index >= 0 ? @this.Substring(0, index) : String.Empty; }
        public static string Head(this string @this, int length) => @this.Substring(0, Math.Clamp(length, 0, @this.Length));
        public static string Tail(this string @this, int length) => @this.Substring(@this.Length - (length = Math.Clamp(length, 0, @this.Length)), length);
    }

    public static class PSStringExtensions
    {
        public static string AddPrefix(PSObject @this, string value, string separator = "") => @this.ToString().AddPrefix(value, separator);
        public static string AddPrefixIfAbsent(PSObject @this, string value, string separator = "") => @this.ToString().AddPrefixIfAbsent(value, separator);
        public static string AddSuffix(PSObject @this, string value, string separator = "") => @this.ToString().AddSuffix(value, separator);
        public static string AddSuffixIfAbsent(PSObject @this, string value, string separator = "") => @this.ToString().AddSuffixIfAbsent(value, separator);
        public static string Remove(PSObject @this, string value) => @this.ToString().Remove(value);
        public static string RemoveFirst(PSObject @this, string value) => @this.ToString().RemoveFirst(value);
        public static string RemoveLast(PSObject @this, string value) => @this.ToString().RemoveLast(value);
        public static string RemovePrefix(PSObject @this, int length) => @this.ToString().RemovePrefix(length);
        public static string RemovePrefixIfPresent(PSObject @this, string value) => @this.ToString().RemovePrefixIfPresent(value);
        public static string RemoveSuffix(PSObject @this, int length) => @this.ToString().RemoveSuffix(length);
        public static string RemoveSuffixIfPresent(PSObject @this, string value) => @this.ToString().RemoveSuffixIfPresent(value);
        public static string ReplacePrefix(PSObject @this, int length, string newValue) => @this.ToString().ReplacePrefix(length, newValue);
        public static string ReplacePrefixIfPresent(PSObject @this, string oldValue, string newValue) => @this.ToString().ReplacePrefixIfPresent(oldValue, newValue);
        public static string ReplaceSuffix(PSObject @this, int length, string newValue) => @this.ToString().ReplaceSuffix(length, newValue);
        public static string ReplaceSuffixIfPresent(PSObject @this, string oldValue, string newValue) => @this.ToString().ReplaceSuffixIfPresent(oldValue, newValue);
        public static string SubstringFrom(PSObject @this, string value) => @this.ToString().SubstringFrom(value);
        public static string SubstringFromLast(PSObject @this, string value) => @this.ToString().SubstringFromLast(value);
        public static string SubstringUntil(PSObject @this, string value) => @this.ToString().SubstringUntil(value);
        public static string SubstringUntilLast(PSObject @this, string value) => @this.ToString().SubstringUntilLast(value);
        public static string Head(PSObject @this, int length) => @this.ToString().Head(length);
        public static string Tail(PSObject @this, int length) => @this.ToString().Tail(length);
    }
}
