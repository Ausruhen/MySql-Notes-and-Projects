SELECT 
    *
FROM
    parks_and_recreation.employee_demographics;  #by referencing with periods you can reference this table from outside the database
                                                  #Without the schema being highlighted black, good practice for all queries
SELECT 
    first_name, last_name, birth_date, age, age + 10
FROM
    parks_and_recreation.employee_demographics;
#for operators everything will follow pemdas

SELECT DISTINCT  #for distinct, it will search for all unique values. If given more than one columns, will search for all unique combinations
    first_name, gender
FROM
    parks_and_recreation.employee_demographics;


