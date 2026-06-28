-- exploratory data analysis

select *
from layoffs_staging2;


select max(total_laid_off), max(percentage_laid_off)
from layoffs_staging2;

select *
from layoffs_staging2
where percentage_laid_off = 1
order by total_laid_off desc;

select company, sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 desc;


select min(`date` ), max(`date`)
from layoffs_staging2;

select industry, sum(total_laid_off)
from layoffs_staging2
group by industry
order by 2 desc;

select country, sum(total_laid_off)
from layoffs_staging2
group by country
order by 2 desc;

select year (`date`), sum(total_laid_off)
from layoffs_staging2
group by year (`date`)
order by 1 desc;

select stage, sum(total_laid_off)
from layoffs_staging2
group by stage
order by 2 desc;


select company, avg(percentage_laid_off)
from layoffs_staging2
group by company
order by 2 desc;




select substring(`date`,1,7) as `Month`, sum(total_laid_off)
from layoffs_staging2
where substring(`date`,1,7) is not null
group by `Month`
order by 1;

with Rolling_Total as 
(
select substring(`date`,1,7) as `Month`, sum(total_laid_off) as tot_off
from layoffs_staging2
where substring(`date`,1,7) is not null
group by `Month`
order by 1
)
select `Month` , tot_off,
sum(tot_off) over(order by `Month`) as Rol
from Rolling_Total;


select company, sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

select company, year(`date`) as D, sum(total_laid_off)
from layoffs_staging2
group by company, D
order by 3 desc;


with com_y (company, years, total_laid_off) as
(
select company, year(`date`) as D, sum(total_laid_off)
from layoffs_staging2
group by company, D
), company_year_rank as
(select *, dense_rank() over (partition by years order by total_laid_off desc) as ranking
from com_y
where years is not null)
select *
from company_year_rank
where ranking <= 5;

with industry_101  as
(
select industry, year(`date`) as D, sum(total_laid_off) as total_off
from layoffs_staging2
where industry is not null
group by D, industry
), industry_year_rank as
(
select *, dense_rank() over(partition by D order by industry) as `rank`
from industry_101)
select *
from industry_year_rank
where `rank` <=5;

