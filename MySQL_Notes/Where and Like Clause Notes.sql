#Notes for Where Clause

select * from parks_and_recreation.employee_salary  #first table call
where first_name = "leslie";  #Not case sensitive, and can use either double quotes or single quotes, generally good practice to use single quote

select * from parks_and_recreation.employee_salary
where salary >= 50000;  #Typical boolean operators, main difference is that equal sign is just "=" not "==". 

select * from parks_and_recreation.employee_demographics
where birth_date > '1985-01-01'; #referencing a "date" object. In this case refercening greater than 1985 i.e born after 1985, january 1st

-- AND, OR, NOT -- #works as typical. Not is a negation operator searches the opposite of what is originally referenced

select * from parks_and_recreation.employee_demographics
where birth_date > '1985-01-01' 
or NOT gender = 'male'; #should find anyone born past 1985 january 1st or that aren't males

-- Multiple Referecing with Parenthesis -- 
SELECT 
    *
FROM
    parks_and_recreation.employee_demographics
WHERE
    (first_name = 'Leslie' AND age = 44)
        OR age > 55; #finds an entry with leslie and age 44, or entries with age > 55
        
-- Like Statement -- 
-- Uses the special operators "%" and "_" to search for sequences of characters. 
# % searches rows for string that have anything before or after given characters (depends on % placement). The % placement is where the free characters can 

# _ searches rows for strings that have anything in the underscore slot. Treated as a wildcard, that must be filled

select * from parks_and_recreation.employee_demographics 
where first_name like 'a%';  #finds all rows where first name starts with a 

select * from parks_and_recreation.employee_demographics 
where first_name like '%a';  #finds all rows where first name ends with a 

select * from parks_and_recreation.employee_demographics 
where first_name like '%a%';  #finds all rows that contains an a 


select * from parks_and_recreation.employee_demographics 
where first_name like 'a__';  #finds all rows that start with a and have two characters afterwards

#Can combine the % and Underscores
select * from parks_and_recreation.employee_demographics 
where first_name like 'a___%';  #finds all rows with at least two characters after the a. 