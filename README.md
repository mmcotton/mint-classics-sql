# Exploratory Analysis of Mint Classic Cars Database with MySQL 

## Summary

The objective of this project was was to analyze data in a relational database with the goal of supporting inventory-related business decisions that lead to the closure of a storage facility. Below is the database's EEL relationship diagram. I imported the database into MySQL using a script provdided. This project was done through Coursera project network, using MySQL in my own environment. 

![F5F965CF-E460-451F-B9FD-5E85E880C7FC](https://github.com/mmcotton/mint-classics-sql/assets/148889213/bda5a259-8db8-48b6-a8d9-fa3c0ee852b3)

## Before analysis 

Before diving into analysis, I hypothesized that the data would reveal one warehouse containing a higher percentage of low-selling products than the others, and eliminating those products would enable Mint Classics to close that warehouse and redistribute its remaining inventory. 

After examining the different tables within the database, I decided to focus my analysis on the 'warehouses', 'products', 'orderdetails' and 'orders' tables, as they contained the most relevant data and relationships. 

## Key Takeaways After Analysis 

The exact steps I took in my analysis are outlined in the SQL script here. The data revealed the following insights: 

  1. Mint Classics has 110 unique products in its inventory, and the average number of units sold is 971.

  2. 62.71% of the items stored in Warehouse "a" sell below average, the highest of all warehouses. Warehouse "a" contains 25 items (131,688 units), 9 (82,588 units) of which sell below average. Warehouse "c" contains the second-highest percentage of items selling below average, at 51%. 

  3. Warehouse "a" also has the lowest number of orders placed containing items stored there, at 116 orders. Warehouse "d" comes in with the second-lowest number of orders, at 145.

  4. The highest selling item in Mint Classic's inventory is the 1992 is Ferrari 360 Spider red, kept in Warehouse "b", with 8347 units in stock. The lowest selling item is  the 1957 Ford Thunderbird, also kept in Warehouse "b", 3209 units in stock.

## 

    
      
     





