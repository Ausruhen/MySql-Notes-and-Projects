-- Group By Notes
-- Aggregate Function list: AVG, MAX, MIN --

select * from parks_and_recreation.employee_demographics; 

select gender, min(age), max(age), count(age)
from employee_demographics            #GROUP BY FUNCTION WONT WORK WHEN YOU CALL IT ON A TABLE WITH VALUES THAT CANT BE AGGREGATED
group by gender; #group by finds unique values to make categories (rows) and then takes an aggregate function to dispaly values. You can aggregate mutliple things at once

select occupation, salary
from employee_salary
group by occupation, salary; #you can group by multiple clauses. Notice there are two office manager rows, because there are two salaries for them

-- ORDER BY NOTES
#always done in ascending order (smallest to largest). In case of strings "smallest" is a. Toggle Largest to smallest by specifying descending (DESC)

select * from employee_demographics
order by first_name DESC;  

#you can order by multiple clauses at once: 
select * from employee_demographics
order by gender desc, age DESC;   #Desc order must be applied to each order statement, ex: gender and age. 
									#You priortize sorting order by saying what you want ordered first, in this case gender then age. 
                                    
#You can also call the order by functions with column numbers (BAD PRACTICE) Example as follows
select * from employee_demographics
order by 5,4  #gender is fifth column, age is fourth column. ONCE AGAIN DO NOT USE, but be aware