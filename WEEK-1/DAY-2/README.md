# Day 2 – SQL Employee Database Practice

## Overview
Day 2 focuses on practicing SQL using an `Employees` table with 55 queries covering filtering, aggregation, grouping, sorting, and pattern matching. [page:1]

## Topics Covered
- Basic `SELECT` queries. [page:1]  
- `WHERE` clause filtering. [page:1]  
- Aggregate functions: `SUM()`, `AVG()`, `COUNT()`, `MAX()`, `MIN()`. [page:1]  
- `GROUP BY` and `HAVING`. [page:1]  
- `ORDER BY` and `LIMIT`. [page:1]  
- `DISTINCT` usage. [page:1]  
- Comparison, logical, `IN`, `BETWEEN`, and `LIKE` operators. [page:1]  

## Employees Table Schema
| Column       | Data Type     |
|-------------|---------------|
| `emp_id`    | `INT`         |
| `emp_name`  | `VARCHAR(50)` |
| `department`| `VARCHAR(50)` |
| `salary`    | `INT`         |
| `city`      | `VARCHAR(50)` |
| `experience`| `INT`         | [page:1]

## Query Groups
| Query Range | Concept                      |
|------------|------------------------------|
| 1–10       | Basic `SELECT` and `WHERE`   |
| 11–20      | Aggregate functions          |
| 21–25      | `ORDER BY` and `LIMIT`       |
| 26–30      | `DISTINCT`                   |
| 31–35      | Comparison operators         |
| 36–40      | Logical operators            |
| 41–45      | `IN` and `NOT IN`            |
| 46–50      | `BETWEEN`                    |
| 51–55      | `LIKE` operator              | [page:1]

## Learning Goals
- Practice real-world SQL query writing on a single employee table. [page:1]  
- Understand how to filter and aggregate relational data. [page:1]  
- Build confidence for college labs and interview-style SQL questions. [page:1]  

## Folder Structure
- `README.md` – Concept summary and learning notes. [page:1]  
- `Schema` – Table creation and sample data. [page:1]  
- `Query.sql` – Full list of SQL practice questions and answers. [page:1]  

## Note
In Question 15, the requirement is “minimum experience department-wise”, so the correct query should use `MIN(experience)` instead of `MIN(salary)`. [page:1]
