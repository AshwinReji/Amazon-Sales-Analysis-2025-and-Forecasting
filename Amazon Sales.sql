CREATE DATABASE AmazonSalesdb;
USE AmazonSalesdb;
DROP TABLE IF EXISTS Amazon_Sales;
CREATE TABLE amazon_sales (
    Order_ID VARCHAR(50),
    Date DATE,
    Customer_ID VARCHAR(50),
    Product_Category VARCHAR(100),
    Product_Name VARCHAR(255),
    Quantity INT,
    Unit_Price_INR DECIMAL(15, 2),
    Total_Sales_INR DECIMAL(15, 2),
    Payment_Method VARCHAR(50),
    Delivery_Status VARCHAR(50),
    Review_Rating INT,
    Review_Text TEXT,
    State VARCHAR(100),
    Country VARCHAR(50),
    Month_Str VARCHAR(20),
    Month_Name VARCHAR(20)
    );
    
# Total Revenue
SELECT SUM(Total_Sales_INR) AS Total_Revenue
FROM Amazon_Sales;

# Top 5 Best Selling Products
SELECT Product_Category, SUM(Total_Sales_INR) AS Revenue
FROM Amazon_Sales
GROUP BY Product_Category
ORDER BY Revenue DESC
LIMIT 5;

# Order status (Delivered vs Returned)
SELECT Delivery_Status, COUNT(*) AS Order_Count
FROM Amazon_Sales
GROUP BY Delivery_Status;

# Average order values by payment method
SELECT Payment_Method, AVG(Total_Sales_INR) AS Avg_Order_Value
FROM Amazon_Sales
GROUP BY Payment_Method;

# Top 5 States by order value
SELECT State, COUNT(*) AS Order_Count
FROM Amazon_Sales
GROUP BY State
ORDER BY Order_Count DESC
LIMIT 5;

# Return rate by category
SELECT Product_Category,
		(SUM(CASE WHEN Delivery_Status = 'Returned' THEN 1 ELSE 0 END) * 100 / COUNT(*)) AS Return_Rate_Percent
FROM Amazon_Sales
GROUP BY Product_Category
ORDER BY Return_Rate_Percent DESC;

# Customers spent >100000 INR
SELECT Customer_ID, SUM(Total_Sales_INR) AS Total_Spend
FROM Amazon_Sales
GROUP BY Customer_ID
HAVING Total_Spend > 100000
ORDER BY Total_Spend DESC;

# Low Rated Products (Avg Rating < 3 stars
SELECT Product_Name, AVG(Review_Rating) AS Avg_Rating
FROM Amazon_Sales
GROUP BY Product_Name
HAVING Avg_Rating < 3.0
ORDER BY Avg_Rating ASC;

# BEst Selling Day of the Week
SELECT DAYNAME(Date) AS Day_Name, SUM(Total_Sales_INR) AS Total_Sales
FROM Amazon_Sales
GROUP BY Day_Name
ORDER BY Total_Sales DESC;
