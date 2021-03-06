# String Extensions

## Methods

### Predicates

#### Containment

- `ContainsAny(IList[string] substrings)`
- `ContainsAll(IList[string] substrings)`

#### Prefix/Suffix

- `StartsWithAny(IList[string] starts)`
- `EndsWithAny(IList[string] ends)`
- `SurroundedBy(string start, string end)`

### Finders

- `IndexOfLast(string substring)`
- `LastIndexOfLast(string substring)`

### Selectors

#### Default

- `DefaultIfEmpty(string default)`
- `DefaultIfEmptyOrWhitespace(string default)`

#### Substring

- `SubstringStart(int length)`
- `SubstringEnd(int length)`
- `SubstringBeforeFirst(string substring)`
- `SubstringBeforeFirstOrEnd(string substring)`
- `SubstringBeforeLast(string substring)`
- `SubstringBeforeLastOrEnd(string substring)`
- `SubstringFromFirst(string substring)`
- `SubstringFromFirstOrStart(string substring)`
- `SubstringFromLast(string substring)`
- `SubstringFromLastOrStart(string substring)`
- `SubstringThroughFirst(string substring)`
- `SubstringThroughFirstOrEnd(string substring)`
- `SubstringThroughLast(string substring)`
- `SubstringThroughLastOrEnd(string substring)`
- `SubstringAfterFirst(string substring)`
- `SubstringAfterFirstOrStart(string substring)`
- `SubstringAfterLast(string substring)`
- `SubstringAfterLastOrStart(string substring)`

### Mutators

#### Appenders

- `Append(string)`
- `AppendAll(IList[string])`
- `AppendLine(string)`
- `AppendLines(IList[string])`
- `AppendIfEndsWith(string)`
- `AppendIfEndsWith(string append, string end)`
- `AppendIfEndsWithAny(string append, IList[string] ends)`
- `AppendIfNotEndsWith(string)`
- `AppendIfNotEndsWith(string append, string end)`
- `AppendIfNotEndsWithAny(string append, IList[string] ends)`
- `AppendIfNotEmpty(string append)`
- `AppendIfNotEmptyOrWhitespace(string append)`

#### Prependers

- `Prepend(string)`
- `PrependAll(IList[string])`
- `PrependLine(string)`
- `PrependLines(IList[string])`
- `PrependIfStartsWith(string)`
- `PrependIfStartsWith(string prepend, string start)`
- `PrependIfStartsWithAny(string prepend, IList[string] starts)`
- `PrependIfNotStartsWith(string)`
- `PrependIfNotStartsWith(string prepend, string start)`
- `PrependIfNotStartsWithAny(string prepend, IList[string] starts)`
- `PrependIfNotEmpty(string prepend)`
- `PrependIfNotEmptyOrWhitespace(string prepend)`

#### Inserters

- `InsertAfterEach(string insertion, string substring)`
- `InsertAfterFirst(string insertion, string substring)`
- `InsertAfterFirstOrEnd(string insertion, string substring)`
- `InsertAfterLast(string insertion, string substring)`
- `InsertAfterLastOrEnd(string insertion, string substring)`
- `InsertBeforeEach(string insertion, string substring)`
- `InsertBeforeFirst(string insertion, string substring)`
- `InsertBeforeFirstOrStart(string insertion, string substring)`
- `InsertBeforeLast(string insertion, string substring)`
- `InsertBeforeLastOrStart(string insertion, string substring)`

#### Surrounders

- `Surround(string prepend, string append)`
- `SurroundIfNotEmpty(string prepend, string append)`
- `SurroundIfNotEmptyOrWhitespace(string prepend, string append)`

#### Removers

- `RemoveStart(int length)`
- `RemoveEnd(int length)`
- `Remove(string substring)`
- `RemoveStart(string start) // ...if starts with`
- `RemoveEnd(string end) // ...if ends with`
- `RemoveFirst(string substring)`
- `RemoveBeforeFirst(string substring)`
- `RemoveFromFirst(string substring)`
- `RemoveThroughFirst(string substring)`
- `RemoveAfterFirst(string substring)`
- `RemoveLast(string substring)`
- `RemoveBeforeLast(string substring)`
- `RemoveFromLast(string substring)`
- `RemoveThroughLast(string substring)`
- `RemoveAfterLast(string substring)`

##### Multi-Removers

- `RemoveAll(IList[string] substrings)`

#### Replacers

- `Replace(string startIndex, int count, string replacement)`
- `ReplaceStart(string start, string replacement) // ...if starts with`
- `ReplaceEnd(string end, string replacement) // ...if ends with`
- `ReplaceFirst(string substring, string replacement)`
- `ReplaceBeforeFirst(string substring, string replacement)`
- `ReplaceFromFirst(string substring, string replacement)`
- `ReplaceThroughFirst(string substring, string replacement)`
- `ReplaceAfterFirst(string substring, string replacement)`
- `ReplaceLast(string substring, string replacement)`
- `ReplaceBeforeLast(string substring, string replacement)`
- `ReplaceFromLast(string substring, string replacement)`
- `ReplaceThroughLast(string substring, string replacement)`
- `ReplaceAfterLast(string substring, string replacement)`

#### Multi-Replacers

- `ReplaceAll(IList[string] substrings, string replacement)`
- `ReplaceAll(IDictionary <string,string> replacements) </string,string>`
