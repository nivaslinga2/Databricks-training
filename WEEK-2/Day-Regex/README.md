# 🚀 SQL Regex Practice

## 📌 What This Covers
- Regex pattern matching with `^` (start) and `$` (end)
- Character sets `[]` and quantifiers `+`, `{n}`
- Extracting numbers, letters, email parts, phone parts
- Using `SUBSTRING()` with regex patterns

---

## 🗂️ Table: `regex_practice`

| Column | Description |
|--------|-------------|
| `id` | Record ID |
| `full_text` | Mixed structured text |
| `email` | Email address |
| `phone` | Phone number |
| `mixed_value` | Alphanumeric mixed string |

---

## 📚 Key Regex Patterns

| Pattern | Meaning |
|---------|---------|
| `^` | Start of string |
| `$` | End of string |
| `[0-9]+` | One or more digits |
| `[A-Za-z]+` | One or more letters |
| `[^@]+` | One or more non-@ characters |
| `.{n}` | Exactly n characters |
| `()` | Capturing group |

---

## 🔑 Essential Queries

### Extract leading numbers
```sql
SELECT SUBSTRING(mixed_value FROM '^[0-9]+') AS extracted_number
FROM regex_practice;
```

### Extract trailing numbers
```sql
SELECT SUBSTRING(mixed_value FROM '[0-9]+$') AS extracted_number
FROM regex_practice;
```

### Extract email username (before @)
```sql
SELECT SUBSTRING(email FROM '^[^@]+') AS username
FROM regex_practice;
```

### Extract email domain (after @)
```sql
SELECT SUBSTRING(email FROM '@(.+)$') AS domain_name
FROM regex_practice;
```

### Extract country code from phone
```sql
SELECT SUBSTRING(phone FROM '^\\+([0-9]+)') AS country_code
FROM regex_practice;
```

### Extract first/last characters
```sql
SELECT SUBSTRING(full_text FROM '^.') AS first_char,
       SUBSTRING(full_text FROM '.$') AS last_char
FROM regex_practice;
```

### Extract exactly 2 digits
```sql
SELECT SUBSTRING(mixed_value FROM '[0-9]{2}') AS consecutive_digits
FROM regex_practice;
```

---

## 📝 Quick Reference

| Task | Pattern |
|------|---------|
| Leading digits | `^[0-9]+` |
| Trailing digits | `[0-9]+$` |
| Letters only | `[A-Za-z]+` |
| Before @ | `^[^@]+` |
| After @ | `@(.+)$` |
| First 3 chars | `^.{3}` |
| Last 2 chars | `.{2}$` |
| Country code | `^\\+([0-9]+)` |

---

## 🎯 Study Focus
- Understand `^` vs `$` anchors
- Practice `[0-9]` vs `[A-Za-z]` character sets
- Learn `+` (one or more) vs `{n}` (exact count)
- Use capturing groups `()` to extract specific parts
- Remember to escape special chars: `\\+`, `\\.`
