-- Unions Notes
/*
#Unions allow different rows to be combined together
#They literally let the tables get stacked right on top of eachother
#By default a union is "union distinct" meaning that the values that are the same are only shown in one row, change with Union ALL to show everything
*/

select first_name, last_name from employee_demographics
union all
select first_name, last_name  #column names are the columns in the first select statement
from employee_salary;

#Use case
select first_name, last_name, "Old Male" As Label from employee_demographics
where age > 40 and gender = "male"
Union
select first_name, last_name, "Old woman" As Label from employee_demographics
where age > 40 and gender = "female"
Union
select first_name, last_name, "Highly Paid" as Label from employee_salary
where salary > 70000
order by first_name, last_name;
