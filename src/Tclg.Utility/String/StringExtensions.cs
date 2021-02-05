namespace Tclg.Utility
{
    using System;

    public static class StringExtensions
    {
        public static string AddPrefix(this string s, string value, string separator = "") => String.Join(separator, value, s);
        public static string AddPrefixIfAbsent(this string s, string value, string separator = "") => s.StartsWith(value) ? s : s.AddPrefix(value, separator);
        
        public static string AddSuffix(this string s, string value, string separator = "") => String.Join(separator, s, value);
        public static string AddSuffixIfAbsent(this string s, string value, string separator = "") => s.EndsWith(value) ? s : s.AddSuffix(value, separator);
        
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

        // TODO Convert all inline ScriptMethods in String.type.ps1xml to CodeMethods.
    }
}
