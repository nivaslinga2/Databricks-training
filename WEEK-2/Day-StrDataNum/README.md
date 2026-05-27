# 🚀 StrDataNum SQL

## 📌 Overview
SQL functions for string, date, numeric operations, CASE statements, and real-world analytics.

Used for:
✅ String Functions  
✅ Date Functions  
✅ Numeric Functions  
✅ CASE Statements  
✅ Business Reporting  

---

## 🔤 String Functions

| Function | Purpose | Example |
|----------|---------|---------|
| `upper()` | Uppercase | `upper('Tarun')` → `TARUN` |
| `lower()` | Lowercase | `lower('TARUN')` → `tarun` |
| `initcap()` | Capitalize words | `initcap('nunna tarun')` → `Nunna Tarun` |
| `length()` | Character count | `length('Tarun')` → `5` |
| `left()` | Left characters | `left('Tarun',3)` → `Tar` |
| `right()` | Right characters | `right('Tarun',2)` → `un` |
| `concat()` | Combine strings | `concat('Nunna',' ','Tarun')` → `Nunna Tarun` |
| `split_part()` | Split by delimiter | `split_part('n@gmail.com','@',2)` → `gmail.com` |

---

## 📅 Date Functions

| Function | Purpose | Example |
|----------|---------|---------|
| `current_date` | Today's date | `current_date` → `2026-05-18` |
| `extract()` | Get year/month/day | `extract(year from current_date)` → `2026` |
| `age()` | Date difference | `age(current_date,'2020-01-01')` → `6 years` |
| `interval` | Add/subtract time | `current_date + interval '7 days'` |
| `to_char()` | Format date/number | `to_char(current_date,'Month')` → `May` |

---

## 🔢 Numeric Functions

| Function | Purpose | Example |
|----------|---------|---------|
| `round()` | Round decimals | `round(125.678,2)` → `125.68` |
| `trunc()` | Truncate decimals | `trunc(125.678,1)` → `125.6` |
| `floor()` | Round down | `floor(125.99)` → `125` |
| `ceil()` | Round up | `ceil(125.01)` → `126` |
| `mod()` | Remainder | `mod(10,3)` → `1` |
| `abs()` | Absolute value | `abs(-500)` → `500` |

---

## 🧠 CASE Statement

```sql
CASE
    WHEN condition THEN result
    WHEN condition THEN result
    ELSE result
END
```

**Example:**
```sql
SELECT emp_name, salary,
       CASE
           WHEN salary > 80000 THEN 'High'
           WHEN salary > 50000 THEN 'Medium'
           ELSE 'Low'
       END AS salary_category
FROM employees;
```

---

## 🔑 Essential Queries

### String Example
```sql
SELECT upper(emp_name), lower(emp_name), initcap(emp_name), length(emp_name)
FROM employees;
```

### Date Example
```sql
SELECT current_date, extract(year FROM current_date), to_char(current_date,'Day');
```

### Numeric Example
```sql
SELECT round(salary), trunc(salary,1), floor(salary), ceil(salary)
FROM employees;
```

### CASE Example
```sql
SELECT emp_name, salary,
       CASE
           WHEN salary >= 90000 THEN 'Excellent'
           WHEN salary >= 60000 THEN 'Good'
           ELSE 'Average'
       END AS performance
FROM employees;
```

---

## 📈 Real-Time Use Cases

| Area | Use |
|------|-----|
| Employee Analytics | Attendance, performance, productivity |
| Financial Analysis | Salary audits, tax, EMI, revenue |
| Fraud Detection | Weekend transactions, suspicious credits |
| Date Analytics | Fiscal year, aging, monthly reports |
| Data Cleaning | NULL handling, formatting, standardization |

---

## 🎯 Study Focus
1. String formatting (`upper`, `lower`, `initcap`)
2. Text extraction (`left`, `right`, `split_part`)
3. Date calculations (`extract`, `age`, `interval`)
4. Numeric rounding (`round`, `floor`, `ceil`)
5. Conditional logic (`CASE`)
6. Real-world reporting queries

---

## 🛠️ Compatible With
- PostgreSQL
- MySQL
- Oracle SQL
- SQL Server
