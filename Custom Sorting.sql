-- Custom Sorting

create table happiness_index 
(rank_position int,
country varchar(55),
Happiness_2021 varchar(55),
Happiness_2020 varchar(55),
Population_2022 varchar(55)
);

insert into happiness_index values 
(1,	'Finland',	7.842,	7.809,	5554960),
(2,	'Denmark',	7.62,	7.646,	5834950),
(3,	'Switzerland',	7.571,	7.56,	8773637),
(4,	'Iceland',	7.554,	7.504,	345393),
(5,	'Netherlands',	7.464,	7.449,	17211447),
(6,	'Norway',	7.392,	7.488,	5511370),
(7,	'Sweden',	7.363,	7.353,	10218971),
(8,	'Luxembourg',	7.324,	7.238,	642371),
(9,	'New Zealand',	7.277,	7.3,	4898203),
(10, 'Austria',	7.268,	7.294,	9066710);

select * from happiness_index

-- solution: Method1
#step1:
select *, case when country = "Norway" then 1 else 0 end as country_derived
from happiness_index
order by happiness_2021 desc;

#step1:
select rank_position, country, Happiness_2021, Happiness_2020, Population_2022 from (select *, case when country = "Switzerland" then 3  
							when country = "Norway" then 2 
							when country = "Sweden" then 1 
						else 0 end as country_derived
						from happiness_index) subquery
order by country_derived desc, happiness_2021 desc;



-- solution: Method2
select rank_position, country, Happiness_2021, Happiness_2020, Population_2022,  
						case when country = "Switzerland" then 3  
							when country = "Norway" then 2 
							when country = "Sweden" then 1 
						else 0 end as country_derived
						from happiness_index
order by country_derived desc, happiness_2021 desc;


-- solution: Method3
select rank_position, country, Happiness_2021, Happiness_2020, Population_2022
from happiness_index
order by case when country = "Switzerland" then 3  
							when country = "Norway" then 2 
							when country = "Sweden" then 1 
						else 0 end  desc, happiness_2021 desc;