-- Case Statements Notes
/*
Allows us to use/make logicial if/else statements
Can have multiple when statements 
ALWAYS START BY SAYING CASE
*/

select first_name, last_name, age,
CASE                                #start statement by saying case
	when age <= 30 Then 'Young'     #tabs dont matter but good syntax uses them. 
    when age between 30 and 40 then 'medium' #allowed to have multiple 'when' statements
    else 'Old'                      #else statements are same as always
End as age_bracket
From employee_demographics;

#goal: determine EOY salary and add it into the table, + a bonus if they received one, and the pay increase into their salary
#rules, finance got a 10% bonus, <50000 salary 5% increase, >50000, 7% increase

select* from employee_salary;
select * from parks_departments;

select first_name, last_name, occupation, depart.department_name,
CASE
	when salary <50000 then salary * 1.05
    when salary >=50000 then salary * 1.07  #side andy note- directions werent clear for exactly 50000, was genereous
    End as 'New Salary',
CASE 
 when depart.department_name = 'finance' then salary * .1
 else 0
End as 'Bonus'

from employee_salary as sal
inner join parks_departments as depart
on sal.dept_id = depart.department_id;


