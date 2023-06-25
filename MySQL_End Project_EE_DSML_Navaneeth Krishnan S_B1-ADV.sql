create database library;
use library;

CREATE TABLE Branch (
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(255),
    Contact_no VARCHAR(255)
);

INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no) VALUES
(1, 101, 'Kozhikode', '1234567890'),
(2, 102, 'Ernakulam', '2345678901'),
(3, 103, 'Trivandrum', '3456789012'),
(4, 104, 'Kollam', '4567890123'),
(5, 105, 'Wayanad', '5678901234'),
(6, 106, 'Thrissur', '6789012345');
select * from Branch;

CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(255),
    Position VARCHAR(255),
    Salary INT
);

INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary) VALUES
(1, 'John', 'Manager', 100000),
(2, 'Jane', 'Assistant Manager', 80000),
(3, 'Bob', 'Developer', 60000),
(4, 'Alice', 'Developer', 60000),
(5, 'Charlie', 'QA Engineer', 50000),
(6, 'David', 'QA Engineer', 50000);
select * from Employee;

CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(255),
    Customer_address VARCHAR(255),
    Reg_date DATE
);

INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date) VALUES
(1, 'John', 'Aluva', '2022-01-01'),
(2, 'Jane', 'Kottarakara', '2022-01-02'),
(3, 'Bob', 'Vadakara', '2022-01-03'),
(4, 'Alice', 'East_fort', '2022-01-04'),
(5, 'Charlie', 'Aluva', '2022-01-05'),
(6, 'David', 'Guruvayoor', '2022-01-06');
UPDATE Customer SET Reg_date = '2021-01-01' WHERE Customer_Id = 1;
INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date) VALUES (7, 'Hari', 'Guruvayoor', '2021-03-06');
INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date) VALUES (8, 'Akshay', 'Haripad', '2021-05-10');
desc Customer;
select * from Customer;

CREATE TABLE Books (
    ISBN BIGINT PRIMARY KEY,
    Book_title VARCHAR(255),
    Category VARCHAR(255),
    Rental_Price DECIMAL(10,2),
    Status ENUM('yes', 'no'),
    Author VARCHAR(255),
    Publisher VARCHAR(255)
);

INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher) VALUES
(1234567890123, 'Book1', 'Category1', 10.00, 'yes', 'Author1', 'Publisher1'),
(2345678901234, 'Book2', 'Category2', 20.00, 'no', 'Author2', 'Publisher2'),
(3456789012345, 'Book3', 'Category3', 30.00, 'yes', 'Author3', 'Publisher3'),
(4567890123456, 'Book4', 'Category4', 40.00, 'no', 'Author4', 'Publisher4'),
(5678901234567, 'Book5', 'Category5', 50.00, 'yes', 'Author5', 'Publisher5'),
(6789012345678, 'Book6', 'Category6', 60.00, 'no', 'Author6', 'Publisher6');
desc Books;
select * from Books;

CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(255),
    Issue_date DATE,
    Isbn_book BIGINT,
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);

INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book) VALUES
(1, 1, 'Book1', '2022-01-01', 1234567890123),
(2, 2, 'Book2', '2022-01-02', 2345678901234),
(3, 3, 'Book3', '2022-01-03', 3456789012345),
(4, 4, 'Book4', '2022-01-04', 4567890123456),
(5, 5, 'Book5', '2022-01-05', 5678901234567),
(6, 6, 'Book6', '2022-01-06', 6789012345678);
desc IssueStatus;
select * from IssueStatus;

CREATE TABLE ReturnStatus (
    Return_Id INT NOT NULL,
    Return_cust VARCHAR(255),
    Return_book_name VARCHAR(255),
    Return_date DATE,
    Isbn_book2 BIGINT,
    PRIMARY KEY (Return_Id),
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);

INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2) VALUES
(1,'John','The Alchemist','2023-06-25',1234567890123),
(2,'Jane','The Da Vinci Code','2023-06-26',2345678901234),
(3,'Bob','The Catcher in the Rye','2023-06-27',3456789012345),
(4,'Alice','The Great Gatsby','2023-06-28',4567890123456),
(5,'Charlie','The Hobbit','2023-06-29',5678901234567),
(6,'David','The Lord of the Rings','2023-06-30',6789012345678);
desc ReturnStatus;
select * from ReturnStatus;

-- Queries --

-- 1. Retrieves the book title, category, and rental price of all available books --
select Book_title,Category,Rental_price from Books where Status='Yes';

-- 2. Lists the employee names and their respective salaries in descending order of salary --
select Emp_name, Salary from employee order by Salary desc;

-- 3. Retrieve the book titles and the corresponding customers who have issued those books --
SELECT issuestatus.Issued_book_name, customer.Customer_name FROM issuestatus INNER JOIN
customer on issuestatus.Issued_cust = customer.Customer_Id;

-- 4. Displays the total count of books in each category --
SELECT Category, COUNT(Book_title) FROM books GROUP BY Category;

-- 5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000. --
select Emp_name, Position, Salary from employee where Salary>50000;

/* 6. Lists the customer names who registered before 2022-01-01 and have not issued any books yet */
SELECT Customer_name FROM customer WHERE Reg_date < '2022-01-01' AND Customer_Id NOT IN
(SELECT Issued_cust FROM issuestatus);

-- 7. Displays the branch numbers and the total count of employees in each branch --
-- adding branch_no column in employee table --
ALTER TABLE employee ADD COLUMN branch_no INT;
ALTER TABLE employee ADD CONSTRAINT FOREIGN KEY (branch_no) REFERENCES branch(branch_no);
UPDATE employee SET branch_no = 1 WHERE emp_id =1;
UPDATE employee SET branch_no = 2 WHERE emp_id =2;
UPDATE employee SET branch_no = 3 WHERE emp_id =3;
UPDATE employee SET branch_no = 4 WHERE emp_id =4;
UPDATE employee SET branch_no = 5 WHERE emp_id =5;
UPDATE employee SET branch_no = 6 WHERE emp_id =6;
select * from employee;
SELECT branch_no, COUNT(emp_id) FROM employee GROUP BY branch_no;
SELECT Position, COUNT(*) FROM employee GROUP BY Position;
SELECT branch_no, COUNT(Position) FROM employee GROUP BY branch_no;

-- 8. Display the names of customers who have issued books in the month of June 2023 --
select customer.Customer_name from customer join issuestatus on customer.Customer_Id = issuestatus.Issued_cust 
where issuestatus.Issue_date > '2023-06-01' and issuestatus.Issue_date <= '2023-06-30';
-- if issue status was for the month of January 2022 query will be --
select customer.Customer_name from customer join issuestatus on customer.Customer_Id = issuestatus.Issued_cust 
where issuestatus.Issue_date > '2022-01-01' and issuestatus.Issue_date <= '2022-01-31';

-- 9. Retrieves book_title from book table containing history --
UPDATE books SET Category = 'History' WHERE ISBN = 1234567890123;
select * from books;
SELECT book_title FROM books WHERE Category = 'History';

-- 10. Retrieves the branch numbers along with the count of employees for branches having more than 5 employees --
select * from employee;
SELECT * FROM employee WHERE Position IN (
    SELECT Position FROM employee GROUP BY Position HAVING COUNT(*) > 5
);
select * from employee;
-- if count of employees in a branch is greater than one --
SELECT * FROM employee WHERE Position IN (
    SELECT Position FROM employee GROUP BY Position HAVING COUNT(*) > 1
);

-- The End --