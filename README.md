# SQL-Online-Bookstore-Analysis

SQL project that analyzes an online bookstore's books, customers, and orders using Microsoft SQL Server (T-SQL).

## Files
- `Books.csv` – book details (title, author, genre, price, stock)
- `Customers.csv` – customer details (name, email, city, country)
- `Orders.csv` – order records (customer, book, date, quantity, total amount)
- `OnlineBookstore_Analysis.sql` – table creation, data import, and analysis queries

## Database Structure
- **Books** (Book_ID, Title, Author, Genre, Published_Year, Price, Stock)
- **Customers** (Customer_ID, Name, Email, Phone, City, Country)
- **Orders** (Order_ID, Customer_ID, Book_ID, Order_Date, Quantity, Total_Amount)

`Orders` links to `Books` and `Customers` through foreign keys.

## SQL Concepts Used
`SELECT`, `WHERE`, `ORDER BY`, `GROUP BY`, `HAVING`, `JOIN`, `LEFT JOIN`, `DISTINCT`, `TOP`, `COALESCE`, and aggregate functions (`SUM`, `AVG`, `COUNT`)

## Questions Answered
**Basic:** filtering books by genre and year, customers by country, orders by date, total stock, most expensive book, lowest stock book, total revenue

**Advanced:**
- Total books sold per genre and per author
- Average price of Fantasy books and top 3 most expensive Fantasy books
- Customers with at least 2 orders
- Most frequently ordered book
- Cities of customers who spent over $30
- Customer who spent the most
- Remaining stock after fulfilling all orders

## How to Run
1. Create a database named `OnlineBookstore` in SQL Server
2. Download the three CSV files
3. In `OnlineBookstore_Analysis.sql`, update the file paths in the `BULK INSERT` statements to where the CSVs are saved on your computer
4. Run the script in SQL Server Management Studio
