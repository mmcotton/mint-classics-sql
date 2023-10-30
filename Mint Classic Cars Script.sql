-- view all tables with inventory, storage, and order info
SELECT * FROM warehouses
SELECT * FROM products
SELECT * FROM orderdetails
SELECT * FROM orders


-- determine how many different products are in catalog and how many products are in each warehouse
SELECT COUNT(DISTINCT productName) FROM products
 -- 110 different products
 SELECT COUNT(productCode) FROM products WHERE warehouseCode = "a"
 -- 25 products are stored in warehouse code "a"
 SELECT COUNT(productCode) FROM products WHERE warehouseCode = "b"
 -- 38 products stored in warehouse code "b"
 SELECT COUNT(productCode) FROM products WHERE warehouseCode = "c"
 -- 24 products stored in warehouse code "c"
 SELECT COUNT(productCode) FROM products WHERE warehouseCode="d"
 -- 23 products in warehouse code "d", 110 products across all warehouses


-- calculate total sales of each item in inventory
SELECT * FROM orderDetails 
CREATE TEMPORARY TABLE totalProductSales AS SELECT productCode, SUM(quantityOrdered) AS totalSales FROM orderDetails GROUP BY productCode ORDER BY totalSales DESC

-- we can see from the resulting table that the highest seller is product code S18_3232 and the lowest seller is S18_4933
-- let's check the products table to see what the item names are, where they are warehoused, and how many are in stock

SELECT productName, productCode, warehouseCode, quantityInStock FROM products WHERE productCode = "S18_3232"
SELECT productName, productCode, warehouseCode, quantityInStock FROM products WHERE productCode = "S18_4933"

-- top seller is 1992 is Ferrari 360 Spider red, kept in warehouse b, 8347 in stock 
-- lowest seller is 1957 Ford Thunderbird, also kept in warehouse b , 3209 in stock 

-- join products table with total product sales table, then order by highest to lowest selling items in each warehouse, create new table with this info
CREATE TABLE inventorySales AS SELECT products.productCode, products.productName, products.quantityInStock, products.warehouseCode, totalProductSales.totalSales 
FROM products
LEFT JOIN totalProductSales ON products.productCode = totalProductSales.productCode
ORDER BY warehouseCode, totalSales

SELECT * FROM inventorySales

SELECT AVG(totalSales) FROM inventorySales
-- average number of units sold is 968



SELECT AVG (totalSales) FROM inventorySales WHERE warehouseCode = "a"
-- average total sales for items in warehouse a is 986 units
SELECT AVG (totalSales) FROM inventorySales WHERE warehouseCode = "b"
-- average item sales  for warehouse b is 961.67 units
SELECT AVG (totalSales) FROM inventorySales WHERE warehouseCode = "c"
-- average item sales for warehouse c is 955 units 
SELECT AVG (totalSales) FROM inventorySales WHERE warehouseCode = "d"
-- average item sales for warehouse d is 971 units 

SELECT COUNT(productCode) FROM inventorySales WHERE totalSales < 971 AND warehouseCode = "a"
-- 9 items in warehouseCode a sell below the average 

SELECT COUNT(productCode) FROM inventorySales WHERE totalSales < 971 AND warehouseCode = "b"
-- 24 items in warehouseCode b sell below average

SELECT COUNT(productCode) FROM inventorySales WHERE totalSales < 971 AND warehouseCode = "c"
-- 13 items in warehouseCode c sell below average

SELECT COUNT(productCode) FROM inventorySales WHERE totalSales < 971 AND warehouseCode = "d"
-- 12 items in warehouseCode d sell below average

SELECT SUM(quantityInStock) FROM inventorySales WHERE warehouseCode = "a" 
 -- 131,688 items in stock

SELECT SUM(quantityInStock) FROM inventorySales WHERE warehouseCode = "b" 
-- 219,183 items in stock

SELECT SUM(quantityInStock) FROM inventorySales WHERE warehouseCode = "c" 
-- 124,880 items in stock

SELECT SUM(quantityInStock) FROM inventorySales WHERE warehouseCode = "d" 
-- 79,380 items in stock

SELECT SUM(quantityInStock) FROM inventorySales WHERE warehouseCode = "a" AND totalSales > 971
-- 82,588 units in stock of 9 items that sell below average, 131,688 items in stock, 62.71%

SELECT SUM(quantityInStock) FROM inventorySales WHERE warehouseCode = "b" AND totalSales > 971
-- 59,407 units in stock of 24 items that sell below average, 219,183 items in stock, 27%

SELECT SUM(quantityInStock) FROM inventorySales WHERE warehouseCode = "c" AND totalSales > 971
-- 64,838 units in stock of 13 items that sell below average, 124,880 items in stock, 51%

SELECT SUM(quantityInStock) FROM inventorySales WHERE warehouseCode = "d" AND totalSales > 971
-- 36,859 units in stock of 12 items that sell below average, 79,380 items in stock, 46.4% 

-- compare total sales to quantity in stock 
SELECT * FROM inventorySales ORDER BY totalSales, quantityInStock

SELECT * FROM inventorySales

SELECT SUM(quantityInStock) FROM inventorySales
-- 555131
SELECT SUM(totalSales) FROM inventorySales
-- 105516 

CREATE TABLE percentSalesStock AS SELECT productCode, 
productName, 
quantityInStock/555131*100 AS percentOfStock, 
totalSales/105516*100 AS percentOfSales,
warehouseCode
FROM inventorySales 
ORDER BY percentOfSales DESC

-- check to make sure new table is correct by comparing to actual numbers
SELECT * FROM inventorySales ORDER BY quantityInStock DESC
-- check to make sure new table was created correctly
SELECT * FROM percentSalesStock

SELECT * FROM orders
SELECT* FROM orderdetails

-- join orders, order details, and products tables to see order details and where products ordered were kept
CREATE TABLE ordersWarehouse AS SELECT orderDetails.orderNumber, orderDetails.productCode, orderDetails.quantityOrdered, orders.orderDate, orders.shippedDate, products.warehouseCode
FROM orderDetails LEFT JOIN orders ON orderDetails.orderNumber=orders.orderNumber
LEFT JOIN products ON products.productCode=orderDetails.productCode

SELECT COUNT(DISTINCT orderNumber) FROM ordersWarehouse WHERE warehouseCode="a"
-- 116 orders containing products kept in warehouse a

SELECT COUNT(DISTINCT orderNumber) FROM ordersWarehouse WHERE warehouseCode="b"
-- 209 orders containting products kept in warehouse b

SELECT COUNT(DISTINCT orderNumber) FROM ordersWarehouse WHERE warehouseCode="c"
-- 187 orders containing products kept in warehouse c

SELECT COUNT(DISTINCT orderNumber) FROM ordersWarehouse WHERE warehouseCode="d"
-- 145 orders containing products kept in warehouse d


-- create table showing total inventory in warehouse compared to total sales from that warehouse
CREATE TABLE stocksVersusSalesByWarehouse AS SELECT warehouseCode, SUM(quantityInStock) AS totalStock, 
SUM(totalSales) AS totalSales
FROM inventorySales GROUP BY warehouseCode


