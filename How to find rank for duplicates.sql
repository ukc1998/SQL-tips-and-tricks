use ukc123

create table list (id varchar(5));
insert into list values ('a');
insert into list values ('a');
insert into list values ('b');
insert into list values ('c');
insert into list values ('c');
insert into list values ('c');
insert into list values ('d');
insert into list values ('d');
insert into list values ('e');

select * from list;

-- Q -- Find the rank only for duplicates, but make sure that non-duplicates not to be removed from the table
-- output: 1,1,null,2,2,2,3,3,null


# step 1:
with cte_dups as (select id from list group by id having count(*) > 1)
select *, rank() over(order by id asc) as rn
from cte_dups


# step 2:
with cte_dups as (select id from list group by id having count(*) > 1),
cte_rank as (select *, rank() over(order by id asc) as rn
from cte_dups)
select list.id as input, concat("DUP",cte_rank.rn) as output from list 
left join cte_rank on list.id = cte_rank.id