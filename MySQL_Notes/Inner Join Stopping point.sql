-- Joins Notes

/*
allows different tables to be combined if they have a similar table
Column names do not have to be the same, only the data does
Types of joins: Inner, Outer, Left, Right, Self (Default is inner join)
*/
select * from employee_demographics;
select * from employee_salary;

/*
INNER JOINS- Returns rows that are the same in two columns from the two joined tables
syntax: select columns you want to join ONTO an existing table, 
then specifiy which two things are linking the tables by using example_table.column_name = example_table2.column_name
the column names dont need to be the same as long as the data is the same

Think of it as being able to create a new table where you select the columns from each seperate table that you want as follows
*/

select demo.employee_id, age, occupation, salary.first_name, demo.last_name from employee_demographics as demo  
inner join employee_salary as salary                 
	on demo.employee_id = salary.employee_id;
    
    
    
/*
OUTER JOINS: There are two outer joins, left join and right join
left: Takes every column from the "left table" and only return matches from the right table. This keeps all the original values from the left table
right: Takes every column from the "right table" and only return matches from the left table. This keeps all the original valeus from the right table

The left table is the table that gets references after the from statement, the right table is the table that gets referenced after the join statement
If a table returns null values, it means there werent any matches 
*/

select * from employee_demographics as demo
Right join employee_salary as salary     #swap left and right here. Note that on right join it cannot populate employee_id2, so it fills it with nulls
	on demo.employee_id = salary.employee_id; #tab not required but good practice
    
/*
Self Join: This shit is ass
*/

Select sal1.employee_id as emp_santa, sal1.first_name as first_name_santa, sal1.last_name as last_name_santa, 
sal2.employee_id as emp_santa, sal2.first_name as first_name_santa, sal2.last_name as last_name_santa 
from employee_salary as sal1
join employee_salary as sal2
	on sal1.employee_id + 1 = sal2.employee_id;
    
/*
-Joining multiple tables together: When you join multiple tables together, you just call the joins on the tables that have similar columns
-allowed to reference two different tables
*/

select * from employee_demographics as demo  
inner join employee_salary as sal               
	on demo.employee_id = sal.employee_id
inner join parks_Departments as pd
	on sal.dept_id = pd.department_id;
