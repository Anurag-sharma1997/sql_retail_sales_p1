### 1. Database Setup

CREATE DATABASE sql_project_1

use sql_project_1

- **Table Creation**

CREATE TABLE retail_sales (
    transactions_id INT,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);

### 2. Data Exploration & Cleaning

FLUSH TABLES;

SELECT 
    *
FROM
    retail_sales;

- **Record Count**Determine the total number of records in the dataset.

SELECT 
    COUNT(*)
FROM
    retail_sales;


**Null Value Check**: Check for any null values in the dataset and delete records with missing data.


SELECT 
    *
FROM
    retail_sales
WHERE
    transactions_id IS NULL
        OR sale_date IS NULL
        OR sale_time IS NULL
        OR customer_id IS NULL
        OR gender IS NULL
        OR category IS NULL
        OR quantity IS NULL
        OR price_per_unit IS NULL
        OR cogs IS NULL
        OR total_sale IS NULL;

DELETE FROM retail_sales 
WHERE
    transactions_id IS NULL
    OR sale_date IS NULL
    OR sale_time IS NULL
    OR customer_id IS NULL
    OR gender IS NULL
    OR category IS NULL
    OR quantity IS NULL
    OR price_per_unit IS NULL
    OR cogs IS NULL
OR total_sale IS NULL;


**HOW MANY SALES WE HAVE?

SELECT 
    COUNT(*)
FROM
    retail_sales;

**Customer Count**: Find out how many unique customers are in the dataset.

SELECT 
    COUNT(DISTINCT (customer_id))
FROM
    retail_sales;

- **Category Count**: Identify all unique product categories in the dataset.

SELECT DISTINCT
    category
FROM
    retail_sales;

### 3. Data Analysis & Findings

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**

SELECT 
    *
FROM
    retail_sales
WHERE
    sale_date = '2022-11-05';

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:

SELECT 
    *
FROM
    retail_sales
WHERE
    category = 'Clothing' AND quantity >= 4
        AND sale_date BETWEEN '2022-11-01' AND '2022-11-30';
        
3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:

SELECT 
    category,
    SUM(total_sale) AS net_sales,
    COUNT(*) AS total_orders
FROM
    retail_sales
GROUP BY category;

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:

SELECT 
    ROUND(AVG(age), 2)
FROM
    retail_sales
WHERE
    category = 'Beauty';

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:

SELECT 
    *
FROM
    retail_sales
WHERE
    total_sale > 1000;
    
    6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
    
SELECT 
    category, gender, COUNT(*) AS total_transactions
FROM
    retail_sales
GROUP BY category , gender
ORDER BY category;

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:

SELECT * FROM
(
SELECT 
    YEAR(sale_date) AS year,
    MONTH(sale_date) AS month,
    SUM(total_sale) AS total_sale,
    round(AVG(total_sale),2) AS avg_sale,
    rank() over(partition by YEAR(sale_date) order by avg(total_sale) desc) as top
FROM
    retail_sales
GROUP BY year , month
) as t1
WHERE top = 1;

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:

SELECT 
    customer_id, SUM(total_sale) AS total_sale
FROM
    retail_sales
GROUP BY customer_id
ORDER BY total_sale DESC
LIMIT 5;

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:

SELECT 
    category, COUNT(DISTINCT customer_id) AS unique_customer
FROM
    retail_sales
GROUP BY category;

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:

WITH hourly_sale AS
(
SELECT * ,
			CASE
			WHEN hour(sale_time) < 12 THEN "morning"
			WHEN  hour(sale_time) < 12 BETWEEN 12 and 17 THEN "afternoon"
			ELSE "evening"
			END AS shift FROM retail_sales
)
SELECT shift, count(*) AS total_orders
 FROM hourly_sale 
 GROUP BY shift;


------END------------------------------------------------------------------------------------------------------------------------------------------------------------------------