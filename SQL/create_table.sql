-- 1-table Brands (Production)
Create table Stg_Brands 
(Brand_ID INT, Brand_Name Varchar (50) )

-- 2-table Categories (Production)
Create table Stg_Categories
(Category_ID INT, Category_Name Varchar (50))

-- 3-table Customers (Sales)
Create table Stg_Customers
(Customer_ID INT, First_Name Varchar (50), Last_Name Varchar (50), Phone INT, 
Email Varchar (50), Street Varchar (50), City Varchar (50), State Varchar (50), Zip_Code INT)

-- 4-table Order items (Sales)
Create table Stg_Order_items
(Order_ID INT, Item_ID INT, Product_ID INT, Quantity INT, List_Price INT, Discount INT)

-- 5-table Orders (Sales)
Create table Stg_Orders
(Order_ID INT, Customer_ID INT, Order_Status INT, Order_Date INT, Required_Date INT, Shipped_Date INT, Store_ID INT, Staff_ID INT)

-- 6-table Products (Production)
Create table Stg_Products
(Product_ID INT, Product_Name Varchar (100), Brand_ID INT, Category_ID INT, Model_Year INT, List_Price INT)

-- 7-table Staffs (Sales)
Create table Stg_Staffs
(Staff_ID INT, First_Name Varchar (50), Last_Name Varchar (50), 
Email Varchar (50), Phone INT, Active INT, Store_ID INT, Manager_ID INT)

-- 8-table Stocks (Production)
Create table Stg_Stocks 
(Stock_ID INT, Product_ID INT, Quantity INT)

-- 9-table Stores (Sales)
Create table Stg_Stores
(Store_ID INT, Store_Name Varchar (50), Phone INT, Email Varchar (50), 
Street Varchar (50), City Varchar (50), State Varchar (50), Zip_Code INT)
