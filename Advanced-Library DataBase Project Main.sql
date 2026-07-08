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


