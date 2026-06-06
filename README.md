# 🏦 SQL Mini Project – Banking Management System

## Overview
SQL queries solving 17 real-world banking problems using a 4-table schema:
Customers, Accounts, Transactions, Loans.

## Topics Covered
- INNER JOIN, LEFT JOIN
- GROUP BY, HAVING
- Aggregate functions (SUM, COUNT, MAX, MIN, AVG)
- Subqueries
- Window Functions: RANK(), DENSE_RANK(), LAG(), LEAD(), SUM() OVER()

## Schema
| Table        | Key Columns                          |
|--------------|--------------------------------------|
| Customers    | CustomerID, CustomerName, City       |
| Accounts     | AccountID, CustomerID, Balance       |
| Transactions | TransactionID, AccountID, Amount     |
| Loans        | LoanID, CustomerID, LoanAmount       |

## Tools Used
- Microsoft SQL Server / SQL Server Management Studio (SSMS)

## Author
Ashraful Ahmad | B.Tech CSE (Data Science & Analytics) | 
