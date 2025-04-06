-- SQL Retail sales analysis
-- select database
use projectportfolio;

-- Creating table

drop table if exists retail_sales;
create table retail_sales
(
transactions_id int primary key,
	sale_date date,
    sale_time time,
    customer_id	int,
    gender varchar(10),
    age	int,
    category varchar (20),
    quantiy	int,
    price_per_unit float,
	cogs float,
    total_sale float);

ALTER TABLE retail_sales
CHANGE quantiy quantity int;

select * from retail_sales;

-- Checking Null values

select * from retail_Sales
where transactions_id is NULL;

select * from retail_Sales
where sale_date is NULL;

select * from retail_Sales
where sale_time is NULL;

select * from retail_Sales
where 
transactions_id is NULL
or
sale_date is NULL
or
sale_time is NULL
or
gender is NULL
or
category is NULL
or
quantity is NULL
or
cogs is NULL
or
total_sale is NULL;

-- Data explorations

-- How many sales we have ?
select count(*) as total_sale from retail_Sales

-- How many customers we have ?

select COUNT(distinct customer_id) as total_sale from retail_Sales

-- How many categories we have ?

select COUNT(distinct category) as total_sale from retail_Sales

-- Data Analysis & Business key problems and answer

--Write a SQL query to retrieve all columns for sales made on '2023-09-09'

select *
from retail_sales
where sale_date = '2023-09-09';

-- Write a SQL query to retrieve all transactions where the category is 'Electronics' and the quantity sold is more than 2 on 2023-12-24:

SELECT 
*
FROM retail_sales
WHERE 
    category = 'Electronics'
    AND 
    sale_date  = '2023-12-24'
    AND
    quantity >= 1
    
-- Write a SQL query to calculate the total sales (total_sale) for each category.

Select
	category,
    SUM(total_sale) as net_Sale,
    COUNT(*) as total_orders
from retail_sales
group by 1; 

-- Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT
    ROUND(AVG(age), 2) as avg_age
FROM retail_sales
WHERE category = 'Beauty'

-- Write a SQL query to find all transactions where the total_sale is greater than 1000.

select *from retail_sales
 where total_sale > 1000;
 
 -- Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
select
	category,
    gender,
    COUNT(*) as total_transaction
from retail_sales
GROUP BY
		category,
        gender
ORDER BY 1
 
 -- Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

select
	extract(year from sale_date) as year,
    extract(month from sale_date) as month,
avg(total_sale) as avg_sales
from retail_sales
group by 1,2
order by 1,2 asc

-- Write a SQL query to find the top 5 customers based on the highest total sales 
select
	customer_id,
    sum(total_sale) as total_sales
from retail_sales
group by 1
order by 1,2 desc
limit 5

-- Write a SQL query to find the number of unique customers who purchased items from each category.

select
 category,
 count(distinct customer_id) as count_unique_customer_id
from retail_sales
group by category

-- Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
WITH hourly_sale
as
(
select *,
	case
		when extract(hour from sale_time) < 12 then 'MORNING'
        when extract(hour from sale_time) between 12 and 17 then "Afternoon"
        Else 'Evening'
	end as shift
from retail_sales
)
select
	shift,
    count(*) as total_orders
from hourly_sale
group by shift

-- End