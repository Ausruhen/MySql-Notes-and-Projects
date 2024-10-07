/*
Events and Triggers

Start with a delimter because theres going to multiple lines of code

KEYWORDS: After - keyword to specify to do something AFTER an event occurs (usually used in combination with something)
BEFORE - keyword to specify to do something BEFORE an event occurs (used in data deletion as example)
FOR EACH ROW - Keyword sequence that signifies how many times the trigger will occur. Generally found in my SQL
NEW: used to specify with values 
*/

-- TRIGGERS
DELIMITER $$ 
Create trigger employee_insert  
	AFTER INSERT ON employee_salary
	FOR EACH ROW #Determines how many times we want to insert (once for each row)
Begin     #this section determines whats actually going to happen for the trigger
	INSERT INTO employee_demographics(employee_id, first_name, last_name)
	VALUES (NEW.employee_id, NEW.first_name, NEW.last_name);
End $$
DELIMITER ;

#INSERT into employee_salary(employee_id, first_name, last_name, occupation, salary, dept_id)
#VALUES(14, "Jean", "Ho", "Entertainment 720_ceo", 1000000, Null);

select * from employee_salary;

-- EVENTS


Select * from employee_demographics;
Delimiter $$
CREATE EVENT delete_retirees
ON schedule every 30 second
DO
BEGIN
	Delete from employee_demographics
    where age >= 60;
END $$
Delimiter ; 
