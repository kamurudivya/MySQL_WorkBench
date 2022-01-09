show databases;
-- UC1--
create database addressbook_service;
use addressbook_service;

-- UC2--
CREATE TABLE addressBook (
		id int not null auto_increment primary key,
		firstname varchar(20) NOT NULL, 
        lastname varchar(20) NOT NULL,
        address varchar(100),
        city varchar(20) NOT NULL,
        state varchar(20) NOT NULL,
        zip integer(6),
        phonenumber varchar(10) NOT NULL,
        email varchar(20) NOT NULL UNIQUE
);
desc addressBook;

-- UC3--
INSERT INTO addressbook VALUES
(1,'Julekha','Mulani','Kothrud','Pune','Maharashtra','424112','1234567890', 'jul.m@gmail.com'),
(2,'Rohini','Patil','Deccan','Pune','Maharashtra','420166','9191919291', 'rohini.p@gmail.com'),
(3,'Divya','K','Andhra','Andhra Pradesh','AP','487879','4567890125', 'divya.k@yahoo.com'),
(4,'Neeta','M','Madhya Pradesh','Gwalior','MP','43342','6577567890', 'neeta.m@gmail.com');

SELECT * FROM addressbook;

-- UC4--
UPDATE addressbook SET firstname = 'Julekhaaa'
WHERE firstname = 'Julekha'; 

SELECT * from addressbook where firstname = 'Julekhaaa';
SELECT firstname from addressbook where firstname = 'Julekhaaa';

-- UC5---
DELETE from addressbook WHERE firstname = 'Julekhaaa';
SELECT * FROM addressbook WHERE firstname = 'Julekhaaa';

-- UC6--
SELECT * from addressbook where city = 'Pune' OR state = 'MP';

-- UC7---
SELECT  city, state, COUNT(*) from addressbook where city = 'Pune' AND state = 'Maharashtra';

-- UC8 ---
SELECT * FROM addressbook WHERE state = 'Maharashtra' ORDER BY firstname ASC;
SELECT * FROM addressbook WHERE state = 'Maharashtra' ORDER BY firstname DESC;

-- UC9 ---
ALTER  TABLE addressbook add ab_name varchar(20);
alter table addressbook add ab_type char(20);

update addressbook set ab_name = 'AddressBook1' where id = 2;
update addressbook set ab_name = 'AddressBook2' where id = 1;
update addressbook set ab_name = 'AddressBook3' where id IN (3,4);

update addressbook set ab_type = 'family' where id = 1;
update addressbook set ab_type = 'friends' where id = 2;
update addressbook set ab_type = 'profession' where id IN(3,4);

-- UC10---  
SELECT ab_type, COUNT(*) FROM addressbook GROUP BY ab_type;

-- UC11---
insert into addressbook(firstname,lastname,address,city,state,zip,phonenumber,email,ab_name,ab_type)
 values('Julekhaaa', 'Mulani', 'Kothrud', 'Pune', 'Maharashtra','424112', '1234567890',	'jul.m1@gmail.com',	'AddressBook2',	'friends');

-- UC12---
CREATE TABLE addressbooks (
		id int not null auto_increment primary key,
		firstname varchar(20) NOT NULL, 
        lastname varchar(20) NOT NULL,
        address varchar(100),
        city varchar(20) NOT NULL,
        state varchar(20) NOT NULL,
        zip integer(6),
        phonenumber varchar(10) NOT NULL,
        email varchar(20) NOT NULL UNIQUE
);
desc addressbooks;

create table addressbooks_name(
  id int not null auto_increment primary key,
  name varchar (20) not null,
  ab_id int ,
  foreign key (ab_id)references addressbooks(id)  
);
desc addressbooks_name;

create table addressbooks_type(
id int not null primary key,
type varchar (20)
);
desc addressbooks_type;

create table addressbooks_abtype(
  a_id int not null,
  t_id int not null,
  foreign key(a_id) references addressbooks(id),
  foreign key(t_id) references addressbooks_type(id),
  primary key(a_id,t_id)
);

INSERT INTO addressbooks VALUES
(1,'Divya','K','Andhra','Andhra Pradesh','AP','487879','4567890125', 'divya.k@yahoo.com'),
(2,'Neeta','M','Madhya Pradesh','Satna','MP','43342','27834654756', 'neeta.m@gmail.com')
(3,'vindya','K','Andhra','Andhra Pradesh','AP','487879','4567890125', 'vindya.k@gmail.com'),
(4,'sony','M','Madhya Pradesh','Satna','MP','43342','27834654756', 'sony.m@gmail.com');
 
insert into addressbooks_name values (1,'AdddressBook1', 2); 

insert into addressbooks_type
values(1,'family');
insert into addressbooks_type
values(2,'friends');
insert into addressbooks_type
values(3,'profession');

insert into addressbooks_abtype(a_id,t_id)values(1,1);

select * from addressbooks;
select * from addressbooks_name;
select * from addressbooks_type;
select * from addressbooks_abtype;

SELECT * from addressbooks inner join addressbooks_name where city = 'Pune' OR state = 'MP';

SELECT  city, state, COUNT(*) from addressbooks  where city = 'Pune' AND state = 'Maharashtra';

SELECT * FROM addressbooks WHERE state = 'Maharashtra' ORDER BY firstname ASC;

SELECT type, count(*) FROM addressbooks join addressbooks_type group by type;

-- ability to add person friends and family--
select * from addressbooks inner join addressbooks_type ON addressbooks.id = 1 and addressbooks_type.id IN(1,2);

--- all record of id 1 can fetch---
select * from addressbooks inner join addressbooks_name inner join addressbooks_type ON addressbooks.id = 1 and addressbooks_name.id= '1' and addressbooks_type.id IN (1);
