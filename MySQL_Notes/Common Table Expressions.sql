-- Common table Expression CTEs

/*
Allow you to define a subquery block and then reference them later 
WITH: Keyword to define a Common table expression
Can only use a cte immediately after creating it, lets you query something that needs to be queried first (generally clearer than a subquery)
CTE's are better to read compared to subqueries
YOU can override column names and set them before, only works if you pass in enough column names as columns
*/

With CTE_example (Gender, AVG_SAL, MAX_SAL, MIN_SAL, COUNT_SAL) as 
(
select gender, avg(salary), max(salary), min(salary), count(salary)
from employee_demographics as dem
join employee_salary as sal 
	on dem.employee_id = sal.employee_id
group by gender
)
select * from CTE_example;

#Doing with  Subquery 
select avg(avg_sal) from (
select gender, avg(salary) as avg_sal, max(salary) as max_sal, min(salary) as min_sal, count(salary) as count_sal
from employee_demographics as dem
join employee_salary as sal 
	on dem.employee_id = sal.employee_id
group by gender
) as sub_query_example;
 
#select avg(avg_sal) from CTE_example; #This produces an error message because a cte isn't a permanent object. It's really a query
 
 #Creating Multiple CTE's within one query
With CTE_example1 as 
(
select employee_id,gender,birth_date
from employee_demographics as dem
where birth_date > '1985-01-01'
),
CTE_example2 as 
(select employee_id,salary from employee_salary
where salary > 50000
)
select * from CTE_example1 
join CTE_example2 
	on CTE_example1.employee_id = cte_example2.employee_id;