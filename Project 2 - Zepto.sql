# SQL PROJECT 2 - Zepto
USE Projects;
Select * from zepto;

-- Data Exploration
# Count of rows
select count(*) from zepto;

# Sample Data
select * from zepto
limit 10;

# Null Values
select * from zepto
where category is null or
'name' is null or
mrp is null or
discountPercent is null or
availableQuantity is null or
discountedSellingPrice is null or
weightInGms is null or
outOfStock is null or
quantity is null; 

# Different Product Categories
select distinct(category) from zepto
order by category;

# Products In Stock v/s Out Of Stock
select outOfStock, count(*) from zepto
group by outOfStock;

# Products name present multiple times
Select name, count(*) as 'numbers'
from zepto
group by name
having count(*) > 1
order by numbers desc;

-- Data Cleaning
# Products with price = 0
select * from zepto
where mrp = 0 or discountedSellingPrice = 0;

delete from zepto
where mrp = 0 or discountedSellingPrice = 0;

# Convert the Price to rupees from paise
select round(mrp/100,2),round(discountedSellingPrice/100,2)  from zepto;

update zepto
set mrp = round(mrp/100,2), discountedSellingPrice = round(discountedSellingPrice/100,2);

-- Business Insight Queries
#1. Find the top 10 best- value products based on the discount percentage.
select * from zepto
order by discountedSellingPrice desc limit 10;

#2. What are the products with high mrp but out of stock?
Select distinct name, mrp from zepto
where outOfStock = 'True' and mrp > 50
order by mrp desc; 

#3. Calculate revenue for each category.
select category, sum(discountedSellingPrice * availableQuantity) as 'Total_revenue' from zepto
group by category;

#4. Find all the products where MRP is greater than ₹500 and discount is less than 10%.
select * from zepto
where mrp > 500 and discountPercent < 10;  

#5. Identify the top 5 categories offering highest average discount percentage.
select category, round(avg(discountPercent)) as 'Avg_Discount_percentage' from zepto
group by category
order by Avg_Discount_percentage desc limit 5;

#6. Find the price per gram for products above 100g and sort by best value.
select name,round(discountedSellingPrice/weightinGms,2) as 'price_per_gram' from zepto
where weightinGms >= 100
order by price_per_gram desc;

#7. Group the products into categories like low, medium and bulk.
Select name, weightingms,
CASE
		WHEN weightInGms < 1000 THEN 'Low'
		WHEN weightInGms < 5000 THEN 'Medium'
		ELSE 'Bulk'
		END AS 'weight_category'
from zepto;

#8. What is the total inventory Weight Per Category?
Select category, sum(weightinGms * availableQuantity) as 'Total_weight' from zepto
group by category
order by Total_weight desc;