-- Subqueries

/*
subquery: A query inside a query
You can only query 1 column in a subquery
To initiate a sub query with WHERE use the IN keyword
You can use a sub-query in the from statement, in the select statement, and in the where statement
*/

-- subquery with where
select * from employee_demographics
where employee_id IN 
				(Select employee_id from employee_salary   #This returns the Employee_id numbers 1-6 and 12.
                where	dept_id = 1);                      #We are now referencing where the employee number from demographics is  1-6 or 12
                
-- subquery in the select clause
select first_name,salary,
(select avg(salary)  #does not require a group by because we only wanted the average of the ungrouped column
from employee_salary)
from employee_salary;
                
                
-- Subquery in the from clause
select gender,avg(age),max(age),min(age),count(age)
from employee_demographics
group by gender;

select avg(`max(age)`) from   #Have to use backticks '`' (tilde key lowercase) when refercing a column name that has a function inside of it
(select gender,avg(age),max(age),min(age),count(age)
from employee_demographics
group by gender) as agg_table;


select * from employee_demographics;

select gender, avg(age), max(age), min(age), count(age)
from employee_demographics
group by gender;

select avg(`max(age)`) from (select gender, avg(age) as avg_age, max(age), min(age), count(age)
from employee_demographics
group by gender) as agg_table;



