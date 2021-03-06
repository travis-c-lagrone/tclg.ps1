#nullable enable

using System;
using System.Collections.Generic;
using System.Linq;

namespace Tclg.PowerShell.Utility
{
    public static partial class StringExtensions
    {
        public static string AddPrefix(PSObject @this, string value, string separator = "") => @this.ToString().AddPrefix(value, separator);
        public static string AddPrefixIfAbsent(PSObject @this, string value, string separator = "") => @this.ToString().AddPrefixIfAbsent(value, separator);
        public static string AddSuffix(PSObject @this, string value, string separator = "") => @this.ToString().AddSuffix(value, separator);
        public static string AddSuffixIfAbsent(PSObject @this, string value, string separator = "") => @this.ToString().AddSuffixIfAbsent(value, separator);
        public static string Remove(PSObject @this, string value) => @this.ToString().Remove(value);
        public static string RemoveFirst(PSObject @this, string value) => @this.ToString().RemoveFirst(value);
        public static string RemoveLast(PSObject @this, string value) => @this.ToString().RemoveLast(value);
        public static string RemoveHead(PSObject @this, int length) => @this.ToString().RemoveHead(length);
        public static string RemovePrefixIfPresent(PSObject @this, string value) => @this.ToString().RemovePrefixIfPresent(value);
        public static string RemoveTail(PSObject @this, int length) => @this.ToString().RemoveTail(length);
        public static string RemoveSuffixIfPresent(PSObject @this, string value) => @this.ToString().RemoveSuffixIfPresent(value);
        public static string ReplaceHead(PSObject @this, int length, string newValue) => @this.ToString().ReplaceHead(length, newValue);
        public static string ReplacePrefixIfPresent(PSObject @this, string oldValue, string newValue) => @this.ToString().ReplacePrefixIfPresent(oldValue, newValue);
        public static string ReplaceTail(PSObject @this, int length, string newValue) => @this.ToString().ReplaceTail(length, newValue);
        public static string ReplaceSuffixIfPresent(PSObject @this, string oldValue, string newValue) => @this.ToString().ReplaceSuffixIfPresent(oldValue, newValue);
        public static string SubstringFrom(PSObject @this, string value) => @this.ToString().SubstringFrom(value);
        public static string SubstringFromLast(PSObject @this, string value) => @this.ToString().SubstringFromLast(value);
        public static string SubstringUntil(PSObject @this, string value) => @this.ToString().SubstringUntil(value);
        public static string SubstringUntilLast(PSObject @this, string value) => @this.ToString().SubstringUntilLast(value);
        public static string Head(PSObject @this, int length) => @this.ToString().Head(length);
        public static string Tail(PSObject @this, int length) => @this.ToString().Tail(length);
    }
}
