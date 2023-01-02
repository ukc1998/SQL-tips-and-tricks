use ukc123;

create table products (
id int,
name varchar(10)
);
insert into products VALUES 
(1, 'A'),
(2, 'B'),
(3, 'C'),
(4, 'D'),
(5, 'E');

create table colors (
color_id int,
color varchar(50)
);
insert into colors values (1,'Blue'),(2,'Green'),(3,'Orange');

create table sizes
(
size_id int,
size varchar(10)
);

insert into sizes values (1,'M'),(2,'L'),(3,'XL');

create table transactions
(
order_id int,
product_name varchar(20),
color varchar(10),
size varchar(10),
amount int
);
insert into transactions values (1,'A','Blue','L',300),(2,'B','Blue','XL',150),(3,'B','Green','L',250),(4,'C','Blue','L',250),
(5,'E','Green','L',270),(6,'D','Orange','L',200),(7,'D','Green','M',250);



-- use case 1: Prepare Master Data
-- use case 2: Prepare large no of rows for performance testing


select * from products;
select * from colors;
select * from sizes;

# How to cross join: 45 records for joining 5 rec from products, 3 rec from colors, 3 rec from sizes
-- -----> SKU: STOCK KEEPING UNIT




-- METHOD 1:
select * from products 
cross join
colors;

-- METHOD 2:
select p.*, c.* from products p, colors c;


-- use case1: preparing master data
# Give me sales for each product, color and size using transaction table

# step1: preparing master data
select p.name as product_name, c.color, s.size from products p, colors c, sizes s

# step2:
select product_name, color, size, sum(amount) as total_amount from transactions group by product_name, color, size

# step3:
with 
master_data as (select p.name as product_name, c.color, s.size 
				from products p, colors c, sizes s),
sales as (select product_name, color, size, sum(amount) as total_amount 
			from transactions 
            group by product_name, color, size)
select md.product_name, md.color, md.size, s.total_amount
from master_data md
left join sales s
on md.product_name = s.product_name and md.color = s.color and md.size = s.size
order by total_amount



-- use case 2: to generate some performance data (prepare large no.of rows) as for testing purpose

#step 1:
CREATE TABLE transactions_test LIKE transactions;

#step 2:
select * from transactions_test

# step3: 9694 * 7 = 67858 records
select count(*) from transactions t, sample_superstore

# step 4:
select t.* from transactions t cross join sample_superstore 

# step 5: we will make sure that order_id sud not be repeating
select row_number() over(order by t.order_id) as order_id, 
t.product_name, t.color, t.size, t.amount 
from transactions t, sample_superstore

# step 6: we will make sure that size sud be different
select row_number() over(order by t.order_id) as order_id, 
t.product_name, t.color, 
case when row_number() over(order by t.order_id)%3 = 0 then "L" else "XL" end size,
t.amount 
from transactions t, sample_superstore

# step 7: 67858*7 = 475006 records
select row_number() over(order by t.order_id) as order_id, 
t.product_name, t.color, 
case when row_number() over(order by t.order_id)%3 = 0 then "L" else "XL" end size,
t.amount 
from transactions t, sample_superstore, transactions t1


# step 8: 67858*7*7 = 475006*7 = 3325042 records
select row_number() over(order by t.order_id) as order_id, 
t.product_name, t.color, 
case when row_number() over(order by t.order_id)%3 = 0 then "L" else "XL" end size,
t.amount 
from transactions t, sample_superstore, transactions t1, transactions t2


# step 9: inserting (lost connection during query)
insert into transactions_test
select row_number() over(order by t.order_id) as order_id, 
t.product_name, t.color, 
case when row_number() over(order by t.order_id)%3 = 0 then "L" else "XL" end size,
t.amount 
from transactions t, sample_superstore, transactions t1, transactions t2

# step 10 : table is now ready for performance testing
select count(*) from transactions_test