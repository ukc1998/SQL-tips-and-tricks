create table product ( product_id varchar(20), cost int);

insert into product values ('P1', 200), ('P2', 300), ('P3', 300), ('P4', 500), ('P5', 800)

select * from product

# Problem: We sud get 500 instead of 800 for running cost of P2
select *, sum(cost) over(order by cost asc) as running_cost
from product;

# Solution1:
select *, sum(cost) over(order by cost asc, product_id) as running_cost
from product;

# Solution2:
select *, sum(cost) over(order by cost asc rows between unbounded preceding and current row) as running_cost
from product;

