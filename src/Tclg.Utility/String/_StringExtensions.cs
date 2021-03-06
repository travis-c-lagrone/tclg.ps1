#nullable enable
using System;
using System.Collections.Generic;
using System.Linq;

namespace Tclg.PowerShell.Utility
{
    public static partial class StringExtensions
    {
        public static bool ContainsAll(this string @this, IList<string> values) => values.All(@value => @this.Contains(@value));
        public static bool ContainsAny(this string @this, IList<string> values) => values.Any(@value => @this.Contains(@value));

        public static bool StartsWithAny(this string @this, IList<string> values) => values.Any(@value => @this.StartsWith(@value));
        public static bool EndsWithAny(this string @this, IList<string> values)   => values.Any(@value => @this.EndsWith(@value));

        public static bool SurroundedBy(this string @this, string @value)                      => @this.StartsWith(@value)     && @this.EndsWith(@value);
        public static bool SurroundedBy(this string @this, string startValue, string endValue) => @this.StartsWith(startValue) && @this.EndsWith(endValue);
        public static bool SurroundedByAny(this string @this, IList<string> values) => values.Any(@value => @this.StartsWith(@value) && @this.EndsWith(@value));

        public static string DefaultIfEmpty(this string @this, string @default)             => String.IsNullOrEmpty(@this)      ? @default : @this;
        public static string DefaultIfEmptyOrWhitespace(this string @this, string @default) => String.IsNullOrWhitespace(@this) ? @default : @this;

        public static string? NullIfEmpty(this string @this)             => String.IsNullOrEmpty(@this)      ? null : @this;
        public static string? NullIfEmptyOrWhitespace(this string @this) => String.IsNullOrWhitespace(@this) ? null : @this;

        #region IndexOf variant that can default to a more useful value than -1.

        public static enum DefaultIndex
        {
            Zero,
            StartIndex,
            EndIndex,
            Length,
        }

        private static int ResolveDefaultIndex(string @string, string @value, DefaultIndex @default) => @default switch
        {
            DefaultIndex.Zero       => 0,
            DefaultIndex.StartIndex => 0,
            DefaultIndex.EndIndex   => @string.Length,
            DefaultIndex.Length     => @string.Length,
        };

        private static int ResolveDefaultIndex(string @string, string @value, int startIndex, DefaultIndex @default) => @default switch
        {
            DefaultIndex.Zero       => 0,
            DefaultIndex.StartIndex => startIndex,
            DefaultIndex.EndIndex   => @string.Length,
            DefaultIndex.Length     => @string.Length,
        };

        private static int ResolveDefaultIndex(string @string, string @value, int startIndex, int count, DefaultIndex @default) => @default switch
        {
            DefaultIndex.Zero       => 0,
            DefaultIndex.StartIndex => startIndex,
            DefaultIndex.EndIndex   => startIndex + count,
            DefaultIndex.Length     => @string.Length,
        };

        #region IndexOrDefault

        public static int IndexOrDefault(this string @this, string @value, DefaultIndex @default)
        {
            int index = @this.IndexOf(@value);
            return index != -1 ? index : ResolveDefaultIndex(@this, @value, @default);
        }

        public static int IndexOrDefault(this string @this, string @value, DefaultIndex @default, StringComparison comparisonType)
        {
            int index = @this.IndexOf(@value, comparisonType);
            return index != -1 ? index : ResolveDefaultIndex(@this, @value, @default);
        }

        public static int IndexOrDefault(this string @this, string @value, int startIndex, DefaultIndex @default)
        {
            int index = @this.IndexOf(@value, startIndex);
            return index != -1 ? index : ResolveDefaultIndex(@this, @value, startIndex, @default);
        }

        public static int IndexOrDefault(this string @this, string @value, int startIndex, DefaultIndex @default, StringComparison comparisonType)
        {
            int index = @this.IndexOf(@value, startIndex, comparisonType);
            return index != -1 ? index : ResolveDefaultIndex(@this, @value, startIndex, @default);
        }

        public static int IndexOrDefault(this string @this, string @value, int startIndex, int count, DefaultIndex @default)
        {
            int index = @this.IndexOf(@value, startIndex, count);
            return index != -1 ? index : ResolveDefaultIndex(@this, @value, startIndex, count, @default);
        }

        public static int IndexOrDefault(this string @this, string @value, int startIndex, int count, DefaultIndex @default, StringComparison comparisonType)
        {
            int index = @this.IndexOf(@value, startIndex, count, comparisonType);
            return index != -1 ? index : ResolveDefaultIndex(@this, @value, startIndex, count, @default);
        }

        #endregion

        #region LastIndexOrDefault

        public static int LastIndexOrDefault(this string @this, string @value, DefaultIndex @default)
        {
            int index = @this.LastIndexOf(@value);
            return index != -1 ? index : ResolveDefaultIndex(@this, @value, @default);
        }

        public static int LastIndexOrDefault(this string @this, string @value, DefaultIndex @default, StringComparison comparisonType)
        {
            int index = @this.LastIndexOf(@value, comparisonType);
            return index != -1 ? index : ResolveDefaultIndex(@this, @value, @default);
        }

        public static int LastIndexOrDefault(this string @this, string @value, int startIndex, DefaultIndex @default)
        {
            int index = @this.LastIndexOf(@value, startIndex);
            return index != -1 ? index : ResolveDefaultIndex(@this, @value, startIndex, @default);
        }

        public static int LastIndexOrDefault(this string @this, string @value, int startIndex, DefaultIndex @default, StringComparison comparisonType)
        {
            int index = @this.LastIndexOf(@value, startIndex, comparisonType);
            return index != -1 ? index : ResolveDefaultIndex(@this, @value, startIndex, @default);
        }

        public static int LastIndexOrDefault(this string @this, string @value, int startIndex, int count, DefaultIndex @default)
        {
            int index = @this.LastIndexOf(@value, startIndex, count);
            return index != -1 ? index : ResolveDefaultIndex(@this, @value, startIndex, count, @default);
        }

        public static int LastIndexOrDefault(this string @this, string @value, int startIndex, int count, DefaultIndex @default, StringComparison comparisonType)
        {
            int index = @this.LastIndexOf(@value, startIndex, count, comparisonType);
            return index != -1 ? index : ResolveDefaultIndex(@this, @value, startIndex, count, @default);
        }

        #endregion

        #endregion

        #region Substring operations

        #region SubstringStart

        // This method will throw if there is more length requested than is available.
        public static string SubstringStart(this string @this, int length) => @this.Substring(0, length);

        // This method will return the entire input string (i.e. `@this`) without error if more length is requested than is available.
        public static string SubstringStartOrFull(this string @this, int length) => length > @this.Length ? @this : @this.Substring(0, length);

        // This method will return the entire input string (i.e. `@this`) without error if more length is requested than is available.
        // This method will return null if the requested length is negative.
        public static string? TrySubstringStart(this string @this, int length)
        {
            if (length < 0)
            {
                return null;
            }
            else if (length <= @this.Length)
            {
                return @this.Substring(0, length);
            }
            else
            {
                return @this;
            }
        }
        #endregion

        #region SubstringEnd

        // This method will throw if there is more length requested than is available.
        public static string SubstringEnd(this string @this, int length) => @this.Substring(@this.Length - length, length);

        // This method will return the entire input string (i.e. `@this`) without error if more length is requested than is available.
        public static string SubstringEndOrFull(this string @this, int length) => length > @this.Length ? @this : @this.Substring(@this.Length - length, length);

        // This method will return the entire input string (i.e. `@this`) without error if more length is requested than is available.
        // This method will return null if the requested length is negative.
        public static string? TrySubstringEnd(this string @this, int length)
        {
            if (length < 0)
            {
                return null;
            }
            else if (length <= @this.Length)
            {
                return @this.Substring(@this.Length - length, length);
            }
            else
            {
                return @this;
            }
        }
        #endregion

        public static enum DefaultSubstring
        {
            EmptyString,
            FullString,
        }

        private static string ResolveDefaultSubstring(string @string, DefaultSubstring @default) => @default switch
        {
            DefaultSubstring.EmptyString => String.Empty,
            DefaultSubstring.FullString  => @string,
        };

        #region These methods will throw an exception if the value does not exist.
        public static string SubstringBeforeFirst(this string @this, string @value, bool includeValue = false)
        {
            int index = @this.IndexOf(@value);
            if (index != -1)
            {
                return @this.Substring(0, index + (includeValue ? @value.Length : 0));
            }
            else
            {
                throw new ArgumentOutOfRangeException(ValueNotFoundErrorMessage);
            }
        }

        public static string SubstringAfterFirst(this string @this, string @value, bool includeValue = false)
        {
            int index = @this.IndexOf(@value);
            if (index != -1)
            {
                return @this.Substring(index + (includeValue ? 0 : @value.Length));
            }
            else
            {
                throw new ArgumentOutOfRangeException(ValueNotFoundErrorMessage);
            }
        }
        #endregion

        #region These methods will return null if the value does not exist.
        public static string? TrySubstringBeforeFirst(this string @this, string @value, bool includeValue = false)
        {
            int index = @this.IndexOf(@value);
            if (index != -1)
            {
                return @this.Substring(index + (includeValue ? @value.Length : 0));
            }
            else
            {
                return null;
            }
        }

        public static string? TrySubstringAfterFirst(this string @this, string @value, bool includeValue = false)
        {
            int index = @this.IndexOf(@value);
            if (index != -1)
            {
                return @this.Substring(index + (includeValue ? 0 : @value.Length));
            }
            else
            {
                return null;
            }
        }
        #endregion

        #region This methods will return a user-specified default (either the empty string or the original input string, i.e. `@this`) if the value does not exist.
        public static string SubstringBeforeFirstOrDefault(this string @this, string @value, bool includeValue = false, DefaultSubstring @default = DefaultSubstring.EmptyString)
        {
            int index = @this.IndexOf(@value);
            if (index != -1)
            {
                return @this.Substring(index + (includeValue ? 0 : @value.Length));
            }
            else
            {
                return ResolveDefaultSubstring(@this, @default);
            }
        }

        public static string SubstringAfterFirstOrDefault(this string @this, string @value, bool includeValue = false, DefaultString @default = DefaultSubstring.EmptyString)
        {
            int index = @this.IndexOf(@value);
            if (index != -1)
            {
                return @this.Substring(index + (includeValue ? 0 : @value.Length));
            }
            else
            {
                return ResolveDefaultSubstring(@this, @default);
            }
        }
        #endregion

        #region These methods will throw an exception if the value does not exist.
        // TODO standardize
        public static string SubstringBeforeLast(this string @this, string @value, bool includeValue = false)
                => @this.Substring(0, @this.LastIndexOf(@value) + (includeValue ? @value.Length : 0));
        public static string SubstringAfterLast(this string @this, string @value, bool includeValue = false)
                => @this.Substring(@this.LastIndexOf(@value) + (includeValue ? 0 : @value.Length));
        #endregion

        #region These methods will return null if the value does not exist.
        // TODO refactor
        public static string? TrySubstringBeforeLast(this string @this, string @value) => TryElse(() => @this.Substring(0, @this.LastIndexOf(@value)),              null);  // TODO includeValue parameter and logic
        public static string? TrySubstringAfterLast(this string @this, string @value)  => TryElse(() => @this.Substring(@this.LastIndexOf(@value) = @value.Length), null);  // TODO includeValue parameter and logic
        #endregion

        #region This methods will return a user-specified default (either the empty string or the original input string, i.e. `@this`) if the value does not exist.
        // TODO
        #endregion

        #endregion

        #region Argument Validators

        private static void CheckArgumentRangeZero(int argument, string argumentName)
        {
            if (!(0 <= argument))
            {
                throw new ArgumentOutOfRangeException("{0} is less than 0 (zero).", argumentName);
            }
        }

        private static void CheckArgumentRangeLength(int argument, string argumentName, int length, string lengthName)
        {
            if (!(argument <= length))
            {
                throw new ArgumentOutOfRangeException("{0} is greater than the length of {1}.", argumentName, lengthName);
            }
        }


        //------

        private static void CheckStartIndex(this string @this, int startIndex)
        {
            CheckArgumentRangeZero(startIndex, nameof(startIndex));
            CheckArgumentRangeLength(startIndex, nameof(startIndex), @this.Length, "this string");
        }

        private static void CheckStartIndexCount(this string @this, int startIndex, int count)
        {
            CheckArgumentRangeZero(startIndex, nameof(startIndex));
            CheckArgumentRangeZero(count, nameof(count));

            CheckArgumentRangeLength(startIndex, nameof(startIndex), @this.Length, "this string");
            CheckArgumentRangeLength(count, nameof(count), @this.Length - startIndex, $"this string minus {nameOf(startIndex)}");
        }

        private static string ValueNotFoundErrorMessage = "value was not found in this string.";

        #endregion
    }
}
