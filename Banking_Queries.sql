-- BANKING MANAGEMENT ASSIGNMENT	

use SQL_Assignments;

-- Customer Table

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50) NOT NULL,
    PhoneNo BIGINT,
    City VARCHAR(50),
    AccountType VARCHAR(20),
    AccountNo INT
);

-- Accounts Table

CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY,
    CustomerID INT,
    Balance bigint,
    OpenDate DATE,

    FOREIGN KEY (CustomerID) 
    REFERENCES Customers(CustomerID)
);

-- Transactions Table

CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY,
    AccountID INT,
    TransactionType VARCHAR(20),
    Amount bigint,
    TransactionDate DATE,

    FOREIGN KEY (AccountID) 
    REFERENCES Accounts(AccountID)
);

-- Loan Table

CREATE TABLE Loans (
    LoanID INT PRIMARY KEY,
    CustomerID INT,
    LoanAmount bigint,
    LoanType VARCHAR(50),

    FOREIGN KEY (CustomerID)
    REFERENCES Customers(CustomerID)
);

-- Insert Data into Tables

INSERT INTO Customers VALUES
(1, 'Rahul Sharma', 9876543210, 'Pune', 'Savings', 1001),
(2, 'Sneha Patil', 9988776655, 'Mumbai', 'Current', 1002),
(3, 'Aman Verma', 9123456780, 'Nagpur', 'Savings', 1003),
(4, 'Priya Singh', 9012345678, 'Delhi', 'Current', 1004),
(5, 'Karan Mehta', 9871203456, 'Hyderabad', 'Savings', 1005),
(6, 'Neha Joshi', 9988001122, 'Pune', 'Current', 1006),
(7, 'Rohit Kumar', 9765432109, 'Bangalore', 'Savings', 1007),
(8, 'Pooja Sharma', 9876540001, 'Chennai', 'Savings', 1008),
(9, 'Vivek Shah', 9001122334, 'Ahmedabad', 'Current', 1009),
(10, 'Anjali Verma', 9988771100, 'Jaipur', 'Savings', 1010);

select * from Customers;

INSERT INTO Accounts (AccountID, CustomerID, Balance, OpenDate) VALUES
(1001, 1, 55000, '2025-01-10'),
(1002, 2, 120000, '2024-11-20'),
(1003, 3, 35000, '2025-03-15'),
(1004, 4, 98000, '2025-02-01'),
(1005, 5, 75000, '2025-01-25'),
(1006, 6, 150000, '2024-12-18'),
(1007, 7, 42000, '2025-04-10'),
(1008, 8, 88000, '2025-05-05'),
(1009, 9, 200000, '2024-09-30'),
(1010, 10, 67000, '2025-03-22');

select * from Accounts;

INSERT INTO Transactions (TransactionID, AccountID, TransactionType, Amount, TransactionDate) VALUES
(1, 1001, 'Deposit', 10000, '2026-06-01'),
(2, 1001, 'Withdraw', 5000, '2026-06-02'),
(3, 1002, 'Deposit', 25000, '2026-06-02'),
(4, 1003, 'Withdraw', 3000, '2026-06-03'),
(5, 1004, 'Deposit', 15000, '2026-06-04'),
(6, 1005, 'Deposit', 12000, '2026-06-05'),
(7, 1006, 'Withdraw', 7000, '2026-06-05'),
(8, 1007, 'Deposit', 9000, '2026-06-06'),
(9, 1008, 'Withdraw', 4500, '2026-06-06'),
(10, 1009, 'Deposit', 30000, '2026-06-07'),
(11, 1010, 'Withdraw', 2000, '2026-06-07'),
(12, 1002, 'Withdraw', 10000, '2026-06-08'),
(13, 1003, 'Deposit', 5000, '2026-06-08'),
(14, 1005, 'Withdraw', 3500, '2026-06-09'),
(15, 1007, 'Deposit', 15000, '2026-06-09');

select * from Transactions;

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, LoanType) VALUES
(1, 1, 500000, 'Home Loan'),
(2, 2, 200000, 'Car Loan'),
(3, 4, 100000, 'Education Loan'),
(4, 5, 300000, 'Business Loan'),
(5, 6, 150000, 'Personal Loan'),
(6, 8, 250000, 'Home Loan'),
(7, 9, 400000, 'Business Loan'),
(8, 10, 180000, 'Car Loan');

select * from Loans;

-- Practice Questions

-- 1.Display customer names, account numbers, and account balances using INNER JOIN.

select c.CustomerName , a.AccountID , a.Balance 
from Accounts a  
inner join Customers c on a.CustomerID = c.CustomerID; 

-- 2. Find the top 3 customers with the highest account balances.

select top (3) c.CustomerName , a.Balance 
from Accounts a  
inner join Customers c on a.CustomerID = c.CustomerID
order by Balance desc;

-- 3. Show all customers who have taken loans along with loan amount and loan type.

select c.CustomerName ,  l.LoanAmount , l.LoanType
from Loans l 
left join Customers c on l.CustomerID = c.CustomerID;

-- 4. Find the total deposited amount and total withdrawn amount separately.

select TransactionType, sum(Amount) as Total
from Transactions
group by TransactionType;

-- 5. Display customer-wise total transaction amount using GROUP BY.

select c.CustomerName , sum(t.Amount) as Total_Amount 
from Transactions t 
join Accounts a on t.AccountID = a.AccountID
join Customers c on a.CustomerID = c.CustomerID
group by c.CustomerName;

-- 6. Find customers whose balances are greater than the average bank balance.

select c.CustomerName , a.Balance
from Accounts a
join Customers c on a.CustomerID = c.CustomerID
where a.Balance > (select avg(Balance) from Accounts);

-- 7. Show the highest transaction amount performed by each customer.

select c.CustomerName , Max(t.Amount) as Highest_Amount 
from Transactions t 
join Accounts a on t.AccountID = a.AccountID
join Customers c on a.CustomerID = c.CustomerID
group by c.CustomerName;

-- 8. Display all customers who have not taken any loans using LEFT JOIN.

select c.CustomerName
from Customers c
left join Loans l on l.CustomerID = c.CustomerID
where l.LoanAmount is null;

-- 9. Find the total number of transactions performed by each customer.

select c.CustomerName , count(t.AccountID) as No_of_Transaction 
from Transactions t 
join Accounts a on t.AccountID = a.AccountID
join Customers c on a.CustomerID = c.CustomerID
group by c.CustomerName;

-- 10. Rank customers based on their account balances using RANK() window function.

select c.CustomerName , a.Balance ,
rank() over(order by a.Balance desc) as Rank_Number
from Accounts a 
join Customers c on a.CustomerID = c.CustomerID;

-- 11. Display dense ranking of customers according to balance using DENSE_RANK()

select c.CustomerName , a.Balance ,
dense_rank() over(order by a.Balance desc) as Dense_Rank_No
from Accounts a 
join Customers c on a.CustomerID = c.CustomerID;

-- 12. Show previous transaction amount using LAG() function.

select TransactionID , AccountID , Amount ,TransactionType,
lag(Amount,1,0) over(partition by AccountID order by TransactionDate) as Previous_Amount
from Transactions;

-- 13. Show next transaction amount using LEAD() function

select TransactionID , AccountID , Amount ,TransactionType,
lead(Amount,1,0) over(partition by AccountID order by TransactionDate) as Next_Amount
from Transactions;

-- 14. Calculate running total of transaction amounts using SUM() OVER().

select TransactionID, AccountID, TransactionType, Amount,
sum(Amount) over(partition by AccountID order by TransactionDate) as Running_Total
from Transactions;

-- 15. Find the second highest account balance using subquery or window function

select max(Balance) as Second_Highest_Balance
from Accounts
where Balance < (select max(Balance) from Accounts);

             -- OR --
select * 
from(select AccountID ,Balance, c.CustomerName ,
    DENSE_RANK() over(order by Balance desc) as Rnk 
    from Accounts a
    join Customers c on a.CustomerID = c.CustomerID
    ) as ranked
where Rnk = 2;

-- 16. Find customers who performed more than 2 transactions.

select * 
from(select c.CustomerID, c.CustomerName ,
    DENSE_RANK() over(partition by c.CustomerID order by TransactionDate) as No_of_Transaction
    from Transactions t 
    join Accounts a on t.AccountID = a.AccountID
    join Customers c on a.CustomerID = c.CustomerID
    ) as RankedData
where No_of_Transaction = 2;

-- 17. Display customer-wise minimum and maximum transaction amounts.

select c.CustomerName , min(t.Amount) as Min_Amount , max(t.Amount) as Max_Amount
from Customers c 
join Accounts a on c.CustomerID = a.CustomerID
join Transactions t on a.AccountID = t.AccountID
group by c.CustomerName       
order by Max_Amount desc; 

----------  END ------------

