-- foreign key constraints are intensionally omitted, must be added before use
drop database if exists Takeaway;
create database Takeaway;
use Takeaway;

create table FoodCategory (
    catId varchar(10) primary key,
    catName varchar(30)
);

create table FoodItem (
    itemId varchar(10) primary key,
    description varchar(30),
    catId varchar(10),
    unitPrice int
);
 
 create table Customer (
    custNo int primary key,
    name varchar(30)
);

create table FoodOrder (
    orderNo int primary key,
    custNo int
);

create table OrderLine (
    orderNo int,
    lineNo int,
    itemId varchar(10),
    quantity int,
    unitPrice int,
    primary key(orderNo, lineNo)
);

insert into FoodCategory values
    ("start", "Starters"),
    ("fish", "Fish dishes"),
    ("meat", "Meat dishes"),
    ("bev", "Beverages");

insert into Customer values 
    (1, "Peter Pan"),
    (2, "Daisy Duck"),
    (7, "James Bond");
    
insert into FoodItem values
    ("sroll", "Spring Rolls", "start", 45),
    ("sushi", "Sushi Menu", "fish", 65),
    ("bburg", "Big Burger", "meat", 100),
    ("nburg", "Normal Burger", "meat", 75);

insert into FoodOrder values
    (1, 1),
    (2, 1),
    (3, 7),
    (4, 7);

insert into OrderLine values
    (1, 1, "sroll", 2, 45),
    (1, 2, "nburg", 5, 75),
    (2, 1, "sushi", 1, 65),
    (2, 2, "nburg", 2, 75),  
    (3, 1, "nburg", 3, 75);
