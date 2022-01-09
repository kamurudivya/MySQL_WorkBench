-- UC1 ---
show databases;
create database emp_payroll_service;
use emp_payroll_service;

-- UC2 --
create table employee_payroll (
id int not null auto_increment,
name varchar(50) not null,
salary double not null,
startDate Date not null,
primary key(id)
);

desc employee_payroll;

-- UC3 --
insert into employee_payroll (name, salary, startDate)
values ('Julekha', 450000.0, '2021-01-10');

insert into employee_payroll (name, salary, startDate)
values ('Rohini', 500000.0, '2021-01-10');

insert into employee_payroll (name, salary, startDate)
values ('Ashok', 500000.0, '2021-01-10');

insert into employee_payroll (name, salary, startDate)
values ('Neeta', 400000.0, '2021-12-10');

-- UC4 ---
select * from employee_payroll;

-- UC5 ---
select * from employee_payroll where name = 'Julekha';

select * from employee_payroll
where startDate between '2021-04-10' and date(now());

-- UC6 ---
alter table employee_payroll add gender char(1);

alter table employee_payroll add gender char(1) after name;

update employee_payroll set gender = 'M' where id = 3;
update employee_payroll set gender = 'F' where id IN (1,2,4);

-- UC7 ---
select sum(salary) from employee_payroll;
select gender,sum(salary) from employee_payroll group by gender;

select gender,avg(salary) from employee_payroll group by gender;

select gender,max(salary) from employee_payroll group by gender;

select gender,min(salary) from employee_payroll group by gender;

select gender,count(*) from employee_payroll group by gender;

-- UC8---
alter table employee_payroll add phone_number varchar(13) after name;
alter table employee_payroll add address varchar(200) after phone_number;
alter table employee_payroll add department varchar(100) not null after address;
alter table employee_payroll alter address set default 'TBD';

insert into employee_payroll (name, salary,startDate,department,gender) 
values('Kajal', 49000, '2020-01-01','IT','F');

-- UC9 ---
alter table employee_payroll rename column salary to basic_pay;
alter table employee_payroll add deductions double not null after basic_pay;
alter table employee_payroll add taxable_pay double not null after deductions;
alter table employee_payroll add tax double not null after taxable_pay;
alter table employee_payroll add net_pay double not null after tax;

-- UC10---
insert into employee_payroll 
       (name,phone_number,department,gender,basic_pay,deductions,taxable_pay,tax,net_pay,startDate)
values('Terissa','9898989898','Marketing','F',4800000,100000,40000,5400,4000000,'2021-01-08');

insert into employee_payroll 
       (name,phone_number,department,gender,basic_pay,deductions,taxable_pay,tax,net_pay,startDate)
values('Terissa','9898989898','Sales','F',4800000,100000,40000,5400,4000000,'2021-01-08');

-- UC11 ER diagram---
create table employee(
id int not null auto_increment primary key,
name varchar(50) not null,
gender varchar(1),
phone_number varchar(13),
address varchar(200),
startDate Date not null
);
desc employee;

create table payroll(
id int not null auto_increment primary key,
basic_pay double,
deductions double,
income_tax double,
taxable_pay double,
tax double,
net_pay double,
emp_ID int,
foreign key(emp_ID) references employee(id)
);
desc payroll;

create table department(
  id int not null auto_increment primary key,
  dept_name varchar(20) not null
  );
  desc department;

create table employee_department(
  employee_id int not null,
  department_id int not null,
  foreign key(employee_id) references employee(id),
  foreign key(department_id) references department(id),
  primary key(employee_id,department_id)
);
desc employee_department;

-- UC12--
select * from employee;
select * from payroll;
select * from department;
select * from employee_department;
show tables;

drop table employee;
drop table payroll;
drop table employee_department;

insert into employee(name, gender, phone_number, address,startDate)
values ('sony', 'f','9898989898','Pune','2021-01-10');
insert into employee(name, gender, phone_number, address,startDate)
values ('divya', 'f','8686868686','mp','2021-10-01');
insert into employee(name, gender, phone_number, address,startDate)
values ('vindya', 'f','9898955678','Pune','2021-01-04');
insert into employee(name, gender, phone_number, address,startDate)
values ('bhanu', 'm','9895689865','NY','2021-04-10');

insert into payroll(basic_pay, deductions, income_tax, taxable_pay, tax, net_pay,emp_ID)
values (400000,1000,500,5000,600,350000,1);
insert into payroll(basic_pay, deductions, income_tax, taxable_pay, tax, net_pay,emp_ID)
values (500000,2000,500,5000,600,450000,2);
insert into payroll(basic_pay, deductions, income_tax, taxable_pay, tax, net_pay,emp_ID)
values (600000,3000,500,5000,600,550000,3);
insert into payroll(basic_pay, deductions, income_tax, taxable_pay, tax, net_pay,emp_ID)
values (700000,4000,500,5000,600,650000,4);

insert into department(dept_name)
values('Sales'),('Marketing');
insert into department(dept_name)
values('HR');
select sum(basic_pay) from payroll;
select gender, sum(basic_pay) from payroll join employee group by gender;
select gender, avg(basic_pay) from payroll join employee group by gender ;
select gender, max(basic_pay) from payroll join employee group by gender ;
select gender, min(basic_pay) from payroll join employee group by gender ;
select gender, count(*) from employee group by gender;

insert into employee(name, gender, phone_number, address,startDate)
values ('Terissa', 'f','9895689865','NY','2021-04-10');

insert into payroll(basic_pay, deductions, income_tax, taxable_pay, tax, net_pay,emp_ID)
values (300000,1000,500,5000,600,350000,5);

insert into employee_department(employee_id,department_id)values(1,1);

-- person belong to both department---
select * from employee inner join payroll inner join department ON employee.id = 5 and payroll.id =5 and department.id IN (1,2);
