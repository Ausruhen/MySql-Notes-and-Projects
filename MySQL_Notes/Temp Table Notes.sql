-- Temporary Tables

/*
A Temp Table is exactly as it sounds, it allows you to create a temporary table that can then be referenced later in the sql script
Upon closing the current instance of sql the temp table is deleted
This works even across files, the instance is ended when you completely exit out of whatever software you are using. 
This lets you query multiple times, typically temp tables are for more advanced operations where you are combining multiple temp tables together
CTE's are typically for simpler actions, with one or two levels of operation past the Creation of the common table expression
*/

#Case 1, Creating a table that you manually insert data into
CREATE TEMPORARY TABLE temp_table 
(first_name varchar(50),
last_name varchar(50),
favorite_movie varchar(100)
);
INSERT INTO temp_table
values('Andy', 'Ho', 'Harry Potter Movie 8');
select * from temp_table;

#Case 2, selecting subsets of data and putting it into a temp table
Create Temporary Table salary_over_50k   #the lack of semicolan means that sql knows to put this select statement data into this temp table
select * from employee_salary 
where salary >= 50000;

select * from salary_over_50k;


