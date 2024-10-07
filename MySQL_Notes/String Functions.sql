-- String Functions; 
/*
length: returns length of the string
upper: returns the string in all upper case
lower: returns the string in all lower case
trim: trim, ltrim, rtrim: Removes the leading and trailing whitespace. Left trim only removes left whitespace, right trim only removes right whitespace
Left: Returns how many characters from the left you give it. I.E: left("this is left",5) -> is left
Right: Same thign as left but from the right
Substring: Allows you to go reference a specific part of a string. I.E: substring("Testing", 3,2) -> st. Returns 2 characters, starting from the 3rd letter over
Replace: Replaces given character with a character that you would want, CASE SENSITIVE.  I.e replace("Testing, 't','z') -> Teszing. Replaces all characters
Locate: Returns the chracter/string location of a passed in character of a string. I.e locate("t", "testing) -> 4. If not in string returns 0. words with multiple characters returns position of first character
Concatenation: Allows you to merge strings together, can have multiple strings in one function
*/

select first_name,last_name, concat(first_name, " ",last_name) as full_name #Space is added so their is  space between first and last names, can have multiple concats
from employee_demographics;


Select length('skyfall');
select first_name, length(first_name) from employee_demographics
order by length(first_name);

Select first_name, Upper(first_name) from employee_demographics;

Select trim("         Testing    ");

select first_name, left(first_name,4), right(first_name,4), substring("testing",3,2), substring(birth_date,6,2) as months
from employee_demographics;

select first_name, replace(first_name, 'a', 'z') from employee_demographics;

select Locate("t" ,"Testing")
