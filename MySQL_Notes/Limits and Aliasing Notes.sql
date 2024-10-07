-- Limits and Aliasing 

/*  LIMITS
Limit keyword lets us designate how many rows of our output that we want
If you pass through 2 numbers, i.e limit n,k, it will output k rows, starting from the n + k row down. It goes down n rows, and then outputs the next k number of rows. 
Mainly used in combination with the order by function
*/

select * from employee_demographics;

select * from employee_demographics
order by age desc
limit 3;

select * from employee_demographics
order by age desc
limit 2,1;  #will return 1 row (k rows) starting from the third row (n + k == 2 + 1)

/* ALIASING
Alias lets you rename columns.  Do this with the "as" clause
Also used for joins (as of 8/22 I am not there yet)
*/

select gender, avg(age) as 'example_name'  #it being a string is not necessary, I find it helps for reading my code
from employee_demographics              #produces a table where instead of avg(age) as a column name its now 'example_name'
group by gender;


