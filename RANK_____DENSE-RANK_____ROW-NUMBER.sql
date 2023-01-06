use ukc123;

select * from emp;


-- Giving rank on salary basis (Repeated rank is skipped using RANK())
select emp_id, emp_name, department_id, salary,
rank() over(order by salary desc) as rank_salary_wise
from emp;

-- Giving rank on salary basis (Repeated rank is not skipped using DENSE_RANK())
select emp_id, emp_name, department_id, salary,
dense_rank() over(order by salary desc) as rank_salary_wise
from emp;

-- Giving rank on salary basis (Same values can have different rank using ROW NUMBER())
select emp_id, emp_name, department_id, salary,
row_number() over(order by salary desc) as rank_salary_wise
from emp;

# department wise rank?? -- Windowing
select emp_id, emp_name, department_id, salary,
dense_rank() over(partition by department_id order by salary desc) as rank_salary_wise
from emp;


# department wise 1st rankers??
select * from (select emp_id, emp_name, department_id, salary,
dense_rank() over(partition by department_id order by salary desc) as rank_salary_wise
from emp) subquery
where rank_salary_wise = 1;