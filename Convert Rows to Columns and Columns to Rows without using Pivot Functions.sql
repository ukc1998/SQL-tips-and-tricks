use ukc123

create table emp_compensation (
emp_id int,
salary_component_type varchar(20),
val int
);

insert into emp_compensation
values (1,'salary',10000),(1,'bonus',5000),(1,'hike_percent',10)
, (2,'salary',15000),(2,'bonus',7000),(2,'hike_percent',8)
, (3,'salary',12000),(3,'bonus',6000),(3,'hike_percent',7);

select * from emp_compensation;

-- PIVOTING
# step 1:

select 
emp_id,
case when salary_component_type = "salary" then val end as salary,
case when salary_component_type = "bonus" then val end as bonus,
case when salary_component_type = "hike_percent" then val end as hike_percent
from emp_compensation;


#step 2:

select 
emp_id,
min(case when salary_component_type = "salary" then val end) as salary,
sum(case when salary_component_type = "bonus" then val end) as bonus,
max(case when salary_component_type = "hike_percent" then val end) as hike_percent
from emp_compensation
group by emp_id;

## we could have used SUM for all the three columns. 
## If the datatype were be varchar, then min/max would have been used.


-- UNPIVOTING
# Making a new table from the above query to unpivot it.

create table emp_compensation_pivoted as 
select 
emp_id,
sum(case when salary_component_type = "salary" then val end) as salary,
sum(case when salary_component_type = "bonus" then val end) as bonus,
sum(case when salary_component_type = "hike_percent" then val end) as hike_percent
from emp_compensation
group by emp_id;

select * from emp_compensation_pivoted;

# Lets unpivot it now

#step 1:

select emp_id, "salary" as salary_component_type, salary as val from emp_compensation_pivoted

#step 2:

select emp_id, "salary" as salary_component_type, salary as val from emp_compensation_pivoted
union all
select emp_id, "hike_percent" as salary_component_type, hike_percent as val from emp_compensation_pivoted

#step 3:

select emp_id, "salary" as salary_component_type, salary as val from emp_compensation_pivoted
union all
select emp_id, "hike_percent" as salary_component_type, hike_percent as val from emp_compensation_pivoted
union all
select emp_id, "bonus" as salary_component_type, bonus as val from emp_compensation_pivoted


#step 4:

select * from
(select emp_id, "salary" as salary_component_type, salary as val from emp_compensation_pivoted
union all
select emp_id, "hike_percent" as salary_component_type, hike_percent as val from emp_compensation_pivoted
union all
select emp_id, "bonus" as salary_component_type, bonus as val from emp_compensation_pivoted) alias
order by emp_id;