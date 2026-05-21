# SQL Joins (Databricks SQL)

## What is a JOIN?

A `JOIN` in SQL is used to combine rows from two or more tables based on a related column (for example, a primary key in one table and a foreign key in another). Joins let us query normalized tables together as if they were one logical dataset.

## Common JOIN Types

- **INNER JOIN**  
  Returns only the rows that have matching values in both tables.

- **LEFT (OUTER) JOIN**  
  Returns all rows from the left table and the matching rows from the right table. Non-matching rows on the right side show `NULL` for right-table columns.

- **RIGHT (OUTER) JOIN**  
  Returns all rows from the right table and the matching rows from the left table. Non-matching rows on the left side show `NULL` for left-table columns.

- **FULL (OUTER) JOIN**  
  Returns all rows that appear in either table. Where there is no match on one side, the columns from that side are `NULL`.

- **CROSS JOIN**  
  Returns the Cartesian product of the two tables (every row from table A combined with every row from table B).

- **SELF JOIN (concept)**  
  A table joined with itself (using aliases) to compare or relate rows within the same table, such as employees and their managers.

## Why are JOINs useful? (Advantages)

- Combine related data from multiple normalized tables in a single query.
- Leverage database/Databricks optimizations for joining large datasets efficiently.
- Keep query logic clear and declarative instead of doing manual joins in application code.
- Choose the appropriate join type (INNER, LEFT, FULL, etc.) to control whether unmatched rows are kept or discarded.

## Typical Applications

- Reporting and analytics: Joining fact tables (orders, clicks, transactions) with dimension tables (customers, products, dates) to power dashboards.
- Data enrichment: Enhancing a main dataset with additional attributes from lookup or dimension tables (for example, joining user activity with user profile data).
- Data quality and reconciliation: Using FULL OUTER JOIN to identify rows present in one dataset but missing in another.
- Real-world examples:
  - Customers ↔ Orders to calculate revenue, order count, and customer lifetime value.
  - Products ↔ Sales to analyze top-selling products by category, region, or time.
  - Logs ↔ Reference data (IP-to-location, device tables, etc.) for observability and monitoring.

## Notes for Databricks

In Databricks SQL, these join types follow the standard SQL syntax:

```sql
SELECT ...
FROM tableA a
JOIN tableB b
  ON a.key = b.key;
```

You can use `INNER`, `LEFT`, `RIGHT`, `FULL`, `CROSS`, and `NATURAL` joins as needed, and Databricks will choose an appropriate physical join strategy (such as hash join or sort-merge join) based on the data and query plan.
