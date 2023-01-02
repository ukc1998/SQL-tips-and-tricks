-- Q-- calculate mode using SQL

# method1 : cte
# method2: analytical function

use ukc123
create table mode_table 
(
id int
);

insert into mode_table values (1),(2),(2),(3),(3),(3),(3),(4),(5),(6),(7),(7),(7),(7);

select * from mode_table

# method 1: CTE
# step1:
select id, count(*) as freq from mode_table group by id;

# step2:
with freq_cte as (select id, count(*) as freq from mode_table group by id)
select * from freq_cte
where freq = (select max(freq) from freq_cte);


# Method 2:

# step1:

with freq_cte as (select id, count(*) as freq from mode_table group by id)
select *, rank() over(order by freq desc) as rn 
from freq_cte

# step2:

with freq_cte as (select id, count(*) as freq from mode_table group by id),
rank_cte as (select *, rank() over(order by freq desc) as rn from freq_cte)
select * from rank_cte
where rn = 1;