CREATE DATABASE BookStoreDB;
USE BookStoreDB;

-- 1. Table for country
CREATE TABLE country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- 2. Table for address
CREATE TABLE address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    street VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20),
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);

-- 3. Table for address status
CREATE TABLE address_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL
);

-- 4. Table for customer
CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(20)
);

-- 5. Table for customer address
CREATE TABLE customer_address (
    customer_id INT,
    address_id INT,
    status_id INT,
    PRIMARY KEY (customer_id, address_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (status_id) REFERENCES address_status(status_id)
);

-- 6. Table for book language
CREATE TABLE book_language (
    language_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- 7. Table for publisher
CREATE TABLE publisher (
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- 8. Table for author
CREATE TABLE author (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL
);

-- 9. Table for book
CREATE TABLE book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    publication_year YEAR,
    price DECIMAL(5,2),
    publisher_id INT,
    language_id INT,
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id),
    FOREIGN KEY (language_id) REFERENCES book_language(language_id)
);

-- 10. Table for book_author (many-to-many)
CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
);

-- 11. Table for shipping method
CREATE TABLE shipping_method (
    shipping_method_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    cost DECIMAL(10,2)
);

-- 12. Table for order status
CREATE TABLE order_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL
);

-- 13. Table for cust_order
CREATE TABLE cust_order (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    shipping_method_id INT,
    status_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(shipping_method_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);

-- 14. Table for order_line
CREATE TABLE order_line (
    order_id INT,
    book_id INT,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2),
    PRIMARY KEY (order_id, book_id),
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

-- 15. Table for order_history
CREATE TABLE order_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    status_id INT,
    change_date DATE,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
    FOREIGN KEY (status_id) REFERENCES order_status(status_id)
);

-- Creating  roles
CREATE ROLE bookstore_client;
CREATE ROLE store_manager;
CREATE ROLE admin;

-- Grant privileges
GRANT SELECT ON BookStoreDB.* TO bookstore_client;
GRANT SELECT, INSERT, UPDATE ON BookStoreDB.cust_order TO store_manager;
GRANT ALL PRIVILEGES ON BookStoreDB.* TO admin;

-- Creating users and assigning them roles
CREATE USER 'bookstore_client'@'localhost' IDENTIFIED BY '123';
GRANT bookstore_client TO 'bookstore_client'@'localhost';

CREATE USER 'manager_user'@'localhost' IDENTIFIED BY '1234';
GRANT store_manager TO 'manager_user'@'localhost';

CREATE USER 'admin_user'@'localhost' IDENTIFIED BY '12345678';
GRANT admin TO 'admin_user'@'localhost';

-- Get all orders for customer with ID 1
SELECT order_id, order_date 
FROM cust_order 
WHERE customer_id = 1;


-- Index on customer_id 
CREATE INDEX idx_ordercustomer
ON cust_order(customer_id);

-- Index on title
CREATE INDEX idx_booktitle
ON book(title);

CREATE INDEX idx_book_author_bookid ON book_author(book_id);
CREATE INDEX idx_book_author_authorid ON book_author(author_id);

