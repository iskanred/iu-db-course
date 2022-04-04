
---------------------- Initialization ----------------------------------------
create table if not exists Customers(
	customerId integer primary key,
	customerName text,
	city text
);

create table if not exists Orders(
	orderId integer primary key,
	orderDate date,
	customerId integer references Customers(customerId)
);

create table if not exists Items(
	itemId integer primary key,
	itemName text,
	price real
);

create table if not exists Contains(
	orderId integer references Orders(orderId),
	itemId integer references Items(itemId)
);

insert into Customers values
	(101, 'Martin', 'Prague'),
	(107, 'Herman', 'Madrid'),
	(110, 'Pedro', 'Moscow')
;

insert into Orders values
	(2301, '2011-02-23', 101),
	(2302, '2011-02-25', 107),
	(2303, '2011-02-27', 110)
;

insert into Items values
	(3786, 'Net', 35.0),
	(4011, 'Racket', 65.0),
	(9132, 'Pack-3', 4.75),
	(5794, 'Pack-6', 5.0),
	(3141, 'Cover', 10.0)
;

insert into Contains values
	(2301, 3786),
	(2301, 4011),
	(2301, 9132),
	(2302, 5794),
	(2303, 4011),
	(2303, 3141)
;



---------------------- Queries ---------------------------------------------
select Customers.name, max(totalPrice)
select
	orderId sum(price*count) as totalPrice
from 
	Contains, Items, Orders, Customers
where
	Contains.itemId = Items.itemId and Contains.orderId = Orders.orderId and Orders.customerId = Customers.customerId
group by
	Contains.orderId

;

select 
	orderId, sum(quant) as totalQuant, sum(price) as totalPrice
from 
	Contains, Items
where 
	Contains.itemId = Items.itemId
group by 
	orderId;


select 
	Customers.customerId, Customers.name, Customers.city, max(price*quant)
from

where

group by

