USE OnlineBookstore;
GO
-- Drop existing tables in correct order
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Books;
GO

-- Create Books Table
CREATE TABLE Books (
    Book_ID INT IDENTITY(1,1) PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price DECIMAL(10,2),
    Stock INT
);
-- Create Customers Table
CREATE TABLE Customers (
    Customer_ID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);
-- Create Orders Table
CREATE TABLE Orders (
    Order_ID INT IDENTITY(1,1) PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount DECIMAL(10,2)
);
GO
SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;
BULK INSERT Books
FROM 'C:\Users\Dell\Downloads\SQL_Resume_Project-main\SQL_Resume_Project-main\Books.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    ROWTERMINATOR = '0x0a'
);

BULK INSERT Customers
FROM 'C:\Users\Dell\Downloads\SQL_Resume_Project-main\SQL_Resume_Project-main\Customers.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    ROWTERMINATOR = '0x0a'
);
BULK INSERT Orders
FROM 'C:\Users\Dell\Downloads\SQL_Resume_Project-main\SQL_Resume_Project-main\Orders.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    ROWTERMINATOR = '0x0a'
);

--1) Retrieve all books in the "Fiction" genre
SELECT * FROM Books
WHERE Genre='Fiction';

--2) Find books published after the year 1950:
SELECT * FROM Books
WHERE Published_Year>1950;

--3) List all customers from the Canada

SELECT *
FROM Customers
WHERE Country LIKE '%Canada%';

--4) Show orders placed in November 2023

SELECT * FROM Orders
WHERE Order_Date BETWEEN '2023-11-01' AND '2023-11-30';

--5) Retrieve the tota stock of books available:
SELECT SUM(Stock) AS Total_Stock FROM Books;

--6) Find the details of the most expensive book:
SELECT TOP 1* FROM Books ORDER BY Price DESC ;

--7) Show all customers who ordered more than 1 quantity of a book:
SELECT * FROM Orders WHERE Quantity>1;

--8) Retrieve all orders where the total amount exceeds $20:
SELECT * FROM Orders WHERE Total_Amount>20;

--9) List all genres available in the Books table:
SELECT DISTINCT Genre FROM Books ;

--10) Find the book with the lowest stock:
SELECT TOP 1* FROM Books ORDER BY Stock;

--11) Calculate the total revenue generated from all orders:
SELECT SUM(Total_Amount) AS Total_Revenue FROM Orders;

--Advance Questions:

--1) Retrieve the total number of books sold for each genre:
SELECT * FROM Orders;

SELECT b.Genre,SUM(o.Quantity) AS Total_Book_sold
FROM Orders o
JOIN Books b ON o.book_id=b.book_id
GROUP BY b.Genre;

--2) Find the average price of books in the "Fantasy" genre:
SELECT AVG(Price) AS Average_Price 
FROM Books 
WHERE Genre='Fantasy';

--3) List customers who have placed at least 2 orders:
SELECT o.Customer_ID, c.Name ,COUNT(o.Order_ID) AS ORDER_COUNT
FROM Orders o
JOIN Customers c ON o.Customer_ID=c.Customer_ID
GROUP BY o.Customer_ID,c.Name
HAVING COUNT(Order_ID)>=2;

--4) Find the most frequently ordered book:
SELECT TOP 1 o.Book_ID,b.Title,Count(o.Order_ID) AS ORDER_COUNT
FROM Orders o
JOIN Books b ON o.Book_ID=b.Book_ID
GROUP BY o.Book_ID,b.Title
ORDER BY ORDER_COUNT DESC;

--5) Show the top 3 most expensive books of 'Fantasy' Genre:
SELECT TOP 3 * FROM Books
WHERE Genre='Fantasy'
ORDER BY Price DESC;

--6) Retrieve the total quantity of books sold by each author:
SELECT b.Author, SUM(o.Quantity) AS Total_Books_Sold
FROM Orders o
JOIN Books b ON o.Book_ID=b.BOOK_ID
GROUP BY b.Author;

--7) List the cities where customers who spent over $30 are located:
SELECT DISTINCT c.City, Total_Amount
FROM Orders o
JOIN Customers c ON o.Customer_ID=c.Customer_ID
WHERE o.Total_Amount>30;

--8) Find the customer who spent the most on orders:
SELECT TOP 1 c.Customer_ID ,c.Name,SUM(o.Total_Amount) AS Total_Spent
FROM Orders o
JOIN Customers c ON o.Customer_ID=c.Customer_ID
GROUP BY c.Customer_ID,c.Name
ORDER BY Total_Spent DESC;

--9) Calculate the stock remaining after fulfilling all orders:
SELECT b.Book_ID,b.Title,b.Stock,COALESCE(SUM(o.Quantity),0) AS Order_Quantity,b.Stock-COALESCE(SUM(o.Quantity),0) AS Remaining_Quantity
FROM Books b
LEFT JOIN Orders o ON b.Book_ID=o.Book_ID
GROUP BY b.Book_ID,b.Title,b.Stock
ORDER BY b.Book_ID;