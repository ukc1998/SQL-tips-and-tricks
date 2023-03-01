use ukc123;

create table teams (`name` varchar(20));

select * from teams;

insert into teams values
("IND"),
("PAK"),
("AUS"),
("NZ"),
("IRE");


SELECT 
	CONCAT(t1.name, " vs ", t2.name) AS matches
FROM
	teams t1
		JOIN
	teams t2 ON t1.name < t2.name;
    
    
