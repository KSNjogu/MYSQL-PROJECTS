-- Exploratory Data Analysis

select *
from layoffs_staging2
where percentage_laid_off = 1
order by funds_raised_millions desc;

select company , sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

select min(`date`), MAX(`date`)
FROM layoffs_staging2;

select industry , sum(total_laid_off)
from layoffs_staging2
group by industry
order by 2 desc;

select *
from layoffs_staging2;

select country , sum(total_laid_off)
from layoffs_staging2
group by country
order by 2 desc;

select YEAR(`date`) , sum(total_laid_off)
from layoffs_staging2
group by YEAR(`date`)
order by 2 desc;

select stage , sum(total_laid_off)
from layoffs_staging2
group by stage
order by 2 desc;

select stage , sum(total_laid_off)
from layoffs_staging2
group by stage
order by 2 desc;

-- progression of layoffs

select *
from layoffs_staging2;

select substring(`date`, 1 , 7) as `MONTH`, sum(total_laid_off)
from layoffs_staging2
where substring(`date`, 1 , 7) is not NULL
group by `MONTH`
order by `MONTH` asc;
;
-- Rolling total by month
with Rolling_Total as 
(
select substring(`date`, 1 , 7) as `MONTH`, sum(total_laid_off) as total_off
from layoffs_staging2
where substring(`date`, 1 , 7) is not NULL
group by `MONTH`
order by `MONTH` asc
)
select `MONTH`, total_off , sum(total_off) over(order by `MONTH`) as rolling_total
from Rolling_Total;


select company, year(`date`), sum(total_laid_off)
from layoffs_staging2
group by company,year(`date`)
order by 3 desc;

-- Ranking the top 5 companies that laid off the most people per year 

WITH Company_Year (company, years, total_laid_off) as 
(
select company, year(`date`), sum(total_laid_off)
from layoffs_staging2
group by company,year(`date`)
), Company_Year_Rank AS
(
select *, 
DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off desc) as Ranking
from Company_Year
WHERE years IS NOT NULL
)
select *
from Company_Year_Rank 
where Ranking <= 5;













