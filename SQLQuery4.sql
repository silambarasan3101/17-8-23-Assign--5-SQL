create database Assessment5Db
use Assessment5Db

create schema bank

create table bank.Customer
(CId int identity(1000, 1) primary key,
CName nvarchar(50) not null,
CEmail nvarchar(50) not null unique,
Contact nvarchar(20) not null unique,
CPwd as right(CName, 2) + convert(nvarchar(10), CId) +''+left(Contact, 2) persisted 
)

create table bank.MailInfo
(MailTo nvarchar(50),
MailDate date,
MailMessage nvarchar(100))

create trigger bank.trgMailToCust
on bank.Customer
after insert
as 
insert into bank.MailInfo(MailTo, MailDate, MailMessage)
select i.CEmail, GETDATE(), 'Your netbanking password is: '+i.CPwd+'. It is valid upto 2 days only. Update it.' from inserted i

drop trigger bank.trgMailToCust

insert into bank.Customer values('Str', 'str.m@gmail.com',6368769823)
insert into bank.Customer values('Ravi', 'Ravi.k@gmail.com',6345654598)
insert into bank.Customer values('Guna', 'Guna.m@gmail.com',7156768934)

select * from bank.Customer
select * from bank.MailInfo