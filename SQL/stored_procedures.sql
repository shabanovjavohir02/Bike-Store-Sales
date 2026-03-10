--- 1-stored procedure

CREATE PROCEDURE sp_CalculateStoreKPI
    @Store_ID INT AS
BEGIN
    SET NOCOUNT ON;
SELECT
    s.Store_ID,
    s.Store_Name,
    COUNT(DISTINCT o.Order_ID) AS Total_Orders,
    CAST(
    COALESCE(SUM(oi.Quantity * oi.List_Price * (1 - oi.Discount)), 0) 
    AS DECIMAL(12,2)) 
    AS Total_Revenue,
    CAST(CASE WHEN COUNT(DISTINCT o.Order_ID) = 0 THEN 0
    ELSE COALESCE(SUM(oi.Quantity * oi.List_Price * (1 - oi.Discount)), 0) 
    / COUNT(DISTINCT o.Order_ID)
    END AS DECIMAL(12,2)) 
  AS AOV
FROM Sales.stores  s
LEFT JOIN Sales.orders o ON s.Store_ID = o.Store_ID
LEFT JOIN Sales.order_items oi ON o.Order_ID = oi.Order_ID
WHERE s.store_id = @Store_ID
GROUP BY s.Store_ID, s.Store_Name;
END;

--- 2-stored procedure

CREATE PROCEDURE sp_GenerateRestockList
    @Store_ID INT = NULL,        
    @Min INT = 10 AS
BEGIN
    SET NOCOUNT ON;
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
WHERE s.Quantity <= @Min 
ORDER BY s.Store_ID, s.Quantity ASC;
END;

--- 3-stored procedure

CREATE PROCEDURE sp_CompareSalesYearOverYear
    @Year1 INT,
    @Year2 INT
AS
BEGIN
    SET NOCOUNT ON;
SELECT
        YEAR(o.Order_Date) AS Year,
        COUNT(DISTINCT o.Order_ID) AS Total_Orders,
        CAST(SUM(oi.Quantity * oi.List_Price * (1 - oi.Discount)) 
    AS DECIMAL(12,2)) 
    AS Total_Revenue
FROM Sales.orders o
JOIN Sales.order_items oi ON o.Order_ID = oi.Order_ID
WHERE YEAR(o.Order_Date) IN (@Year1, @Year2)
GROUP BY YEAR(o.Order_Date)
ORDER BY Year;
END;

--- 4-stored procedure 

CREATE PROCEDURE sp_GetCustomerProfile
    @Customer_ID INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT
        c.Customer_ID,
        c.First_Name + ' ' + c.Last_Name AS Customer_Name,
        COUNT(DISTINCT o.Order_ID) AS Total_Orders,
        CAST(SUM(oi.Quantity * oi.List_Price * (1 - oi.Discount)) AS DECIMAL(12,2)) AS Total_Spend
    FROM Sales.customers c
    LEFT JOIN Sales.orders o ON c.Customer_ID = o.Customer_ID
    LEFT JOIN Sales.order_items oi ON o.Order_ID = oi.Order_ID
    WHERE c.Customer_ID = @Customer_ID
    GROUP BY c.Customer_ID, c.First_Name, c.Last_Name;

    SELECT TOP 5
        p.Product_ID,
        p.Product_Name,
        SUM(oi.Quantity) AS Total_Quantity
    FROM Sales.orders o
    JOIN Sales.order_items oi ON o.Order_ID = oi.Order_ID
    JOIN Production.products p ON oi.Product_ID = p.Product_ID
    WHERE o.Customer_ID = @Customer_ID
    GROUP BY p.Product_ID, p.Product_Name
    ORDER BY Total_Quantity DESC;
