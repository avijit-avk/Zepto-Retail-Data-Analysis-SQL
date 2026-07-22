# 🛒 Zepto Retail Data Analysis using SQL

## 📌 Project Overview

This project analyzes Zepto's grocery product dataset using **MySQL** to extract business insights related to pricing, discounts, inventory, and product categories.

The project follows a complete SQL analytics workflow including:

- Data Exploration
- Data Quality Assessment
- Data Cleaning
- Exploratory Data Analysis
- Business Insight Generation

---

# 🎯 Business Objective

Analyze Zepto's product catalog to answer key business questions such as:

- Which categories generate the highest revenue potential?
- Which products offer the best customer value?
- Which premium products are unavailable?
- Which categories provide the highest discounts?
- How can pricing and inventory decisions be improved?

---

# 🛠 Tech Stack

- MySQL
- SQL
- CSV Dataset

---

# 📂 Dataset

The dataset contains product-level information including:

- Product Name
- Category
- MRP
- Discounted Selling Price
- Discount Percentage
- Available Quantity
- Product Weight
- Inventory Status

---

# 🧹 Data Cleaning

Before analysis, several data quality checks were performed.

### ✔ Checked for NULL values

```sql
SELECT *
FROM zepto
WHERE Category IS NULL
   OR name IS NULL
   OR mrp IS NULL
   OR discountPercent IS NULL
   OR availableQuantity IS NULL
   OR discountedSellingPrice IS NULL
   OR weightInGms IS NULL
   OR outOfStock IS NULL
   OR quantity IS NULL;
```

### ✔ Identified Duplicate Products

```sql
SELECT
    name,
    COUNT(name)
FROM zepto
GROUP BY name
HAVING COUNT(*) > 1
ORDER BY 2 DESC;
```

### ✔ Removed Invalid Records

```sql
DELETE FROM zepto
WHERE mrp = 0
   OR discountedSellingPrice = 0;
```

---

# 📊 Business Questions & SQL Solutions

## 1️⃣ Find the top 10 best-Value products based on the discount percentage ?

```sql
SELECT 
	DISTINCT name,
    Category,
    mrp,
    discountPercent
FROM
    zepto
ORDER BY discountPercent DESC
LIMIT 10;
```

**Business Insight**

Identifies products providing the highest discounts, helping evaluate promotional strategies and customer value.

---

## 2️⃣ What are the products with high mrp but currently out of stock?

```sql
SELECT
    name,
    category,
    mrp,
    discountedSellingPrice
FROM zepto
WHERE outOfStock = TRUE
  AND mrp > 500
ORDER BY mrp DESC;
```

**Business Insight**

Highlights expensive products that are unavailable, helping inventory teams prioritize replenishment.

---

## 3️⃣ Find the highest estimated revenue of each category?

```sql
SELECT 
    Category,
    SUM(discountedSellingPrice * availableQuantity) AS revenue
FROM
    zepto
GROUP BY Category
ORDER BY revenue;
```

**Business Insight**

Estimates the revenue contribution of each category based on selling price and available inventory.

---

## 4️⃣ Which expensive products receive very little discount? (mrp is grater then rs. 500 and discount is less than 10%)

```sql
SELECT DISTINCT
    name, mrp, discountPercent
FROM
    zepto
WHERE
    mrp > 500 AND discountPercent < 10
ORDER BY mrp DESC , discountPercent DESC;
```

**Business Insight**

Identifies premium-priced products with limited discounts, providing insight into pricing strategy.

---

## 5️⃣ Which categories offer the highest average discount?

```sql
SELECT 
    Category,
    ROUND(AVG(discountPercent), 2) AS avg_discount_percent
FROM
    zepto
GROUP BY Category
ORDER BY avg_discount_percent DESC
LIMIT 5;
```

**Business Insight**

Highlights categories where promotional offers are most aggressive.

---

## 6️⃣ Which products provide the best value based on price per gram?

```sql
SELECT
    name,
    weightInGms,
    discountedSellingPrice,
    ROUND(discountedSellingPrice/weightInGms,2) AS price_per_gram
FROM zepto
WHERE weightInGms > 100
ORDER BY price_per_gram;
```

**Business Insight**

Calculates unit pricing to identify products offering the best value for money.

---

## 7️⃣ Segment products by package size

```sql
SELECT
    DISTINCT name,
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
```

**Business Insight**

Segments products into meaningful size groups for inventory and pricing analysis.

---

# 📈 Key Insights

- Performed data quality assessment before analysis.
- Cleaned invalid pricing records to improve data reliability.
- Estimated revenue potential across product categories.
- Identified premium products that were unavailable despite high prices.
- Compared category-level discount strategies.
- Evaluated product value using price-per-unit analysis.
- Applied SQL to solve business-focused analytical questions.

---

# 💼 Skills Demonstrated

- SQL
- Data Cleaning
- Data Validation
- Exploratory Data Analysis
- Aggregate Functions
- CASE Statements
- Filtering
- Sorting
- GROUP BY
- HAVING
- Business Analytics

---

# 🚀 Repository Structure

```
Zepto-Retail-Data-Analysis-SQL/
│
├── Dataset/
│   └── zepto_v2.csv
│
├── SQL/
│   └── Zepto-analysis.sql
│
├── README.md
```

---

# 👤 Author

**Avijit Kumar**

- LinkedIn: https://linkedin.com/in/kumar-avijit
- GitHub: https://github.com/avijit-avk
