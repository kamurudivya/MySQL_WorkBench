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
INSERT INTO addressBook VALUES
(1,'vindya','R','Andhra Pradesh','gudivada','AP','363463','564758799', 'vindya.r@gmail.com'),
(2,'sita','M','Deccan','Pune','Maharashtra','377459','1787632734', 'sita.m@gmail.com'),
(3,'Divya','K','Andhra Pradesh','kadapa ','AP','50003','363475656', 'divya.k@yahoo.com'),
(4,'teja','j','teleangana','Hyderbad','TS','516003','4657654754', 'teja.j@gmail.com');

SELECT * FROM addressBook;
-- UC4--
UPDATE addressBook SET firstname = 'vindya'
WHERE firstname = 'vindyaaa'; 

SELECT * from addressBook where firstname = 'vindya';
SELECT firstname from addressBook where firstname = 'vindya';

-- UC5---
DELETE from addressBook WHERE firstname = 'vindya';
SELECT * FROM addressBook WHERE firstname = 'vindya';

-- UC6--
SELECT * from addressBook where city = 'gudivada' OR state = 'Ap';

-- UC7---
SELECT  city, state, COUNT(*) from addressBook where city = 'gudivada' AND state = 'Andhra Pradesh';

-- UC8 ---
SELECT * FROM addressBook WHERE state = 'Andhra Pradesh' ORDER BY firstname ASC;
SELECT * FROM addressBook WHERE state = 'Andhra Pradesh' ORDER BY firstname DESC;

-- UC9 ---
ALTER  TABLE addressBook add ab_name varchar(20);
alter table addressBook add ab_type char(20);

update addressBook set ab_name = 'AddressBook1' where id = 2;
update addressBook set ab_name = 'AddressBook2' where id = 1;
update addressBook set ab_name = 'AddressBook3' where id IN (3,4);

update addressBook set ab_type = 'family' where id = 1;
update addressBook set ab_type = 'friends' where id = 2;
update addressBook set ab_type = 'profession' where id IN(3,4);

-- UC10---  
SELECT ab_type, COUNT(*) FROM addressBook GROUP BY ab_type;

-- UC11---
insert into addressBook(firstname,lastname,address,city,state,zip,phonenumber,email,ab_name,ab_type)
 values('vindya', 'Rudhrakshala', 'gudivada', 'Andhra', 'Andhra Pradesh','363463', '564758799',	'vindya.r@gmail.com',	'AddressBook2',	'friends');

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

create table addressBooks_name(
  id int not null auto_increment primary key,
  name varchar (20) not null,
  ab_id int ,
  foreign key (ab_id)references addressBooks(id)  
);
desc addressBooks_name;

create table addressBooks_type(
id int not null primary key,
type varchar (20)
);
desc addressBooks_type;

create table addressBooks_abtype(
  a_id int not null,
  t_id int not null,
  foreign key(a_id) references addressBooks(id),
  foreign key(t_id) references addressBooks_type(id),
  primary key(a_id,t_id)
);
INSERT INTO addressBooks VALUES
(1,'vindya','R','Andhra Pradesh','gudivada','AP','363463','564758799', 'vindya.r@gmail.com'),
(2,'sita','M','Deccan','Pune','Maharashtra','377459','1787632734', 'sita.m@gmail.com'),
(3,'Divya','K','Andhra Pradesh','kadapa ','AP','50003','363475656', 'divya.k@yahoo.com'),
(4,'teja','j','teleangana','Hyderbad','TS','516003','4657654754', 'teja.j@gmail.com');
 
insert into addressBooks_name values (1,'AdddressBook1', 2); 

insert into addressBooks_type
values(1,'family');
insert into addressBooks_type
values(2,'friends');
insert into addressBooks_type
values(3,'profession');

insert into addressBooks_abtype(a_id,t_id)values(1,1);

select * from addressBooks;
select * from addressBooks_name;
select * from addressBooks_type;
select * from addressBooks_abtype;

SELECT * from addressBooks inner join addressBooks_name where city = 'gudivada' OR state = 'AP';

SELECT  city, state, COUNT(*) from addressBooks  where city = 'gudivada' AND state = 'Andhra pradesh';

SELECT * FROM addressBooks WHERE state = 'Andhra pradesh' ORDER BY firstname ASC;

SELECT type, count(*) FROM addressBooks join addressBooks_type group by type;

-- ability to add person friends and family--
select * from addressBooks inner join addressBooks_type ON addressBooks.id = 1 and addressBooks_type.id IN(1,2);

--- all record of id 1 can fetch---
select * from addressBooks inner join addressBooks_name inner join addressBooks_type ON addressBooks.id = 1 and addressBooks_name.id= '1' and addressBooks_type.id IN (1);
