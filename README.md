# Group-Assignment-database
# Bookstore Database ERD

## 📚 Project Overview

This project involves designing an Entity Relationship Diagram (ERD) for a Bookstore Database System. The purpose of the ERD is to visualize and structure how data is organized and related within a bookstore management system, supporting common operations such as managing books, customers, orders, and payments.

## 📌 Objectives

- Design a normalized database structure for a bookstore.
- Identify and define key entities, attributes, and relationships.
- Establish clear primary and foreign key constraints.
- Visualize relationships including one-to-many and many-to-many associations.

## 🧩 Entities and Attributes

1. **Books**
   - BookID (Primary Key)
   - Title
   - ISBN
   - Price
   - Publisher
   - YearPublished

2. **Customers**
   - CustomerID (Primary Key)
   - FullName
   - Email
   - Phone
   - Address

3. **Orders**
   - OrderID (Primary Key)
   - CustomerID (Foreign Key)
   - OrderDate
   - TotalAmount

4. **OrderItems** *(Junction Table for many-to-many)*
   - OrderItemID (Primary Key)
   - OrderID (Foreign Key)
   - BookID (Foreign Key)
   - Quantity

5. **Payments**
   - PaymentID (Primary Key)
   - OrderID (Foreign Key)
   - PaymentDate
   - Amount
   - PaymentMethod

## 🔁 Relationships

- A customer can place many orders (1:N).
- An order can include multiple books, and a book can be part of many orders (M:N), implemented via the `OrderItems` table.
- Each order has one or more payment records (1:N).

## Tools Used

- ERD creation tool: [dbdiagram.io](https://dbdiagram.io)
- Database model concepts: MySQL-based relational design


#README description, with help from chatgpt
