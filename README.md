<<<<<<< HEAD
# Task 5: SQL Joins (Inner, Left, Right, Full)

## 🎯 Objective
Practice combining data across tables using different JOIN types and patterns on the e-commerce schema.

## 🧰 Tools
- MySQL Workbench

## 📚 What’s Covered
- `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`
- **FULL OUTER JOIN (emulated via `LEFT JOIN UNION RIGHT JOIN`)**
- Multi-table joins (Orders ↔ OrderItems ↔ Products ↔ Users)
- `NATURAL JOIN` (for learning), `CROSS JOIN`
- Finding unmatched rows (e.g., users with no orders)

## 🗂 Files
- `task5_joins.sql` — all join queries for Task 5

## ❓ Interview Q&A (quick)
- **INNER vs LEFT JOIN?** INNER returns only matching rows; LEFT returns all from left + matches on right, NULL when no match.  
- **FULL OUTER JOIN?** Returns all rows from both sides; unmatched become NULL. MySQL: emulate via `LEFT JOIN UNION RIGHT JOIN`.  
- **Nested joins / join >2 tables?** Yes, chain multiple `JOIN` clauses.  
- **Cross join?** Cartesian product of two tables (use `LIMIT`).  
- **Natural join?** Joins on all same-named columns automatically (risky; prefer explicit `ON`).  
- **Join without FK?** Yes; FK not required — just a join condition.  
- **Self join?** Join a table to itself (e.g., hierarchical categories).  
- **Cartesian product cause?** Missing/incorrect join condition or using `CROSS JOIN`.  
- **Optimize joins?** Index join keys, select only needed columns, filter early, check `EXPLAIN`.

## ✅ Outcome
Mastery of merging data with SQL joins and understanding behavior of different join types.
=======
# task-5-sql-joins
SQL join examples (INNER, LEFT, RIGHT, FULL via UNION), multi-table joins, NATURAL/CROSS joins, and join interview Q&amp;A on an e-commerce schema.
>>>>>>> 2a87d16b1936802668d9a42589acc805ac42f51a
