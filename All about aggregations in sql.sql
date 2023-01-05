use ukc123;

CREATE TABLE int_orders(
 order_number int NOT NULL,
 order_date date NOT NULL,
 cust_id int NOT NULL,
 salesperson_id int NOT NULL,
 amount float NOT NULL
);

INSERT int_orders (order_number, order_date, cust_id, salesperson_id, amount) VALUES (30, CAST(N'1995-07-14' AS Date), 9, 1, 460);
INSERT int_orders (order_number, order_date, cust_id, salesperson_id, amount) VALUES (10, CAST(N'1996-08-02' AS Date), 4, 2, 540);
INSERT int_orders (order_number, order_date, cust_id, salesperson_id, amount) VALUES (40, CAST(N'1998-01-29' AS Date), 7, 2, 2400);
INSERT int_orders (order_number, order_date, cust_id, salesperson_id, amount) VALUES (50, CAST(N'1998-02-03' AS Date), 6, 7, 600);
INSERT int_orders (order_number, order_date, cust_id, salesperson_id, amount) VALUES (60, CAST(N'1998-03-02' AS Date), 6, 7, 720);
INSERT int_orders (order_number, order_date, cust_id, salesperson_id, amount) VALUES (70, CAST(N'1998-05-06' AS Date), 9, 7, 150);
INSERT int_orders (order_number, order_date, cust_id, salesperson_id, amount) VALUES (20, CAST(N'1999-01-30' AS Date), 4, 8, 1800);

select * from int_orders;


-- Aggregation topics:



# Level1:

select sum(amount) as total_sales from int_orders;

# Level2:
select salesperson_id, sum(amount) as total_sales from int_orders group by salesperson_id;

# Level2_limitation: (In case of SQL Server, not in mysql)
select salesperson_id, sum(amount) as total_sales, order_number from int_orders group by salesperson_id;

# Level2_limitation_solution: (In case of SQL Server)
-- Step1:
select order_number, order_date, cust_id, salesperson_id, amount, sum(amount) as total_sales
from int_orders group by salesperson_id;

-- Step2:
select order_number, order_date, cust_id, salesperson_id, amount, sum(amount) over() as total_sales
from int_orders group by salesperson_id;

-- Step3:
select order_number, order_date, cust_id, salesperson_id, amount, sum(amount) over(partition by salesperson_id) as total_sales
from int_orders group by salesperson_id;

-- Step4:
select order_number, order_date, cust_id, salesperson_id, amount, sum(amount) over(order by order_date ) as running_total_sales
from int_orders;

-- Step5: Partition by is used for creating a window and order by is used for creating running calculations
select order_number, order_date, cust_id, salesperson_id, amount, sum(amount) over(partition by salesperson_id order by order_date ) as running_total_sales_id_wise
from int_orders;

-- Level3.1:
select order_number, order_date, cust_id, salesperson_id, amount, sum(amount) over(order by order_date rows between 2 preceding and current row) as running_total_sales
from int_orders;

-- Level3.2:
select order_number, order_date, cust_id, salesperson_id, amount, sum(amount) over(order by order_date rows between current row and 2 following) as running_total_sales
from int_orders;

-- Level3.3:
select order_number, order_date, cust_id, salesperson_id, amount, sum(amount) over(order by order_date rows between  2 preceding and 2 following) as running_total_sales
from int_orders;

-- Level3.4:
select order_number, order_date, cust_id, salesperson_id, amount, sum(amount) over(order by order_date rows between  2 preceding and 1 preceding) as running_total_sales
from int_orders;

-- Level3.5:
select order_number, order_date, cust_id, salesperson_id, amount, sum(amount) over(order by order_date rows between  1 preceding and 2 preceding) as running_total_sales
from int_orders;

-- Level3.6:
select order_number, order_date, cust_id, salesperson_id, amount, sum(amount) over(order by order_date rows between  2 following and 1 following) as running_total_sales
from int_orders;

-- Level3.7:
select order_number, order_date, cust_id, salesperson_id, amount, sum(amount) over(order by order_date rows between  1 following and 2 following) as running_total_sales
from int_orders;

-- Level3.8:
select order_number, order_date, cust_id, salesperson_id, amount, sum(amount) over(order by order_date rows between unbounded  preceding and 1 following) as running_total_sales
from int_orders;