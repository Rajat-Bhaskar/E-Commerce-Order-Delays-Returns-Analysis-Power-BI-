# 📊 Dataset – E-Commerce Orders, Delays & Returns

This folder contains the final dataset used for analysis and dashboard creation.

## 📄 File Details

### `Final Dataset For Analysis.csv`
This CSV file is the cleaned and consolidated dataset generated after SQL joins and transformations.

### Key Columns Included:
- **Order_Id** – Unique identifier for each order
- **Order_Date** – Date when the order was placed
- **Customer_Name, City, State** – Customer location details
- **Product_Name, Category, Seller_Name** – Product and seller information
- **Expected_Delivery_Date** – Promised delivery date
- **Actual_Delivery_Date** – Actual delivery date
- **Delivery_Delay_Days** – Difference between actual and expected delivery
- **Delay_Status** – On Time / Delayed
- **Order_Status** – Delivered / Cancelled
- **Is_Returned** – Yes / No
- **Return_Reason** – Reason for return (if applicable)

## 🧠 Purpose of the Dataset
This dataset is designed to support:
- Order delay analysis
- Return rate analysis
- Seller and category performance evaluation
- KPI calculation in Power BI

📌 **Note:**  
This file is directly consumed in Power BI for data modeling and visualization.
