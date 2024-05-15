#Drop database if exists Smecompany;

Create database smecompany;

use Smecompany;

create table customer(
SN int primary key not null,
Name varchar (50) not null,
Email varchar (50)not null, 
Phone_number varchar(15),  #it is better not to save phone numbers as int
Address varchar (30) not null
);

alter table customer
rename customers;

#Drop table customers; 
Select*from customers;

insert into customers values (1, 'Temi', 'Temi@gmail.com', '8022334455','55 Ayoope house,Kempe');
insert into customers values (2, 'Titi', 'Titi@gmail.com', '8033445566', '52 Ayodele house,Kempe');
insert into customers values (3, 'Teni', 'Teni@gmail.com', '8044556677', '57 Ayomide house,Kempe');
insert into customers values (4, 'Toni', 'Toni@gmail.com', '8055667788', '50 Ayoola house,Kempe');
insert into customers values (5, 'Tomi', 'Tomi@gmail.com', '8066778899', '89 Ayoeni house,Kempe');
insert into customers values (6, 'Tedi', 'Tedi@gmail.com', '8011223344', '9 Ayotiwa house,Kempe');
insert into customers values (7, 'Tegi', 'Tegi@gmail.com', '8012345678', '30 Ayotara house,Kempe');
insert into customers values (8, 'Tari', 'Tari@gmail.com', '8023456789', '90 Ayoilu house,Kempe');
insert into customers values (9, 'Tami', 'Tami@gmail.com', '8000112233', '5 Ayoife house,Kempe');
insert into customers values (10, 'Tara', 'Tara@gmail.com','8087654321', '28 Ayoomo house,Kempe');
insert into customers (sn, name, email, address) values(11, 'Tide', 'Tara@gmail.com', '28 Ayoomo house,Kempe');
insert into customers (sn, name, email, address) values(12, 'Tora', 'Tora@gmail.com', '11 Ayoomo house,Kempe'), (13, 'Temi', 'Temi@gmail.com', '111 Ayoomo house,Kempe');
insert into customers values (14, 'Tori', 'Tori@gmail.com', '8000112233', '5 Ayoife house,Kempe'), (15, 'Tadi', 'Tadi@gmail.com', '8000112233', '5 Ayoife house,Kempe');

Select*from customers;
update customers set name='Chidi' where sn=3;
update customesrs set email='Chidi@gmail.com' where sn=3;

delete from customers where sn=4;
truncate table customers;

alter table customers add State varchar(20);
update customers set State='kebbi';
update customers set State='kogi' where sn=2;

alter table customers
drop column state;

select *from customers where sn=13;
select name, email from customers where sn<13;
select sn, name, email from customers where sn<>13;
select * from customers where name in ('titi', 'tami', 'tari');

select * from customers where Phone_number is null;
select * from customers where Phone_number is not null;

select * from customers where name like 'to%';
select * from customers where name like '%i';
select * from customers where name not like '%i';
select * from customers where name like '%tom%';
select sn, name, Phone_number from smecompany.customers where phone_number is not null order by sn desc;

create table orders(
Order_id int primary key not null, 
Order_date date not null, 
Total_amount int not null,
Customer_id int not null,
foreign key (customer_id) references customer (sn)
);

insert into orders values (001, '2020-12-31', 5000, 1);
insert into orders values (002, '2018-11-21', 8000, 2);
insert into orders values (003, '2022-03-11', 7000, 3);
insert into orders values (004, '2024-09-05', 6000, 4);
insert into orders values (005, '2020-08-15', 9000, 5);
insert into orders values (006, '2009-01-12', 3000, 6);
insert into orders values (007, '2020-05-13', 2000, 7);
insert into orders values (008, '2021-07-19', 1000, 8);
insert into orders values (009, '2023-11-30', 2500, 9);
insert into orders values (010, '2020-12-01', 4000, 10);
insert into orders values (011, '2020-02-01', 9000, 11), (012, '2022-04-01', 4500, 12);

select * from orders;
select * from orders limit 4;
select * from orders limit 4, 3;
select total_amount from orders where Customer_id >=6;
select total_amount, order_date from orders where Customer_id >=6 order by order_date desc;
select customer_id, total_amount, total_amount *10 as 'Increase' from orders where total_amount >=4000 order by Customer_id desc;

select * from orders where Order_date >= '2019-01-01' and Total_amount > 4000;
select * from orders where total_amount between 2000 and 6000;
select * from orders where Order_date >= '2018-01-01' or Total_amount > 4000;
select * from orders where not (Order_date >= '2018-01-01' and Total_amount > 4000);
select Order_date, avg(Total_amount) as Average from orders group by Order_date;

select Order_id, Total_amount,
case when total_amount >=6000 then 'Big Customer'
when total_amount between 2000 and 5999 then 'Medium customer'
else 'normal customer'
end as scale
from smecompany.orders where Order_date >= '2013-01-01'  order by Order_date desc;

select sn, email, Order_date, Total_amount,
case when total_amount >= 8000 then total_amount - (total_amount * 0.10)
when total_amount between 4000 and 7999 then total_amount - (total_amount * 0.08)
else total_amount - (total_amount * 0.05)
end as Discount
from smecompany.customers join smecompany.orders on smecompany.customers.SN= smecompany.orders.Customer_id order by discount;

select Total_amount, count(Total_amount) 
from smecompany.customers join smecompany.orders on smecompany.customers.SN= smecompany.orders.Customer_id 
group by Total_amount having count(Total_amount)>1;

select name, avg(Total_amount) 
from smecompany.customers join smecompany.orders on smecompany.customers.SN= smecompany.orders.Customer_id 
group by name having avg(Total_amount)> 7000 order by avg(Total_amount);

select Customer_id, Name, Order_date, Total_amount,
count(total_amount) over (partition by total_amount) as Amount
from smecompany.customers join smecompany.orders on smecompany.customers.SN= smecompany.orders.Customer_id;

with cte_customers as (select Customer_id, Name, Order_date, Total_amount,
count(total_amount) over (partition by total_amount) as Amount
from smecompany.customers join smecompany.orders on smecompany.customers.SN= smecompany.orders.Customer_id)
select name, total_amount from cte_customers;

select * from smecompany.customers join smecompany.orders on smecompany.customers.SN= smecompany.orders.Customer_id;
select Customer_id, name, Order_date, Total_amount from smecompany.customers join smecompany.orders on smecompany.customers.SN= smecompany.orders.Customer_id;
select * from smecompany.customers left join smecompany.orders on smecompany.customers.SN= smecompany.orders.Customer_id;
select * from smecompany.customers right join smecompany.orders on smecompany.customers.SN= smecompany.orders.Customer_id;
select * from smecompany.customers left join smecompany.orders on smecompany.customers.SN= smecompany.orders.Customer_id union select * from smecompany.customers right join smecompany.orders on smecompany.customers.SN= smecompany.orders.Customer_id;
select * from smecompany.customers left join smecompany.orders on smecompany.customers.SN= smecompany.orders.Customer_id union all select * from smecompany.customers right join smecompany.orders on smecompany.customers.SN= smecompany.orders.Customer_id;

create table Products (
Product_id int primary key, 
Product_name varchar(30),
Unit_price int, 
Quantity_available int, 
Category_id int,
foreign key (category_id) references orders (customer_id)
);

insert into products values (201, 'Bag', 50, 20, 1);
insert into products values (202, 'Trouser', 60, 200, 1);
insert into products values (203, 'Necklace', 100, 30, 1);
insert into products values (204, 'Chair', 500, 70, 2);
insert into products values (205, 'Table', 450, 80, 2);
insert into products values (206, 'Bed', 750, 40, 2);
insert into products values (207, 'Spoon', 20, 50, 3);
insert into products values (208, 'Plate', 10, 80, 3);
insert into products values (209, 'Cup', 25, 20, 3);
insert into products values (210, 'Knife', 15, 200, 3),(211, 'Earrings', 60, 50, 1), (212, 'Blanket', 550, 20, 2);

select * from products;
select * from products where Category_id =3;
select * from products where Product_name regexp 'ba';
select * from products where Product_name regexp 'ha|^b';
select * from products where Product_name regexp '[thl]a';
select * from products where Product_name regexp '[a-h]a' order by Product_name desc, Quantity_available desc;
select * from products where Product_name regexp 'ba|cha' order by Category_id desc;
select avg (unit_price) from products;
select category_id, count(Category_id) from products where Product_id >205 group by Category_id;

select Product_id, unit_price, avg(unit_price) over ()as Average  from products;
select Product_id, unit_price, (select avg(unit_price) as Average from products)from products;
select Product_id, unit_price from products;
create table  Employee(
 Employee_id int primary key not null, 
 Employee_name varchar(30)not null, 
 Title varchar(30) not null,
 Hire_date date not null
);

alter table employee
rename employees;

insert into employees values (20, 'James', 'Manager', '2018-09-09');
insert into employees values (21, 'Jaime', 'Technician', '2018-09-09');
insert into employees values (22, 'Johnson','Analyst', '2018-07-07');
insert into employees values (23, 'Jons', 'Marketer', '2018-09-09');
insert into employees values (24, 'John', 'Nurse', '2013-08-09');
insert into employees values (25, 'Jaire','Cleaner', '2018-09-09');
insert into employees values (26, 'Jerry','Logistics', '2011-12-04');
insert into employees values (27, 'Jumoke','Manager', '2018-01-07');
insert into employees values (28, 'Jade','Marketer', '2013-07-09');
insert into employees values (29, 'Jada','Engineer', '2012-02-02');
insert into employees values (30, 'Jada','Sales', '2018-10-09'), (31, 'Jude', 'Analyst', '2012-09-04'), (32, 'Jemmey','Support', '2010-10-09');

select * from Employees;
select distinct (title) from employees;
select count(title) from employees;  #no spacing between count and title
select max(employee_id) from employees;
select min(employee_id) from employees;
select title, count(title) from employees group by title;

drop temporary table if exists temporary_Employees;
create temporary table  temporary_Employees(
 Employee_id int primary key not null, 
 Employee_name varchar(30)not null, 
 Title varchar(30) not null,
 Hire_date date not null
);

insert into temporary_employees values ( 10, 'sade', 'Analyst', '2021-09-29');
insert into temporary_employees 
select * from smecompany.employees;

select* from temporary_employees;

drop temporary table if exists temp_customers;
create temporary table temp_customers(
Customer_id int,
Name varchar (50),
Order_date date,
Total_amount int
);

insert into temp_customers
select Customer_id, Name, Order_date, Total_amount
from smecompany.customers join smecompany.orders on smecompany.customers.SN= smecompany.orders.Customer_id 
group by  Customer_id, Name, Order_date, Total_amount;

select * from temp_customers;

create table Employees_Error(
Employee_id varchar (50),
First_name varchar (50),
Last_name varchar (50)
);

insert into employees_error values ('10      ', 'SadE', ' Made'),('   20', 'James ', 'MoOn'), (21, 'Jaime  ', 'Fired-  Man');

select * from employees_error;
select employee_id, trim(employee_id) as Trimmed_id from employees_error;
select employee_id, ltrim(employee_id) as Trimmed_id from employees_error;
select employee_id, rtrim(employee_id) as Trimmed_id from employees_error;

select last_name, trim(Last_name) as Trimmed_lastname from employees_error;
select last_name, replace(Last_name,'MoOn', 'Moon') as lastname_fixed from employees_error;
select last_name, replace(Last_name,'Fired- Man','Man') as lastname_fixed from employees_error;

select first_name, lower(first_name) from employees_error;
select last_name, upper(last_name) from employees_error;
select substring(first_name,1,3) from employees_error;

DELIMITER //
CREATE PROCEDURE test()
BEGIN
    SELECT * FROM customers;
END//
DELIMITER ;

call test();

DELIMITER //
CREATE PROCEDURE temp_customers()
BEGIN
    insert into temp_customers
select Customer_id, Name, Order_date, Total_amount
from smecompany.customers join smecompany.orders on smecompany.customers.SN= smecompany.orders.Customer_id 
group by  Customer_id, Name, Order_date, Total_amount;
select*from temp_customers;
    
END//
DELIMITER ;

call temp_customers;