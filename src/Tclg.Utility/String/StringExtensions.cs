namespace Tclg.Utility
{
    using System;
    using System.Management.Automation;

    public static class StringExtensions
    {
        public static string AddPrefix(this string s, string value, string separator = "") => String.Join(separator, value, s);
        public static string AddPrefixIfAbsent(this string s, string value, string separator = "") => s.StartsWith(value) ? s : s.AddPrefix(value, separator);
        public static string AddSuffix(this string s, string value, string separator = "") => String.Join(separator, s, value);
        public static string AddSuffixIfAbsent(this string s, string value, string separator = "") => s.EndsWith(value) ? s : s.AddSuffix(value, separator);
        public static string AddSuffixIfAbsent(PSObject o, string value, string separator = "") => ((string) o).AddSuffixIfAbsent(o, value, separator);
        public static string Remove(this string s, string value) => s.Replace(value, String.Empty);
        public static string RemoveFirst(this string s, string value) { int index = s.IndexOf(value); return index >= 0 ? s.Remove(index, value.Length) : s; }
        public static string RemoveLast(this string s, string value) { int index = s.LastIndexOf(value); return index >= 0 ? s.Remove(index, value.Length) : s; }
        public static string RemovePrefix(this string s, int length) => s.Substring(Math.Clamp(length, 0, s.Length));
        public static string RemovePrefixIfPresent(this string s, string value) => s.StartsWith(value) ? s.Substring(value.Length) : s;
        public static string RemoveSuffix(this string s, int length) => s.Substring(0, s.Length - Math.Clamp(length, 0, s.Length));
        public static string RemoveSuffixIfPresent(this string s, string value) => s.EndsWith(value) ? s.Substring(0, s.Length - value.Length) : s;
        public static string ReplacePrefix(this string s, int length, string newValue) => s.RemovePrefix(length).AddPrefix(newValue);
        public static string ReplacePrefixIfPresent(this string s, string oldValue, string newValue) => s.StartsWith(oldValue) ? s.RemovePrefix(oldValue.Length).AddPrefix(newValue) : s;
        public static string ReplaceSuffix(this string s, int length, string newValue) => s.RemoveSuffix(length).AddSuffix(newValue);
        public static string ReplaceSuffixIfPresent(this string s, string oldValue, string newValue) => s.EndsWith(oldValue) ? s.RemoveSuffix(oldValue.Length).AddSuffix(newValue) : s;
        public static string SubstringFrom(this string s, string value) { int index = s.IndexOf(value); return index >= 0 ? s.Substring(index) : String.Empty; }
        public static string SubstringFromLast(this string s, string value) { int index = s.LastIndexOf(value); return index >= 0 ? s.Substring(index) : String.Empty; }
        public static string SubstringUntil(this string s, string value) { int index = s.IndexOf(value); return index >= 0 ? s.Substring(0, index) : String.Empty; }
        public static string SubstringUntilLast(this string s, string value) { int index = s.LastIndexOf(value); return index >= 0 ? s.Substring(0, index) : String.Empty; }
        public static string Head(this string s, int length) => s.Substring(0, Math.Clamp(length, 0, s.Length));
        public static string Tail(this string s, int length) => s.Substring(s.Length - (length = Math.Clamp(length, 0, s.Length)), length);

    public static class PSStringExtensions
    {
        public static string AddPrefix(PSObject psString, string value, string separator = "") => ((string) psString).AddPrefix(value, separator);
        public static string AddPrefixIfAbsent(PSObject psString, string value, string separator = "") => ((string) psString).AddPrefixIfAbsent(value, separator);
        public static string AddSuffix(PSObject psString, string value, string separator = "") => ((string) psString).AddSuffix(psString, value, separator);
        public static string Remove(PSObject psString, string value) => ((string) psString).Remove(psString, value);
        public static string RemoveFirst(PSObject psString, string value) => ((string) psString).RemoveFirst(psString, value);
        public static string RemoveLast(PSObject psString, string value) => ((string) psString).RemoveLast(psString, value);
        public static string RemovePrefix(PSObject psString, int length) => ((string) psString).RemovePrefix(psString, length);
        public static string RemovePrefixIfPresent(PSObject psString, string value) => ((string) psString).RemovePrefixIfPresent(psString, value);
        public static string RemoveSuffix(PSObject psString, int length) => ((string) psString).RemoveSuffix(psString, length);
        public static string RemoveSuffixIfPresent(PSObject psString, string value) => ((string) psString).RemoveSuffixIfPresent(psString, value);
        public static string ReplacePrefix(PSObject psString, int length, string newValue) => ((string) psString).ReplacePrefix(psString, length, newValue);
        public static string ReplacePrefixIfPresent(PSObject psString, string oldValue, string newValue) => ((string) psString).ReplacePrefixIfPresent(psString, oldValue, newValue);
        public static string ReplaceSuffix(PSObject psString, int length, string newValue) => ((string) psString).ReplaceSuffix(psString, length, newValue);
        public static string ReplaceSuffixIfPresent(PSObject psString, string oldValue, string newValue) => ((string) psString).ReplaceSuffixIfPresent(psString, oldValue, newValue);
        public static string SubstringFrom(PSObject psString, string value) => ((string) psString).SubstringFrom(psString, value);
        public static string SubstringFromLast(PSObject psString, string value) => ((string) psString).SubstringFromLast(psString, value);
        public static string SubstringUntil(PSObject psString, string value) => ((string) psString).SubstringUntil(psString, value);
        public static string SubstringUntilLast(PSObject psString, string value) => ((string) psString).SubstringUntilLast(psString, value);
        public static string Head(PSObject psString, int length) => ((string) psString).Head(psString, length);
        public static string Tail(PSObject psString, int length) => ((string) psString).Tail(psString, length);
    }
}
