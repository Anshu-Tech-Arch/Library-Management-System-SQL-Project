CREATE DATABASE Library;
USE Library;
CREATE TABLE Branch(
	Branch_id varchar(20) Primary key,
    Manager_id varchar(20),
	Branch_address varchar(30),
    Contact_no varchar(20)
);
CREATE TABLE Books(
	Book_id varchar(20) primary key,
    Book_title varchar(50) not null,
    Category varchar(30),
    Rental_price decimal(10,2),
	Status enum('Yes', 'No'),
    Author varchar(30),
    Publisher varchar(50)
);
CREATE TABLE Customers(
	Customer_id int primary key auto_increment,
    Customer_name varchar(50),
    Customer_address VARCHAR(30),
    Reg_date DATE
);
CREATE TABLE Employee(
	Employee_id int primary key auto_increment,
    Employee_name varchar(50) not null, 
    Employee_role varchar(30),
    Employee_salary decimal(10,2),
    Employee_branch varchar(20),
    Foreign key (Employee_branch) references Branch(Branch_id)
);
CREATE TABLE IssueStatus(
	Issue_id int primary key auto_increment,
    Customer_id int not null,
    Book_id varchar(20) not null ,
    Issue_date date not null,
    Foreign key (Customer_id) references Customers(Customer_id),
    Foreign key (Book_id) references Books(Book_id)
);
ALTER TABLE Books MODIFY Status ENUM('Available', 'Issued', 'Not Available');
CREATE TABLE ReturnStatus(
    Return_id int primary key auto_increment,
    Issue_id int not null,
    Return_date date not null,
    Foreign key (Issue_id) references IssueStatus(Issue_id)
);
ALTER TABLE Books MODIFY Status ENUM('Available', 'Issued');
INSERT INTO Branch (Branch_id, Manager_id, Branch_address, Contact_no)
VALUES
('B001', 'M101', 'Dwarka Sector 6', '+919876543210'),
('B002', 'M102', 'Janakpuri', '+919876543211'),
('B003', 'M103', 'Rohini Sector 9', '+919876543212'),
('B004', 'M104', 'Pitampura', '+919876543213'),
('B005', 'M105', 'Rajouri Garden', '+919876543214');

INSERT INTO Books
(Book_id, Book_title, Category, Rental_price, Status, Author, Publisher)
VALUES
('BK101','The Alchemist','Fiction',30,'Available','Paulo Coelho','HarperOne'),
('BK102','Atomic Habits','Self Help',40,'Issued','James Clear','Penguin'),
('BK103','Rich Dad Poor Dad','Finance',35,'Available','Robert Kiyosaki','Plata'),
('BK104','Harry Potter','Fantasy',50,'Issued','J.K. Rowling','Bloomsbury'),
('BK105','The Psychology of Money','Finance',45,'Available','Morgan Housel','Jaico'),
('BK106','Think and Grow Rich','Motivation',30,'Available','Napoleon Hill','Fingerprint'),
('BK107','Deep Work','Productivity',38,'Available','Cal Newport','Grand Central'),
('BK108','Clean Code','Programming',60,'Issued','Robert C. Martin','Prentice Hall');

INSERT INTO Customers
(Customer_name, Customer_address, Reg_date)
VALUES
('Ansh Poddar','Dwarka','2025-01-10'),
('Rahul Sharma','Janakpuri','2025-02-15'),
('Priya Verma','Uttam Nagar','2025-03-12'),
('Aman Gupta','Rohini','2025-04-08'),
('Sneha Kapoor','Pitampura','2025-05-21'),
('Riya Singh','Rajouri Garden','2025-06-02');

INSERT INTO Employee
(Employee_name, Employee_role, Employee_salary, Employee_branch)
VALUES
('Amit Kumar','Manager',65000,'B001'),
('Neha Sharma','Librarian',50000,'B001'),
('Rohan Mehta','Assistant',35000,'B002'),
('Karan Singh','Clerk',32000,'B003'),
('Pooja Verma','Assistant',36000,'B004'),
('Vikas Yadav','Manager',67000,'B005');

INSERT INTO IssueStatus
(Customer_id, Book_id, Issue_date)
VALUES
(1,'BK102','2026-07-01'),
(2,'BK104','2026-07-02'),
(3,'BK108','2026-07-03');

INSERT INTO ReturnStatus
(Issue_id, Return_date)
VALUES
(1,'2026-07-10'),
(2,'2026-07-11');
Select * from Books where status='Available'; 
Select Book_title, Author, Rental_price from Books where status='Available';
Select Employee_name, Employee_role, Employee_salary from Employee order by Employee_salary DESC;
Select Category, count(*) from Books group by Category;
Select Category from books group by Category having count(*)>2;
Select Customers.Customer_name, Books.book_title from Customers Inner join IssueStatus on Customers.Customer_id=IssueStatus.Customer_id Inner join Books on IssueStatus.book_id=Books.book_id;
SELECT Customers.Customer_name
FROM Customers
LEFT JOIN IssueStatus
ON Customers.Customer_id = IssueStatus.Customer_id
WHERE IssueStatus.Customer_id IS NULL;
select Employee_branch, sum(Employee_salary) from Employee group by Employee_branch;
select Employee_branch, avg(Employee_salary) from Employee group by Employee_branch;
select 
max(Employee_salary), 
min(Employee_salary) 
from Employee;
select 
Employee_name 
from 
Employee 
where 
Employee_salary>(Select avg(Employee_salary) from Employee);
SELECT e.Employee_name, e.Employee_salary, e.Employee_branch
FROM Employee AS e
WHERE e.Employee_salary >(SELECT AVG(Employee_salary) FROM Employee WHERE Employee_branch = e.Employee_branch);
