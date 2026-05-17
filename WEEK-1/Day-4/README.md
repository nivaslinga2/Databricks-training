# Day 4 – Window Functions and CTEs

## Overview
Day 4 focuses on advanced SQL concepts using the `employees` and `orders` tables. This practice set covers window functions, ranking, running totals, analytical queries, and Common Table Expressions (CTEs).

## Topics Covered
- `ROW_NUMBER()`
- `RANK()` and `DENSE_RANK()`
- `PARTITION BY`
- Running totals with `SUM() OVER()`
- `LAG()` and `LEAD()`
- Moving averages
- `NTILE()`
- CTEs
- Recursive CTEs

## Tables Used
- `employees` – used for salary analysis, ranking, and department-based calculations
- `orders` – used for order analysis, cumulative sales, and customer trends

## Query Breakdown
| Query Range | Concept |
|------------|---------|
| 1–6 | Ranking and department-wise salary analysis |
| 7–11 | Running totals, `LAG()`, and `LEAD()` |
| 12–13 | Moving average and `NTILE()` |
| 14–20 | Order analysis, payroll, percentages, and averages |
| 21–24 | CTEs and recursive CTEs |
| 25 | Employee hierarchy using recursive CTE |

## Learning Goals
- Understand window functions for row-wise analysis
- Perform ranking and partition-based calculations
- Build running totals and comparison-based queries
- Use CTEs to simplify complex SQL
- Learn recursive CTEs for hierarchical problems

## Files
- `README.md` – Day summary and concepts
- `Schema` – Table creation and sample data
- `Query.sql` – Practice queries
