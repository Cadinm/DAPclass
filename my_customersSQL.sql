drop database if exists my_customers;
create database my_customers;
use my_customers;

create table Department(
	DepartmentID varchar(3) primary key,
    Department_Name varchar(45),
    Sales_Meeting_Date date
);

create table Rep(
	RepID int primary key auto_increment,
    Rep_Name varchar(120),
    Quota float(7,2),
    DepartmentID varchar(3),
    foreign key (DepartmentID) references Department(DepartmentID)
);

create table Customer (
	CustomerID int primary key auto_increment,
    Customer_Name varchar(45),
    Contact varchar(45),
    Contact_Phone varchar(45)
);

create table Sales (
	CustomerID int,
    RepID int,
    YTD_Sales float(7,2),
    primary key (CustomerID, RepID),
    foreign key (CustomerID) references Customer(CustomerID),
    foreign key (RepID) references Rep(RepID)
);

