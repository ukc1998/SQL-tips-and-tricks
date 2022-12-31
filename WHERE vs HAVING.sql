# WHERE VS HAVING
use ukc123
show tables
create table emp (emp_id int primary key, emp_name varchar(50), department_id int, salary int, manager_id int);
insert into emp values (1, "Ankit", 100, 10000, 4),(2, "Mohit", 100, 15000, 5),(3, "Vikash", 100, 10000, 4),(4, "Rohit", 100, 5000, 2),(5, "Mudit", 200, 12000, 6),(6, "Agam", 200, 12000, 2),(7, "Sanjay", 200, 9000, 2),(8, "Ashish", 200, 5000, 2);
 
 
 -- 1. Give details whose salary is greater than 10000?
 
select * from emp
select * from emp where salary > 10000;



-- 2. give department ids whose average salary is greater than 9500?

select department_id, avg(salary) as avg_salary_of_dept 
from emp 
group by department_id 
having avg_salary_of_dept > 9500;


-- 3. give dept id whose average salary is greater than 12000 after filtering 
-- the observations where individual's salary > 10000

# WHERE and HAVING used together

select department_id, avg(salary) as avg_salary_of_dept 
from emp
where salary > 10000
group by department_id 
having avg_salary_of_dept > 12000;