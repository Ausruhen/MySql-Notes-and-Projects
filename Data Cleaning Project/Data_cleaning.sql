-- Data Cleaning project

/*
General Steps for Data cleaning
1-- Remove Duplicates
2-- Standardize Data
3-- Correct/Examine Null/blank values
4-- Remove Any Irrelevant Columns (Usually dont do in raw datasets)
*/

-- STEP 1 Removing Duplicates
Create Table layoffs_staging
like layoffs;   #first start by creating a "staging", a copy of the data such that we keep the raw data untouched

insert layoffs_staging
select * from layoffs;

#now we work with the staging
select * from layoffs_staging;

select *, ROW_NUMBER() OVER(Partition By company, location, industry, total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num 
from layoffs_staging; #This adds numbers to the end of the row, will show a number greater than 2 if there's 2 exact rows. This shows us duplicates, which we will plan to delete

with duplicate_cte as 
(
select *, ROW_NUMBER() OVER(Partition By company, location, industry, total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num
from layoffs_staging
)
select * from duplicate_cte
where row_num > 1;  #lets us see examples of what would have a duplicate row using a common table expression

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT 
  
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;  #created by copying the table from the schemas tab

Insert into layoffs_staging2
select *, ROW_NUMBER() OVER(
Partition By company, location, industry, total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num
from layoffs_staging;

select * from layoffs_staging2
where row_num > 1; #checking if eevrything copied correctly

delete from layoffs_staging2
where row_num > 1;  #deletes everything that is a duplicate row

select * from layoffs_staging2
order by row_num DESC; #Checks to see if we failed at deleting anything or the logic was wrong

-- Step 2: standardizing our data 
/*
When standardizing the data, one of the first things we should do is look at each of the columns to see if we can 
eyeball general fixes. Some common things that are important are trimming white space, fixing duplicates (when necessary), and simplifying
the data if possible. 
*/

select distinct company from layoffs_staging2
order by 1;

UPDATE layoffs_staging2 #first we can trim our company strings, to make sure we dont have trailing or leading whitespace
set company = trim(company);

select distinct industry from layoffs_staging2
order by 1;  #lets us see distinct industries, we can check if anything needs to change

select * from layoffs_staging2  #after eyeballing it looks like there are multiple cryptos in the industry tab
where industry like 'Crypto%';

update layoffs_staging2
set industry = 'Crypto'
where industry like 'Crypto%';  #collapses all crypto related industry into 1 industry 

select distinct country from layoffs_staging2 
order by 1;  

update layoffs_staging2
set country = TRIM(trailing '.' from country) #removes period from the one cell that had a period in the US
where country like 'United_States%';

update layoffs_staging2
set `date` = str_to_date(`date`, '%m/%d/%Y'); #we can change the type of data to a datetime object

ALTER TABLE layoffs_staging2  #WHEN ALTERING TABLES YOU SHOULD ONLY ALTER STAGING TABLES
modify column `date` DATE;

-- Step 3: Dealing with the nulls

select * from layoffs_staging2
where total_laid_off is Null and percentage_laid_off is Null; #double nulls is pretty useless to us

#ideally we like to populate our data with things that we already know to be true (think self.joins)
select * 
from layoffs_staging2
where industry is null 
or industry = '';

select * from layoffs_staging2 #we saw airbnb had nothing in industry in above query so we check if it is populated somewhere
where company = "airbnb";

select * from layoffs_staging as st1
join layoffs_staging2 as st2
	on st1.company = st2.company #by joining on company and location we ensure that we are referring to the exact same company 
    and st1.location = st2.location #they could have the same names 
where (st1.industry is null or st1.industry = '') 
and st2.industry is not null;
							
update layoffs_staging2
set industry = null #we update all the blank values into nulls to make our next update smooth
where industry = '';

update layoffs_staging2 st1
join layoffs_staging2 st2
	on st1.company = st2.company
set st1.industry = st2.industry  #change all the nulls in industry to populate what we know
where (st1.industry is null) 
and st2.industry is not null;

select * from layoffs_staging2 #check to see if what we did works
where industry is null;
#we find a company still because there is no other entry, so it cannot self populate
#we can update later if necessary

select * from layoffs_staging2; 
/*
we can see that there are other null values in other columns, but we don't have info in this database
to populate those values (i.e if we had population, we could find total_laid_off and percentage_laid_off)
So instead we leave them blank
ideally at this point we consider what we plan to do with this data and ask ourselves if we must do
more work outside SQL to populate these null values, and if that is worth it for our end goal 
*/

-- Step 4: Removing Irrevelavant information
#always be careful deleting data, but cleaning useless rows out can increase our databases efficiency
#in this case I'm making the judgement call to remove rows that have nothing in both pop_laid_off and %_laid_off
delete from layoffs_staging2
where total_laid_off is Null
and percentage_laid_off is null;

Alter Table layoffs_staging2
Drop column row_num;  #we no longer need row_num (used originally for dupes)

