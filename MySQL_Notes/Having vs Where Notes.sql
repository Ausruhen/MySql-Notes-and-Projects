-- Having vs Where Notes
/*
Having vs where syntax:
Having filters columns that are created using an aggregate function (count, avg, min/max, etc). The having clause will ALWAYS come after the group by statement
The where clause will always come before the group by statement. Used to filter rows BEFORE aggregation 

WHERE FILTERS  BEFORE AGGREGATION
HAVING FILTERS AFTER AGGREGATION
*/

Select gender, avg(age)
from employee_demographics
where avg(age) > 40   #This wont work because sql has not yet created the avg(age) column as its created in the group by call.
group by gender;      #Where does not work with things that have been or will be aggregated. 

Select gender, avg(age)
from employee_demographics
group by gender                #Having is used over where for group by scenarios. Use having if 
Having avg(age) > 40;		   #you want to filter a column of aggregate values that were created with group by

select * 
from employee_salary;

select occupation, avg(salary)
from employee_salary
where occupation like '%manager%'   #This works because were filtering all the rows that are managers. It's an unaggregated row
group by occupation        
having avg(salary) > 75000;         #Works because salary is an aggregated row. Placed after the group by statement. 

