# Bike-Store-Sales

## Overview
This project demonstrates the development of a Business Intelligence (BI) system using SQL Server based on a real-world retail dataset.

The system models data for a multi-branch bike retail company and transforms raw CSV data into a structured relational database. It then generates business insights through analytical views, stored procedures, and automated data workflows.

The goal of the project is to simulate how BI developers use SQL to transform operational data into decision-ready metrics for business leaders.

## Dataset
The project uses multiple CSV datasets representing a retail environment, including:

- Customers
- Orders and Order Items
- Products
- Stores and Staff
- Inventory (Stocks)
- Product Categories and Brands

These datasets were imported, cleaned, and transformed into a normalized SQL Server database schema.

<img width="1027" height="784" alt="image" src="https://github.com/user-attachments/assets/550b6050-c2e5-4a45-9a3e-152d0d367020" />


## Key Features

### Data Engineering
- Imported raw CSV files using **BULK INSERT / OPENROWSET**
- Designed a **normalized relational schema**
- Applied **primary keys, foreign keys, and constraints**

### Business Intelligence Views
Analytical views were created to provide reusable business reports:

- `vw_StoreSalesSummary` – revenue, order count, and AOV per store
- `vw_TopSellingProducts` – ranking products by sales
- `vw_InventoryStatus` – low stock monitoring
- `vw_StaffPerformance` – revenue and orders handled by staff
- `vw_RegionalTrends` – sales trends by region
- `vw_SalesByCategory` – category-level sales performance

### Stored Procedures
Automated procedures were built to generate key business insights:

- `sp_CalculateStoreKPI`
- `sp_GenerateRestockList`
- `sp_CompareSalesYearOverYear`
- `sp_GetCustomerProfile`

## Tech Stack

- **SQL Server**
- **T-SQL**
- BULK INSERT / OPENROWSET
- SQL Server Agent
- Relational Database Design
- Business Intelligence Concepts
