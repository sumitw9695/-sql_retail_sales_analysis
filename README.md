# Project: Retail Sales Analysis with SQL

## Project Overview

**Project Title**: Retail Sales Analysis based on Sales
**Level**: Beginner  
**Database**: `projectportfolio`

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `projectportfolio`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
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
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
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
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2023-09-09'**
```sql
select *
from retail_sales
where sale_date = '2023-09-09';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Electronics' and the quantity sold is more than 2 on 2023-12-24**
```sql
SELECT 
*
FROM retail_sales
WHERE 
    category = 'Electronics'
    AND 
    sale_date  = '2023-12-24'
    AND
    quantity >= 2
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**
```sql
Select
	category,
    SUM(total_sale) as net_Sale,
    COUNT(*) as total_orders
from retail_sales
group by 1; 
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**
```sql
SELECT
    ROUND(AVG(age), 2) as avg_age
FROM retail_sales
WHERE category = 'Beauty'
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1500.**
```sql
select *from retail_sales
 where total_sale > 1500;
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**
```sql
select
	category,
    gender,
    COUNT(*) as total_transaction
from retail_sales
GROUP BY
		category,
        gender
ORDER BY 1
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.**
```sql
SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank = 1
```

8. **Write a SQL query to find the top 10 customers based on the highest total sales.**
```sql
SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
select
 category,
 count(distinct customer_id) as count_unique_customer_id
from retail_sales
group by category
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17).**
```sql
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
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Beauty, Clothing and Electronics.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1500, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.
