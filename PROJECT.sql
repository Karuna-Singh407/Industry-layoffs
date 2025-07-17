use layoffs;

-- Data Cleaning

-- 1. Removal of duplicates
-- 2. Standardise the data
-- 3. Null values or blank values
-- 4. Remove columns or rows


create table layoffs_staging 
like layoffs_data;
insert into layoffs_staging 
select * 
from layoffs_data;
select * from layoffs_staging;
alter table layoffs_staging 
drop column source;
alter table layoffs_staging 
drop column date_added;
alter table layoffs_staging 
drop column list_of_employees_laid_off;

select *, row_number() over( 
partition by company,location_hq,industry,laid_off_count,date,funds_raised,stage,country,percentage) as row_num
from layoffs_staging;
with duplicate_cte as
(select *,row_number() over(
partition by company,location_hq,industry,laid_off_count,date,funds_raised,stage,country,percentage) as row_num 
from layoffs_staging)
select *
from duplicate_cte
 where row_num > 1;
 select * from layoffs_staging where company='casper';
CREATE TABLE `layoffs_staging2` (
  `Company` text,
  `Location_HQ` text,
  `Industry` text,
  `Laid_Off_Count` text,
  `Date` text,
  `Funds_Raised` double DEFAULT NULL,
  `Stage` text,
  `Country` text,
  `Percentage` text,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
select * from layoffs_staging2;
insert into layoffs_staging2
select *,row_number() over(
partition by company,location_hq,industry,laid_off_count,date,funds_raised,stage,country,percentage) as row_num 
from layoffs_staging;
delete from layoffs_staging2 where row_num>1;
select * from layoffs_staging2 where row_num>1;

-- Standardizing data
 select company,trim(company)
 from layoffs_staging2;
update layoffs_staging2
set company = trim(company);

 select distinct industry
 from layoffs_staging2
 order by 1;
 select * from layoffs_staging2 
 where industry like 'crypto%';

update layoffs_staging2
set industry='crypto'
where industry like 'crypto%';

select distinct location_hq 
from layoffs_staging2 order by 1;

select distinct country
from layoffs_staging2 order by 1;
select date ,
str_to_date ( date,'%Y-%m-%d')
from layoffs_staging2;
update layoffs_staging2
set date= str_to_date ( date,'%Y-%m-%d');

alter table layoffs_staging2
modify column date DATE;

select * from layoffs_staging2
where Laid_Off_Count ='';

select * from layoffs_staging2
where Laid_Off_Count ='' and percentage='';
select * from layoffs_staging2
where industry is null or industry='';
update layoffs_staging2
set laid_off_count=NULL
where laid_off_count ='';
update layoffs_staging2
set percentage=NULL
where percentage ='';
delete from layoffs_staging2
where Laid_Off_Count is null and percentage is null;

select * from layoffs_staging2
where Laid_Off_Count is null and percentage is null;
alter table layoffs_staging2
drop column row_num;
select * from layoffs_staging2;

-- Exploratory Data Analysis

select * from layoffs_staging2;
select max(laid_off_count),max(percentage)
 from layoffs_staging2;
 alter table layoffs_staging2
 modify Laid_Off_Count int;
select * from layoffs_staging2 where Percentage= (select max(Percentage) from layoffs_staging2
) order by Laid_Off_Count desc;
select * from layoffs_staging2 where Percentage= (select max(Percentage) from layoffs_staging2
) order by funds_raised desc;
select company,sum(laid_off_count)
from layoffs_staging2
group by company
order by 2 desc;
select min(date),max(date)
from layoffs_staging2;
select industry,sum(laid_off_count)
from layoffs_staging2
group by industry
order by 2 desc;
select country,sum(laid_off_count)
from layoffs_staging2
group by country
order by 2 desc;
select date,sum(laid_off_count)
from layoffs_staging2
group by date
order by 2 desc;
select year(date),sum(laid_off_count)
from layoffs_staging2
group by year(date)
order by 2 desc;
select stage,sum(laid_off_count)
from layoffs_staging2
group by stage
order by 2 desc;
select company,avg(percentage)
from layoffs_staging2
group by company
order by 2 desc;

select substring(date,1,7) as month, sum(laid_off_count)
from layoffs_staging2
group by month
order by 1 asc;

select * from layoffs_staging2;
with rolling_total as
(select substring(date,1,7) as month, sum(laid_off_count) as layoff
from layoffs_staging2
group by month
order by 1 asc)
select month,layoff,sum(layoff) over(order by month) as rolling_total
from rolling_total;

select company,year(date),sum(laid_off_count)
from layoffs_staging2
group by company,year(date)
order by company;

with company_year(company,year,laid_off_count) as
(select company,year(date),sum(laid_off_count)
from layoffs_staging2
group by company,year(date))
select *,dense_rank() over (partition by year order by laid_off_count desc) as ranking
 from company_year
 where year is not null
 order by ranking;

with company_year(company,year,laid_off_count) as
(select company,year(date),sum(laid_off_count)
from layoffs_staging2
group by company,year(date)), company_year_rank as
(select *,dense_rank() over (partition by year order by laid_off_count desc) as ranking
 from company_year
 where year is not null)
 select * from company_year_rank
 where ranking<=5;
































