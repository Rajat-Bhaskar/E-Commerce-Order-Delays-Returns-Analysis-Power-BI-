CREATE DATABASE ECommerce;
USE Ecommerce;

CREATE TABLE Customers (Customer_Id INT PRIMARY KEY AUTO_INCREMENT, 
Customer_Name VARCHAR (100) NOT NULL, 
City VARCHAR (100) NOT NULL, 
State VARCHAR (100) NOT NULL);

CREATE TABLE Products (Product_Id INT PRIMARY KEY AUTO_INCREMENT, 
Product_Name VARCHAR (100) NOT NULL, 
Category VARCHAR (100) NOT NULL, 
Seller_Name VARCHAR (100) NOT NULL);

CREATE TABLE Orders (Order_Id INT PRIMARY KEY AUTO_INCREMENT, 
Customer_Id INT NOT NULL,
Product_Id INT NOT NULL,
Order_Date DATE NOT NULL, 
Expected_Delivery_Date DATE NOT NULL,
Actual_Delivery_Date DATE NOT NULL,
Order_Status VARCHAR (100) NOT NULL,
FOREIGN KEY (Customer_Id) REFERENCES Customers (Customer_Id),
FOREIGN KEY (Product_Id) REFERENCES Products (Product_Id));

CREATE TABLE Returns (Return_Id INT PRIMARY KEY AUTO_INCREMENT,
Order_Id INT NOT NULL,
Return_Date DATE NOT NULL,
Return_Reason VARCHAR (500) NOT NULL,
FOREIGN KEY (Order_Id) REFERENCES Orders (Order_Id));

INSERT INTO Customers (Customer_Name, City, State) VALUES
("Amit Sharma", "Delhi", "Delhi"),
("Neha Verma", "Mumbai", "Maharashtra"),
("Rahul Singh", "Bengaluru", "Karnataka"),
("Pooja Mehta", "Ahmedabad", "Gujarat"),
("Rohan Das", "Kolkata", "West Bengal");

INSERT INTO Products( Product_Id, Product_Name, Category, Seller_Name) VALUES
(101, "Wireless Mouse", "Electronics", "TechWorld"),
(102, "Running Shoes", "Footwear", "Sportify"),
(103, "Bluetooth Speaker", "Electronics", "SoundMax"),
(104, "Smartphone Case", "Accessories", "MobileHub"),
(105, "Backpack", "Accessories", "UrbanCarry");

INSERT INTO Orders (Order_Id, Customer_Id, Product_Id, Order_Date, Expected_Delivery_Date, Actual_Delivery_Date, Order_Status) VALUES
(1001, 1 , 101 , '2024-01-01', '2024-01-05', '2024-01-04', "Delivered"),
(1002, 2 , 102 , '2024-01-02', '2024-01-06', '2024-01-08', "Delivered"),
(1003, 3 , 103 , '2024-01-03', '2024-01-07', '2024-01-07', "Delivered"),
(1004, 4 , 104 , '2024-01-04', '2024-01-09', '2024-01-11', "Delivered"),
(1005, 5 , 105 , '2024-01-05', '2024-01-10', NULL, "Cancelled"),
(1006, 1 , 102 , '2024-01-06', '2024-01-11', '2024-01-15', "Delivered"),
(1007, 2 , 101 , '2024-01-07', '2024-01-12', '2024-01-12', "Delivered");

INSERT INTO Returns (Return_Id, Order_Id, Return_Date, Return_Reason) VALUES
(5001, 1002, '2024-01-10', "Size Issue"),
(5002, 1004, '2024-01-13', "Product damaged"),
(5003, 1006, '2024-01-18', "Late delivery");

-- Order level delay analysis

SELECT Order_Id, 
Order_Date, 
Product_Name, 
Category, 
Seller_Name, 
Expected_Delivery_Date, 
Actual_Delivery_Date, 
DATEDIFF(Actual_Delivery_Date, Expected_Delivery_Date) AS Delivery_Delay_Days,
 CASE 
     WHEN DATEDIFF(Actual_Delivery_Date, Expected_Delivery_Date) > 1 
           THEN 'Delayed'
	    ELSE 'On Time'
 END AS Delay_Status,
Order_Status
FROM Products
INNER JOIN Orders 
ON Orders.Product_Id = Products.Product_Id;

-- Customer Level Delay Analysis 

SELECT Order_Id, 
Customer_Name, 
City, 
State, 
CASE 
     WHEN DATEDIFF(Actual_Delivery_Date, Expected_Delivery_Date) > 1 
           THEN 'Delayed'
	    ELSE 'On Time'
 END AS Delay_Status
 FROM Orders
 INNER JOIN Customers
 ON Orders.Customer_Id = Customers.Customer_Id;
 
 -- Product Level Delay Analysis 
 
 SELECT Product_Name, 
 Category, 
 Seller_Name, 
 CASE 
     WHEN DATEDIFF(Actual_Delivery_Date, Expected_Delivery_Date) > 1 
           THEN 'Delayed'
	    ELSE 'On Time'
 END AS Delay_Status
 FROM Orders
 INNER JOIN Products
 ON Orders.Product_Id = Products.Product_Id;
 
 -- Which orders are delayed and why
 
SELECT Orders.Order_Id,
Return_Date,
Return_Reason,
CASE 
       WHEN Return_Id IS NOT NULL
         THEN 'YES'
	   ELSE 'NO'
END AS Is_Returned
FROM Orders
LEFT JOIN Returns
ON Returns.Order_Id = Orders.Order_Id;

-- Final Dataset

SELECT Orders.Order_Id, 
Order_Date,
Customer_Name,
City,
State,
Product_Name,
Category, 
Seller_Name,
Expected_Delivery_Date,
Actual_Delivery_Date,
DATEDIFF(Actual_Delivery_Date, Expected_Delivery_Date) AS Delivery_Delay_Days,
CASE 
     WHEN DATEDIFF(Actual_Delivery_Date, Expected_Delivery_Date) > 1 
           THEN 'Delayed'
	    ELSE 'On Time'
 END AS Delay_Status,
 Order_Status,
 CASE 
       WHEN Return_Id IS NOT NULL
         THEN 'Yes'
	   ELSE 'No'
END AS Is_Returned,
Return_Reason
FROM Orders
INNER JOIN Customers
ON Orders.Customer_Id = Customers.Customer_Id
INNER JOIN Products
ON Orders.Product_Id = Products.Product_Id
LEFT JOIN Returns
ON Returns.Order_Id = Orders.Order_Id;