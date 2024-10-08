-- Exploratory Data Analysis 

select max(total_laid_off), max(percentage_laid_off)
from layoffs_staging2;

select * from layoffs_staging2
where percentage_laid_off = 1
order by total_laid_off DESC; #these are companies that laid off everybody ordered by most employees

select * from layoffs_staging2
where percentage_laid_off = 1
order by funds_raised_millions DESC; 

select company, sum(total_laid_off) 
from layoffs_staging2
group by company #orders companies by how many workers they laid off in the timeframe of data collection
order by 2 Desc; 

select min(`date`), max(`date`)
from layoffs_staging2; #that time frame mentioned above is 3 years (seen here)

select industry, sum(total_laid_off)
from layoffs_staging2
group by industry   #given that this was taken during the pandemic these results aren't very surprsing
order by 2 Desc;

select country, sum(total_laid_off)
from layoffs_staging2
group by country  #USA hit very hard
order by 2 Desc;  

select YEAR(`date`), sum(total_laid_off)
from layoffs_staging2
group by YEAR(`date`)   #consider that we only had data for the first three months of 2023
order by 1 Desc;

select stage, sum(total_laid_off) from layoffs_staging2
group by stage
order by 2 Desc;

select stage, avg(percentage_laid_off) from layoffs_staging2
group by stage    #these top fields are the ones that you REALLY don't want to be in
order by 2 desc;

select(`date`) from layoffs_staging2; #to help me see which is each month for next query

select substring(`date`, 1,7) as `month`, sum(total_laid_off)  #were now seeing months win a particular year
from layoffs_staging2
where substring(`date`, 6,2) is not NUll
group by `month` #this allows to see seasonal trends by year, 
order by `month`; 

With rolling_total as (

select substring(`date`, 1,7) as `month`, sum(total_laid_off) as total_laid_off #were now seeing months win a particular year
from layoffs_staging2
where substring(`date`, 6,2) is not NUll
group by `month` #this allows to see seasonal trends by year, 
order by `month` 
)
select `month`, total_laid_off, sum(total_laid_off) OVER (order by `month`) as rolling_total
from rolling_total;  #this is a rolling total for the layoffs with total people laid off for each month

#damn what happened in january of 2023 that nearly 85000 were laid off
#i'm going to look at the indsutry and companies then for those months
select company, industry, total_laid_off from layoffs_staging2
where `date` like '2023-01%'
order by 3 DESC;

select industry, sum(total_laid_off) from layoffs_staging2
where `date` like '2023-01%'
group by industry
order by 1 DESC; 
/*
it seems like our data is a little bit flawed because there is no "tech" industry category.
after exploring a little bit what happened on google, it seems that this was a time
for massive tech layoffs with companies predicting an incoming recession following covid recovery
so they laid off workers in attempts to keep payroll costs low. 
*/

#lets look at specific companies now
select company, YEAR(`date`), sum(total_laid_off) from layoffs_staging2
group by company, YEAR(`date`) order by 3 Desc;
#amazon taking two spots in the top 6 is crazy (be scared if you work there)

With company_year (company, years,total_laid_off) as
(select company, YEAR(`date`), sum(total_laid_off) from layoffs_staging2
group by company, YEAR(`date`) 
order by 3 Desc
), company_year_ranks as
(select *, dense_rank() over(partition by years order by total_laid_off desc)as ranking
from company_year
where years is not null #this query ranks companies by who laid off the most people in each year
order by ranking asc    #do it as a cte again so we can filter twice in mysql
)
select * from company_year_ranks  
where ranking <=3;  #did this because I didn't want all that information  












