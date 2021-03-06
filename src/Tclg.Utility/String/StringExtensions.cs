#nullable enable

using System;
using System.Collections.Generic;

namespace Tclg.PowerShell.Utility
{
	public static partial class StringExtensions
	{
		#region Add

		public static string Prepend(this string @this, string value)
				=> value + @this;

		public static string PrependLine(this string @this, string value = String.Empty)
				=> String.Concat(value, Environment.NewLine, @this);

		public static string PrependLines(this string @this, IList<string> values)
				=> (values.Count == 0) ? @this : String.Concat(String.Join(Environment.NewLine, values), Environment.NewLine, @this);

		// Value is prepended to this string if and only if this string does not already start with value.
		public static string AddPrefix(this string @this, string value)
				=> @this.StartsWith(value) ? @this : (value + @this);

		// Prepends the concatenation of value and Environment.NewLine this string if and only if this string does not already start with value.
		public static string AddPrefixLine(this string @this, string value)
				=> @this.StartsWith(value) ? @this : String.Concat(value, Environment.NewLine, @this);

		public static string Append(this string @this, string value)
				=> @this + value;

        public static string AppendLine(this string @this, string value = String.Empty)
                => String.Concat(@this, Environment.NewLine, value);

		public static string AppendLines(this string @this, IList<string> values)
				=> (values.Count == 0) ? @this : String.Concat(@this, Environment.NewLine, String.Join(Environment.NewLine, values));

        // Value is appended to this string if and only if this string does not already end with value.
        public static string AddSuffix(this string @this, string value)
				=> @this.EndsWith(value) ? @this : (@this + value);

        // Environment.NewLine and value are appended to this string if and only if this string does not already end with value.
        public static string AddSuffixLine(this string @this, string value)
				=> @this.EndsWith(value) ? @this : String.Concat(@this, Environment.NewLine, value);

		#endregion

		#region Remove

		// Removes all non-overlapping instances of value from this string.
		// If value is the empty string, then nothing is removed (this string is returned unchanged).
		// If value does not exist in this string, then nothing is removed (this string is returned unchanged).
		public static string Remove(this string @this, string value)
				=> (value.Length == 0) ? @this : @this.Replace(value, "");

        // Removes nothing (returns this string unchanged) if the value does not exist in this string.
        public static string RemoveFirst(this string @this, string value)
		{
			int index = @this.IndexOf(value);
			return index == -1 ? @this : @this.Remove(index, value.Length);
		}

        // Removes nothing (returns this string unchanged) if the value does not exist in this string.
        public static string RemoveBeforeFirst(this string @this, string value)
		{
			int index = @this.IndexOf(value);
			return index == -1 ? @this : @this.Substring(index);
		}

        // Removes nothing (returns this string unchanged) if the value does not exist in this string.
        public static string RemoveAfterFirst(this string @this, string value)
		{
			int index = @this.IndexOf(value);
			return index == -1 ? @this : @this.Substring(0, index + value.Length);
		}

        // Removes nothing (returns this string unchanged) if the value does not exist in this string.
        public static string RemoveLast(this string @this, string value)
		{
			int index = @this.LastIndexOf(value);
			return index == -1 ? @this : @this.Remove(index, value.Length);
		}

        // Removes nothing (returns this string unchanged) if the value does not exist in this string.
        public static string RemoveBeforeLast(this string @this, string value)
		{
			int index = @this.LastIndexOf(value);
			return index == -1 ? @this : @this.Substring(index);
		}

        // Removes nothing (returns this string unchanged) if the value does not exist in this string.
        public static string RemoveAfterLast(this string @this, string value)
		{
			int index = @this.LastIndexOf(value);
			return index == -1 ? @this : @this.Substring(0, index + value.Length);
		}

        // Removes nothing (returns this string unchanged) if this string does not start with the value.
        public static string RemovePrefix(this string @this, string value)
				=> @this.StartsWith(value) ? @this.Substring(value.Length) : @this;

		// Removes nothing (returns this string unchanged) if this string does not end with the value.
		public static string RemoveSuffix(this string @this, string value)
				=> @this.EndsWith(value) ? @this.Substring(0, @this.Length - value.Length) : @this;

		// Clamps the length to the range [0, @this.Length] prior to removing that length.
        public static string RemoveHead(this string @this, int length)
                => @this.Substring(Math.Clamp(length, 0, @this.Length));

        // Clamps the length to the range [0, @this.Length] prior to removing that length.
        public static string RemoveTail(this string @this, int length)
                => @this.Substring(0, @this.Length - Math.Clamp(length, 0, @this.Length));

        #endregion

        #region Replace

        // If count is negative, then nothing is replaced (this string is returned unchanged).
        // Otherwise, the region to be replaced is identified by [startIndex, startIndex + count).
        // If the region has zero length and startIndex is a valid index of this string, then newValue is inserted at startIndex.
        // If the region has positive length but neither overlaps with nor is adjacent to this string, then nothing is replaced.
        // If the region has positive length and does not overlap with this string but is adjacent to it, then newValue is inserted at the boundary.
        // If the region has positive length and overlaps with this string, then the overlapping region is replaced with newValue.
        public static string Replace(this string @this, int startIndex, int count, string newValue)
		{
			if (count < 0 || startIndex > @this.Length)
			{
				return @this;
			}

			if (startIndex < 0)
			{
				count += startIndex;  // Adding a negative startIndex is actually subtraction.
				startIndex = 0;
			}
			count = Math.Min(count, @this.Length - startIndex);

			return @this.Substring(0, startIndex) + newValue + @this.Substring(startIndex + count);
		}

        // Replaces nothing (returns this string unchanged) if the value does not exist in this string.
        public static string ReplaceFirst(this string @this, string oldValue, string newValue)
		{
			int index = @this.IndexOf(oldValue);
			return index == -1 ? @this : (@this.Substring(0, index) + newValue + @this.Substring(index + oldValue.Length));
		}

        // Replaces nothing (returns this string unchanged) if the value does not exist in this string.
        public static string ReplaceBeforeFirst(this string @this, string value, string newValue)
		{
			int index = @this.IndexOf(value);
			return index == -1 ? @this : (newValue + @this.Substring(index));
		}

        // Replaces nothing (returns this string unchanged) if the value does not exist in this string.
        public static string ReplaceAfterFirst(this string @this, string value, string newValue)
		{
			int index = @this.IndexOf(value);
			return index == -1 ? @this : (@this.Substring(0, index + value.Length) + newValue);
		}

        // Replaces nothing (returns this string unchanged) if the value does not exist in this string.
        public static string ReplaceLast(this string @this, string oldValue, string newValue)
        {
            int index = @this.LastIndexOf(oldValue);
            return index == -1 ? @this : (@this.Substring(0, index) + newValue + @this.Substring(index + oldValue.Length));
        }

        // Replaces nothing (returns this string unchanged) if the value does not exist in this string.
        public static string ReplaceBeforeLast(this string @this, string value, string newValue)
		{
			int index = @this.LastIndexOf(value);
			return index == -1 ? @this : (newValue + @this.Substring(index));
		}

        // Replaces nothing (returns this string unchanged) if the value does not exist in this string.
        public static string ReplaceAfterLast(this string @this, string value, string newValue)
		{
			int index = @this.LastIndexOf(value);
			return index == -1 ? @this : (@this.Substring(0, index + value.Length) + newValue);
		}

        // Replaces nothing (returns this string unchanged) if this string does not start with the oldValue.
        public static string ReplacePrefix(this string @this, string oldValue, string newValue)
				=> @this.StartsWith(oldValue) ? (newValue + @this.Substring(oldValue.Length)) : @this;

        // Replaces nothing (returns this string unchanged) if this string does not end with the oldValue.
        public static string ReplaceSuffix(this string @this, string oldValue, string newValue)
				=> @this.EndsWith(oldValue) ? (@this.Substring(0, @this.Length - oldValue.Length) + newValue) : @this;

        // Clamps the length to the range [0, @this.Length] prior to replacing that length.
		// If the length to replace is 0, then the newValue is always prepended to this string.
		// If the length of this string is 0 and the length to replace is positive, then nothing is replaced (this string is returned unchanged).
        public static string ReplaceHead(this string @this, int length, string newValue)
				=>	(length <= 0) ? (newValue + @this) :
					(@this.Length == 0) ? String.Empty :
					(newValue + @this.Substring(Math.Min(length, @this.Length)));

        // Clamps the length to the range [0, @this.Length] prior to replacing that length.
        // If the length to replace is 0, then the newValue is always appended to this string.
        // If the length of this string is 0 and the length to replace is positive, then nothing is replaced (this string is returned unchanged).
        public static string ReplaceTail(this string @this, int length, string newValue)
                => (length <= 0) ? (@this + newValue) :
                    (@this.Length == 0) ? String.Empty :
                    (@this.Substring(0, @this.Length - Math.Min(length, @this.Length)) + newValue);

		#endregion

		#region Substring

		// If value does not occur in this string, then the empty string is returned.
		// If value is the empty string, then the empty string is returned.
		public static string SubstringBeforeFirst(this string @this, string value)
		{
			int index = @this.IndexOf(value);
			return index == -1 ? String.Empty : @this.Substring(0, index);
		}

        // If value does not occur in this string, then the empty string is returned.
        // If value is the empty string, then this entire string is returned.
        public static string SubstringAfterFirst(this string @this, string value)
		{
			int index = @this.IndexOf(value);
			return index == -1 ? String.Empty : @this.Substring(index + value.Length);
		}

        // If value does not occur in this string, then the empty string is returned.
        // If value is the empty string, then this entire string is returned.
        public static string SubstringBeforeLast(this string @this, string value)
		{
			int index = @this.LastIndexOf(value);
			return index == -1 ? String.Empty : @this.Substring(0, index);
		}

        // If value does not occur in this string, then the empty string is returned.
        // If value is the empty string, then the empty string is returned.
        public static string SubstringAfterLast(this string @this, string value)
		{
            int index = @this.LastIndexOf(value);
			return index == -1 ? String.Empty : @this.Substring(index + value.Length);
		}

		// If length is non-positive, then the empty string is returned.
		// If length is longer than this string, then this entire string is returned.
        public static string Head(this string @this, int length)
				=> @this.Substring(0, Math.Clamp(length, 0, @this.Length));

        // If length is non-positive, then the empty string is returned.
        // If length is longer than this string, then this entire string is returned.
        public static string Tail(this string @this, int length)
				=> @this.Substring(@this.Length - Math.Clamp(length, 0, @this.Length));

		#endregion
	}
}
