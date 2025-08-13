
-- Task 5: Joins (Inner, Left, Right, Full), Multi-table, Natural, Cross


USE ECommerceDB;

-- Quick peek at data
SELECT COUNT(*) AS users FROM Users;
SELECT COUNT(*) AS products FROM Products;
SELECT COUNT(*) AS orders FROM Orders;
SELECT COUNT(*) AS order_items FROM OrderItems;
SELECT COUNT(*) AS payments FROM Payments;

-- 1) INNER JOIN: Users with their Orders (only users who placed orders)
SELECT u.UserID, u.Name, o.OrderID, o.OrderDate, o.Status
FROM Users u
INNER JOIN Orders o ON o.UserID = u.UserID
ORDER BY o.OrderDate;

-- 2) LEFT JOIN: All Categories, with Products if present (shows categories even if no products)
SELECT c.CategoryID, c.CategoryName, p.ProductID, p.Name AS ProductName
FROM Categories c
LEFT JOIN Products p ON p.CategoryID = c.CategoryID
ORDER BY c.CategoryName, p.ProductID;

-- 3) RIGHT JOIN: All Products with their Category (shows products even if category missing)
-- (RIGHT JOIN is supported in MySQL)
SELECT c.CategoryID, c.CategoryName, p.ProductID, p.Name AS ProductName
FROM Products p
RIGHT JOIN Categories c ON p.CategoryID = c.CategoryID
ORDER BY c.CategoryName, p.ProductID;

-- 4) FULL OUTER JOIN (MySQL doesn't support it directly)
-- Emulate FULL OUTER JOIN using LEFT JOIN UNION RIGHT JOIN (unmatched from right side)
-- This returns: all categories matched with products + categories without products + products without category
SELECT c.CategoryID, c.CategoryName, p.ProductID, p.Name AS ProductName
FROM Categories c
LEFT JOIN Products p ON p.CategoryID = c.CategoryID
UNION
SELECT c.CategoryID, c.CategoryName, p.ProductID, p.Name AS ProductName
FROM Categories c
RIGHT JOIN Products p ON p.CategoryID = c.CategoryID
WHERE c.CategoryID IS NULL
ORDER BY CategoryName;

-- 5) Multi-table JOIN: Order -> Items -> Product with Customer name
SELECT o.OrderID,
       u.Name      AS Customer,
       p.Name      AS Product,
       oi.Quantity,
       oi.Price,
       (oi.Quantity * oi.Price) AS LineTotal,
       o.OrderDate
FROM Orders o
JOIN Users u      ON u.UserID = o.UserID
JOIN OrderItems oi ON oi.OrderID = o.OrderID
JOIN Products p   ON p.ProductID = oi.ProductID
ORDER BY o.OrderID;

-- 6) Orders and Payments (all Orders even if payment missing) -> LEFT JOIN
SELECT o.OrderID, o.UserID, o.Status, p.PaymentID, p.Amount, p.PaymentMethod
FROM Orders o
LEFT JOIN Payments p ON p.OrderID = o.OrderID
ORDER BY o.OrderID;

-- 7) NATURAL JOIN example (joins on same-named columns automatically)
-- Orders and Payments both have OrderID. NATURAL JOIN uses that.
-- Note: avoid NATURAL JOIN in production; it's here for learning only.
SELECT o.UserID, p.Amount, p.PaymentMethod, o.OrderDate, o.Status
FROM Orders o
NATURAL JOIN Payments p;

-- 8) CROSS JOIN (Cartesian product) — use LIMIT to avoid explosion
SELECT u.Name AS UserName, c.CategoryName
FROM Users u
CROSS JOIN Categories c
LIMIT 10;

-- 9) Join without a declared FK (still valid): Users ↔ Orders on UserID
SELECT u.Name, o.OrderID, o.Status
FROM Users u
JOIN Orders o ON o.UserID = u.UserID
ORDER BY o.OrderID;

-- 10) RIGHT JOIN another example: ensure all payments are listed (even if order row is missing)
SELECT p.PaymentID, p.OrderID, o.Status, p.Amount
FROM Orders o
RIGHT JOIN Payments p ON p.OrderID = o.OrderID
ORDER BY p.PaymentID;

-- BONUS: Find users with NO orders (LEFT JOIN + NULL filter)
SELECT u.UserID, u.Name
FROM Users u
LEFT JOIN Orders o ON o.UserID = u.UserID
WHERE o.OrderID IS NULL;

-- BONUS: Categories that currently have NO products
SELECT c.CategoryID, c.CategoryName
FROM Categories c
LEFT JOIN Products p ON p.CategoryID = c.CategoryID
WHERE p.ProductID IS NULL;
