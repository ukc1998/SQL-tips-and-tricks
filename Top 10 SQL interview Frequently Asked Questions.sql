create table empNEW(
emp_id int,
emp_name varchar(20),
department_id int,
salary int,
manager_id int,
emp_age int);


insert into empNEW
values
(1, 'Ankit', 100,10000, 4, 39),
(2, 'Mohit', 100, 15000, 5, 48),
(3, 'Vikas', 100, 10000,4,37),
(4, 'Rohit', 100, 5000, 2, 16),
(5, 'Mudit', 200, 12000, 6,55),
(6, 'Agam', 200, 12000,2, 14),
(7, 'Sanjay', 200, 9000, 2,13),
(8, 'Ashish', 200,5000,2,12),
(9, 'Mukesh',300,6000,6,51),
(10, 'Rakesh',300,7000,6,50),
(11, 'Rohit', 100, 5000, 2, 16),
(12, 'Mudit', 200, 12000, 6,55),
(13, 'Agam', 200, 12000,2, 14),
(14, 'Sanjay', 200, 9000, 2,13),
(15, 'Ashish', 200,5000,2,12),
(16, 'Mukesh',300,6000,6,51),
(17, 'Rakesh',300,7000,6,50),
(18, 'Sanjay', 200, 9000, 2,13),
(19, 'Ashish', 200,5000,2,12),
(20, 'Mukesh',300,6000,6,51),
(21, 'Rakesh',300,7000,6,50);


select * from empNEW

-- Q1-- How to find duplicates in a given table?

#Step 1:
select emp_id, count(*) as no_of_values from empNEW group by emp_name;

#Step 2:
select emp_id, count(*) as no_of_values from empNEW group by emp_name having no_of_values > 1;



-- Q2-- How to delete duplicates in a given table?

# Step 1: Find row number first including both unique and duplicates (In our case, all the columns are duplicated...not only emp_id)
select emp_id, row_number() over (partition by emp_name order by emp_id) as row_no from empNEW

# Step 2: Find row number only for duplicates 
with cte as 
(select emp_id, row_number() over (partition by emp_name order by emp_id) as row_no from empNEW )
select emp_id from cte where row_no > 1;

#Step 2 : Alternative (CTE mtd will be able to delete only in SQL server, not  in mySQL)
select emp_id from (select emp_id, row_number() over (partition by emp_name order by emp_id) as row_no from empNEW ) alias
where row_no > 1;

# Step 3: (Will work only in SQL Server, not in mySQL)
with cte as 
(select emp_id, row_number() over (partition by emp_name order by emp_id) as row_no from empNEW )
delete from from cte where row_no > 1;

# Step 3: Alternative
DELETE FROM empNEW where emp_id in (select emp_id from (select emp_id, row_number() over (partition by emp_name order by emp_id) as row_no from empNEW ) alias
where row_no > 1);

select * from empNEW


-- Q3 -- What is the difference between UNION and UNION ALL?

-- Answer: UNION gives only unique values.....UNION ALL gives duplicate values also

# UNIONALL
select manager_id from empNEW
union all
select manager_id from emp

# UNION
select manager_id from empNEW
union
select manager_id from emp

-- Q4 -- Difference between RANK, ROW_NUMBER and DENSE_RANK
-- Q5 -- Employees who are not present in department table

create table dept(dept_id int, dep_name varchar(20));

# Method 1:.....SUBQUERY method: Not good performance wise

insert into dept values
(100, "Analytics"),
(300, "IT");

select * from empNEW where department_id not in (select dept_id from dept);

# Method 2:.....LEFT JOIN method:

select empNEW.*, dept.dept_id, dept.dep_name from 
empNEW
LEFT JOIN
dept
on empNEW.department_id = dept.dept_id
where dept.dep_name is null


-- Q6 -- Second highest salary in each department
SELECT * FROM empNEW

# Step1:

select empNEW.*, dense_rank() over(partition by department_id order by salary desc) as rn from empNEW

# step2:

with cte as (select empNEW.*, dense_rank() over(partition by department_id order by salary desc) as rn
from
empNEW)
select * from cte
where rn = 2;

# step2: alternative

select * from (select empNEW.*, dense_rank() over(partition by department_id order by salary desc) as rn
from
empNEW) alias
where rn = 2;


-- Q7 -- Find all transactions done by Shilpa

create table orders(customer_name varchar(10), order_date date, order_amount int, customer_gender varchar(1));

insert into orders values
("Shilpa", "2020-01-01", 10000, "M"),
("Rahul", "2020-01-02", 12000, "F"),
("SHILPA", "2020-01-02", 12000, "M"),
("Rohit", "2020-01-03", 15000, "F"),
("Shilpa", "2020-01-03", 14000, "M");

select * from orders

#Solution: If case_insensitive, then we will get records
select * from orders where customer_name = "Shilpa"


#Solution: If case_sensitive, then in order to get all records
select * from orders where upper(customer_name) = "SHILPA"

-- Q8 -- using self join select manager salary > emp salary
-- Q9 -- joins-- left/outer
-- Q10 -- Update query to swap gender

select * from orders
# we will have to update both genders at once

update orders set customer_gender = case when customer_gender = "M" then "F"
										when customer_gender = "F" then "M" end;
                                        
                                        
select * from orders