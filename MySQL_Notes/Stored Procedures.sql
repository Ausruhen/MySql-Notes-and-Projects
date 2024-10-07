-- Store Procedcures 
/*
Ways to save sql code to reuse. (Functions in sql)
-Great for storing complex queries, and for simplfying code
-To change an existing stored procedure right click on the stored procedure in navigation and select alter
-Parameters are the same in sql as they are in python (same term) (thing you pass into the function)
*/

#simple store procedure 
USE parks_and_recreation; #makes sure that the store procedure ends up in this database
Create Procedure large_salaries()
select * from employee_salary
where salary >= 50000;

call parks_and_recreation.large_salaries(); #calls this function specifically referencing the database
call large_salaries();  #if in data base already no need to call it like above

#Using multiple queries in one stored procedure
#you can change the delimiter before calling the procedure in order for sql to tell that you mean multiple queries

Delimiter $$ 
Create procedure Large_salaries2()
Begin
	select * from employee_salary
	where salary >= 50000;      #sql now knows that the semi colan isnt ending it
	select * from employee_salary
	where salary >= 10000; 
End $$
Delimiter ;  #After changing the delimiter, change it back (best practice) returns the rest of the script to factory defaults

CAll large_salaries2(); #This results in two outputs, can swap between them in the result tab 
call creating_with_m2();


#Creating a stored procedure with a variable
Delimiter $$ 
Create procedure large_salaries4(n INT)  #when doing this you must specify data type
Begin
	select * 
    from employee_salary
	where employee_id = n;      
End $$
Delimiter ; 


call large_salaries4(7);








