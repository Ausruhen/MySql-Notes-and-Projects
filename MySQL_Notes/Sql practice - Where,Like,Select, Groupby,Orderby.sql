SELECT 
    *
FROM
    parks_and_recreation.employee_demographics;

SELECT 
    *
FROM
    parks_and_recreation.employee_demographics
Where gender = 'Female'
Order By age Desc;

Select * from parks_and_recreation.employee_demographics
order by gender, age Desc;

select gender, avg(age),min(age), max(age)
from employee_demographics,  #This query wont work because of the comma after the from statement. Comma implies another table to pull from even though we dont mean to do that
group by gender;

Select gender, avg(age),min(age),min(age) 
from parks_and_Recreation.employee_demographics
GROUP BY gender;

Select distinct first_name,gender from employee_demographics; 

select * from employee_demographics
where (employee_id % 2 = 0);  #sql does not support checking by data type i.e where(employee_id / 2 = int). This produces a table where employee_id is even. 

select * from employee_demographics
where (first_name = "april" and age = 29) or gender = 'male';

select * from employee_demographics
where last_name like "_______%"; #this should check last names with at least 6 letters

