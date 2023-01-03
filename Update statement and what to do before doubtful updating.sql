-- 1- Update basic syntax
-- 2- Update with where clause
-- 3- Update multiple values in a statement 
-- 4- Update using Join
-- 5- Update using calculations
-- 6- Interview question on Update
-- 7- Some tips and tricks on sql update

select * from emp;
select * from dept;


-- 1.
update emp set salary = 12000

-- 2.1
update emp set salary = 12000 where emp_id = 1;
-- 2.2
update emp set salary = 12000 where emp_age > 30;

-- 3.
update emp set salary = 12000, dep_id = 200 where emp_id = 2

-- 5.1
update emp set salary = salary + 1000;
-- 5.2
update emp set salary = salary *1.1 where emp_id = 1;



-- 6.1
update emp set salary = case when dep_id = 100 then salary*1.1 when dep_id = 200 then salary*1.2 else salary end;

-- 6.2 step  1:
alter table emp add dep_name varchar(20);

-- 6.2 step  2:
update emp
set dep_name = d.dep_name
from emp e
inner join dept d on e.dep_id = d.dep_id


-- 4. step 1:
alter table emp add gender varchar(10);

-- 4. step 2:
update emp set gender = case when dep_id = 100 then "Male" else "Female" end;

-- 4. step 3:
update emp set gender = case when gender = "Male" then "Female" else "Male" end;


-- 7. Cautious before running or updating:
select *, case when gender = "Male" then "Female" else "Male" end from emp;

