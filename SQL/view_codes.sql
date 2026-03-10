--- 1-view

CREATE VIEW vw_StoreSalesSummary AS
SELECT
    s.Store_ID,
    s.Store_Name,
    COUNT(DISTINCT o.Order_ID) AS Total_Orders,
    CAST(
        COALESCE(SUM(oi.Quantity * oi.List_Price * (1 - oi.Discount)), 0) 
        AS DECIMAL(12,2)
    ) AS Total_Revenue,
  CAST(
        CASE 
            WHEN COUNT(DISTINCT o.Order_ID) = 0 THEN 0
            ELSE COALESCE(SUM(oi.Quantity * oi.List_Price * (1 - oi.Discount)), 0) 
                 / COUNT(DISTINCT o.Order_ID)
        END AS DECIMAL(12,2)
    ) AS AOV
FROM Sales.stores  s
LEFT JOIN Sales.orders  o ON s.Store_ID = o.Store_ID
LEFT JOIN Sales.order_items  oi ON o.Order_ID = oi.Order_ID
GROUP BY s.Store_ID, s.Store_Name;
GO

--- 2-view

CREATE VIEW vw_TopSellingProducts AS
SELECT
    p.Product_ID,
    p.Product_Name,
    SUM(oi.Quantity) AS Total_Quantity_Sold,
    CAST(SUM(oi.Quantity * oi.List_Price * (1 - oi.Discount)) AS DECIMAL(12,2)) AS Total_Sales,
    RANK() OVER (ORDER BY SUM(oi.Quantity * oi.List_Price * (1 - oi.Discount)) DESC) AS Sales_Rank
FROM Production.products p
JOIN Sales.order_items oi ON p.Product_ID = oi.Product_ID
GROUP BY p.Product_ID, p.Product_Name;
GO

--- 3-view

CREATE VIEW vw_InventoryStatus AS
SELECT 
   st.store_id,
   st.Store_name,
   p.Product_Name,
   b.Brand_Name,
     c.Category_Name,
     s.Quantity AS Stock_Level
FROM Production.stocks s
JOIN Production.products p on s.product_id = p.product_id 
JOIN Production.brands b on p.brand_id = b.brand_id 
JOIN Production.categories c on p.category_id = c.category_id 
JOIN Sales.stores st on s.store_id = st.store_id 
WHERE s.Quantity <= 10  -- taxminan
GO

--- 4-view

CREATE VIEW vw_StaffPerformance AS
SELECT
    s.First_name + ' ' + s.Last_name as Staff_Name,
  st.Store_Name,
  COUNT(DISTINCT o.Order_ID) as Orders_Handled,
  CAST(
         COALESCE(SUM(oi.Quantity * oi.List_price * (1 - oi.Discount)), 0) 
     AS DECIMAL(12,2)) AS Revenue_Handled
FROM Sales.Staffs s
LEFT JOIN Sales.orders o ON s.Staff_ID = o.Staff_ID
LEFT JOIN Sales.order_items oi ON o.Order_ID = oi.Order_ID
LEFT JOIN Sales.stores st on s.store_id = st.store_id 
GROUP BY s.Staff_ID, s.First_Name, s.Last_Name, st.Store_Name
GO

--- 5-view

CREATE VIEW vw_RegionalTrends AS
SELECT
    s.City,
    s.State,
    COUNT(DISTINCT o.Order_ID) AS Total_Orders,
    CAST(
        COALESCE(SUM(oi.Quantity * oi.List_Price * (1 - oi.Discount)), 0) 
        AS DECIMAL(12,2)
    ) AS Total_Revenue
FROM Sales.stores s
LEFT JOIN Sales.orders o ON s.Store_ID = o.Store_ID
LEFT JOIN Sales.order_items oi ON o.Order_ID = oi.Order_ID
GROUP BY s.City, s.State
GO

--- 6-view

CREATE VIEW vw_SalesByCategory AS
SELECT
    c.Category_ID,
    c.Category_Name,
    SUM(oi.Quantity) AS Units_Sold,
    CAST(SUM(oi.Quantity * oi.List_Price * (1 - oi.Discount)) AS DECIMAL(12,2)) AS Total_Sales
FROM Production.categories c
JOIN Production.products p ON c.Category_ID = p.Category_ID
JOIN Sales.order_items oi ON p.Product_ID = oi.Product_ID
GROUP BY c.Category_ID, c.Category_Name
GO
