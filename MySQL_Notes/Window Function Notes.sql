-- Window Function Notes
/*
Similar to group by function but it keeps unique rows in output
OVER() keyword defines that you are using a window function
partition by is used inside the over(), defines what you are grouping by 
Use over group by: It allows you to retain other columns that wouldn't normally be aggregatable while still creating a column of an aggregated value(s)
Rolling Totals can be created using Order By inside the over() window function
*/

select gender, avg(salary) from employee_demographics as dem          #Doing this with group by function
inner join employee_salary as sal  
	on dem.employee_id = sal.employee_id   
group by gender;

select gender, avg(salary) over(partition by gender) from employee_demographics as dem     #doing this with the window functions
inner join employee_salary as sal  
	on dem.employee_id = sal.employee_id;
    
    
select dem.first_name, dem.last_name, gender, avg(salary) over(partition by gender) 
from employee_demographics as dem     #advantage over group by: Lets me add columns into the table that normally wouldnt be aggregatable
inner join employee_salary as sal  
	on dem.employee_id = sal.employee_id;
    
#Will not allow multiple columns to be aggregated though See as follows:    
select dem.first_name, dem.last_name, gender, sum(salary), avg(salary) over(partition by gender) 
from employee_demographics as dem     
inner join employee_salary as sal  
	on dem.employee_id = sal.employee_id;    
    
#rolling total (adding starting at one place and ending at another place) can do without the partioning of gender, just call over(order by)
select dem.first_name, dem.last_name, gender, salary, sum(salary) over(partition by gender ORDER BY dem.employee_id) as rolling_total
from employee_demographics as dem    
inner join employee_salary as sal  
	on dem.employee_id = sal.employee_id;
  
-- Side testing, allowed to add extra columns after everything by adding a comma after the *. 
select *,salary/617000 as proportion from (select dem.first_name, dem.last_name, gender, salary, sum(salary) over(partition by gender) as rolling_total
from employee_demographics as dem    
inner join employee_salary as sal  
	on dem.employee_id = sal.employee_id) as proportion;
    
-- Row Number and Rankings
# Row numbers basically add an index, Must be used with an Over() window function. To group by a category, use a partition by
select dem.employee_id, dem.first_name, dem.last_name, gender, salary, 
row_number() over(partition by gender)#This counts only in groups of gender (female and male)
from employee_demographics as dem
inner join employee_salary as sal
	on dem.employee_id = sal.employee_id;

#You can add an order by so that the row numbers represent something being the nth place, however for this task use Rank() see below 
select dem.employee_id, dem.first_name, dem.last_name, gender, salary, 
row_number() over(partition by gender Order by Salary Desc) as 'Salary Row Number Gender', 
rank() over(partition by gender Order by Salary Desc) as 'Salary Rank Gender',  #The difference is that ties among the partition are counted as equal "ranks".
																				#in this example two people are tied for 50,000 so they both have a rank of 5, only seen with rank() and not row number
Dense_Rank()  over(partition by gender Order by Salary Desc) 'Dense Rank' #Makes it so when ties happen it doesnt skip a number, if there are two 5ths then the 7th person would be 6th in dense rank
from employee_demographics as dem         
inner join employee_salary as sal
	on dem.employee_id = sal.employee_id
    

