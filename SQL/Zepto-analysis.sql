Create Database Sql_zepto_project_2;
 
drop table if exists zepto;
CREATE TABLE zepto(
	sku_id INT AUTO_INCREMENT PRIMARY KEY,
	Category VARCHAR(120),
	name VARCHAR(100) NOT NULL,
	mrp	NUMERIC(8,2),
    discountPercent	NUMERIC(5,2),
    availableQuantity INTEGER,
    discountedSellingPrice NUMERIC(8,2),
    weightInGms	INTEGER,
    outOfStock VARCHAR(10),
    quantity INTEGER
);

-- Data Exploration

SELECT * FROM zepto
LIMIT 10;

SELECT COUNT(*) from zepto;

-- Null Values

SELECT * FROM zepto
WHERE (
		Category IS NULL
       OR name IS NULL
       OR mrp IS NULL
       OR discountPercent IS NULL
       OR availableQuantity IS NULL
       OR discountedSellingPrice IS NULL
       OR weightInGms IS NULL
       OR outOfStock IS NULL
       OR quantity IS NULL
       )
;       
       
-- Product categories
SELECT DISTINCT Category FROM zepto
ORDER BY 1;


SELECT Category,COUNT(Category) FROM zepto
GROUP BY Category;

-- products in stock and out of stock

SELECT outOfStock, COUNT(*) FROM zepto
GROUP BY outOfStock;

-- product names present multiple times

SELECT name, COUNT(name) FROM zepto
GROUP BY name
HAVING COUNT(*) > 1 
ORDER BY 2 DESC, name;

-- Data Cleaning

-- Products with price zero
SELECT * FROM zepto
WHERE mrp = 0 OR discountedSellingPrice = 0;

DELETE FROM zepto
WHERE mrp = 0 OR discountedSellingPrice = 0;

-- covert rpaise to rupee for mrp and discountedSellingPrice
UPDATE zepto
SET mrp = mrp*100;

UPDATE zepto
SET discountedSellingPrice = discountedSellingPrice/100;


-- Business Questions
-- Q1. Find the top 10 best-Value products based on the discount percentage

SELECT DISTINCT name,Category,mrp, discountPercent FROM zepto 
ORDER BY discountPercent DESC
LIMIT 10;

-- Q2. What are the products with high mrp but out of stock

SELECT * FROM zepto
WHERE outOfStock = 'TRUE'
ORDER BY mrp DESC;


-- Q3 Calculate Estimated revenue for each category

SELECT 
    Category, SUM(discountedSellingPrice * availableQuantity) AS revenue
FROM
    zepto
GROUP BY Category
ORDER BY revenue;

-- Q4 Find all products where mrp is grater then rs. 500 and discount is less than 10%

SELECT DISTINCT name, mrp, discountPercent FROM zepto
WHERE mrp > 500 AND discountPercent < 10
ORDER BY mrp DESC, discountPercent DESC;

-- Q5 Identify the top 5 categories offering the highest average discount percentage

SELECT Category, ROUND(avg(discountPercent),2) AS avg_discount_percent FROM zepto
GROUP BY Category
ORDER BY avg_discount_percent DESC
LIMIT 5;

-- Q6 Find the price per gram for products above 100g and sort by best value

SELECT DISTINCT name ,weightInGms, discountedSellingPrice, ROUND(discountedSellingPrice/weightInGms,2) AS price_per_gram FROM zepto
WHERE weightInGms > 100
ORDER BY price_per_gram;


-- Q7 Group the products into categories like low , medium , bulk

SELECT DISTINCT
    name,
    weightInGms,
    CASE
        WHEN weightInGms < 1000 THEN 'Low'
        WHEN weightInGms BETWEEN 1000 AND 5000 THEN 'Medium'
        WHEN weightInGms > 5000 THEN 'Bulk'
    END AS weight_category
FROM
    zepto
ORDER BY CASE
    WHEN weightInGms < 1000 THEN 1
    WHEN weightInGms BETWEEN 1000 AND 5000 THEN 2
    WHEN weightInGms > 5000 THEN 3
END;

-- Q8 What is total Inventory wieght per category

SELECT Category , ROUND(SUM(weightInGms*availableQuantity),2) AS inventory_weight FROM zepto
GROUP BY Category
ORDER BY inventory_weight;



