CREATE DATABASE IF NOT EXISTS medical_system_my_db;
USE medical_system_my_db;

DROP TABLE IF EXISTS Inventory;
DROP TABLE IF EXISTS Invoice_Detail;
DROP TABLE IF EXISTS Invoice;
DROP TABLE IF EXISTS Member;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS shopping_cart;
DROP TABLE IF EXISTS Product;

-- 器材品項資料表
CREATE TABLE Product (
    Product_ID VARCHAR(10),
    Product_Name VARCHAR(50) NOT NULL, 
    License_No VARCHAR(30),
    Specification VARCHAR(30),        
    Unit_Price INT NOT NULL,           
    PRIMARY KEY (Product_ID)
);

-- 員工資料表
CREATE TABLE Employee (
    Employee_ID VARCHAR(10),
    Name VARCHAR(20) NOT NULL,
    Position VARCHAR(50),
    Phone VARCHAR(15),
    PRIMARY KEY (Employee_ID)
);

-- 會員資料表
CREATE TABLE Member (
    Member_ID VARCHAR(10),
    Member_Name VARCHAR(50) NOT NULL, 
    Tax_ID VARCHAR(20),
    Phone VARCHAR(20),
    Address VARCHAR(100),              
    Member_Type ENUM('Hospital', 'Clinic') NOT NULL,
    PRIMARY KEY (Member_ID)
);

-- 帳單
CREATE TABLE Invoice (
    Invoice_ID VARCHAR(20),
    Member_ID VARCHAR(10),
    Employee_ID VARCHAR(10),
    Invoice_Date DATE NOT NULL,
    Total_Amount INT NOT NULL,         
    PRIMARY KEY (Invoice_ID),
    FOREIGN KEY (Member_ID) REFERENCES Member(Member_ID),
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID)
);

-- 帳單明細表
CREATE TABLE Invoice_Detail (
    Detail_ID VARCHAR(10),   
    Invoice_ID VARCHAR(20),
    Product_ID VARCHAR(10),
    Quantity INT NOT NULL,
    Sale_Price INT NOT NULL,           
    PRIMARY KEY (Detail_ID),
    FOREIGN KEY (Invoice_ID) REFERENCES Invoice(Invoice_ID),
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID)
);

-- 器材庫存資料表
CREATE TABLE Inventory (
    Inventory_ID VARCHAR(10),          
    Product_ID VARCHAR(10),           
    Lot_Number VARCHAR(20) NOT NULL,   
    Expiry_Date DATE NOT NULL,
    Quantity INT NOT NULL,             
    PRIMARY KEY (Inventory_ID),
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID)
);

-- 購物車資料表
CREATE TABLE shopping_cart (
    cart_id INT PRIMARY KEY AUTO_INCREMENT,
    Product_ID VARCHAR(10), 
    Quantity INT DEFAULT 1,
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID)
);

-- 商品資料
INSERT INTO Product (Product_ID, Product_Name, License_No, Specification, Unit_Price) VALUES
('P001', '無菌針頭', '衛署醫器製字01', '21G', 15),
('P002', '電子血壓計', '衛署醫器輸字02', 'HEM-7121', 1980),
('P003', '醫用活性碳口罩', '衛署醫器製字03', '50入/盒', 150),
('P004', '醫用N95口罩', '衛署醫器製字04', '20入/盒', 89),
('P005', '專業醫療護具護腰', '衛署醫器製字05', '1入/包', 2700),
('P006', '防水透氣OK繃', '衛署醫器製字06', '15入/盒', 72),
('P007', '親水性敷料人工皮', '衛署醫器製字07', '2入/包', 209),
('P008', '自立式手杖(右手用)', '衛署醫器製字08', '單支', 1900),
('P009', '固定式12吋後輪+頭靠 馬桶椅', '衛署醫器製字09', '單個', 4500),
('P010', '舒適乒乓約束帶(無拉鍊款)', '衛署醫器製字10', '1入/包', 225);

-- 插入員工資料
INSERT INTO Employee (Employee_ID, Name, Position, Phone) VALUES
('S001', '陳天文', '品保專員', '0912345678'),
('S002', '林小美', '產品專員', '0923456789'),
('S003', '張啟明', '維修工程師', '0934567890'), 
('S004', '王少平', '技術專員', '0956347893');

-- 會員資料
INSERT INTO Member (Member_ID, Member_Name, Tax_ID, Phone, Address, Member_Type) VALUES
('M001', '仁愛綜合醫院', '23456789', '02-23456789', '台北市大安區仁愛路三段', 'Hospital'),
('M002', '健康快樂診所', '98765432', '03-4567890', '桃園市中壢區中正路', 'Clinic'),
('M003', '幸福牙醫診所', '45671234', '04-7654321', '台中市西屯區台灣大道', 'Clinic'),
('M004', '趕快好診所', '68340321', '03-4246738', '宜蘭縣宜蘭市南門里', 'Clinic'); 

-- 帳單
INSERT INTO Invoice (Invoice_ID, Member_ID, Employee_ID, Invoice_Date, Total_Amount) VALUES
('INV20260526001', 'M001', 'S001', '2026-05-26', 1500),
('INV20260421001', 'M002', 'S002', '2026-04-21', 3960),
('INV20260320001', 'M003', 'S003', '2026-03-20', 12105); 

-- 帳單明細
INSERT INTO Invoice_Detail (Detail_ID, Invoice_ID, Product_ID, Quantity, Sale_Price) VALUES
('D001', 'INV20260526001', 'P001', 100, 15),
('D002', 'INV20260421001', 'P002', 2, 1980),
('D003', 'INV20260320001', 'P003', 3, 150),
('D005', 'INV20260320001', 'P005', 3, 2700), 
('D006', 'INV20260320001', 'P006', 3, 72),   
('D007', 'INV20260320001', 'P007', 3, 209),  
('D008', 'INV20260320001', 'P008', 3, 1900), 
('D009', 'INV20260320001', 'P009', 3, 4500), 
('D010', 'INV20260320001', 'P010', 3, 225);  

-- 庫存
INSERT INTO Inventory (Inventory_ID, Product_ID, Lot_Number, Expiry_Date, Quantity) VALUES
('IV001', 'P001', 'LOT12345', '2028-12-31', 502), 
('IV002', 'P002', 'LOT67890', '2029-06-30', 13),
('IV003', 'P003', 'LOT55667', '2027-03-15', 150), 
('IV004', 'P004', 'LOT54132', '2028-04-16', 200), 
('IV005', 'P005', 'LOT83167', '2029-05-16', 700), 
('IV006', 'P006', 'LOT37912', '2030-07-28', 1344), 
('IV007', 'P007', 'LOT48321', '2026-12-30', 721), 
('IV008', 'P008', 'LOT93263', '2029-03-16', 153), 
('IV009', 'P009', 'LOT32084', '2028-01-13', 42), 
('IV010', 'P010', 'LOT73692', '2027-11-16', 138); 

SELECT 
    p.Product_ID, 
    p.Product_Name, 
    p.Specification, 
    p.Unit_Price, 
    IFNULL(i.Quantity, 0) AS Stock_Quantity,
    i.Lot_Number,
    i.Expiry_Date
FROM Product p
LEFT JOIN Inventory i ON p.Product_ID = i.Product_ID;

SELECT 
    id.Invoice_ID,
    inv.Invoice_Date,
    m.Member_Name,
    m.Member_Type,
    e.Name AS Sales_Employee,
    p.Product_Name,
    id.Quantity AS Buy_Quantity,
    id.Sale_Price,
    (id.Quantity * id.Sale_Price) AS Sub_Total,
    inv.Total_Amount AS Invoice_Grand_Total
FROM Invoice_Detail id
JOIN Invoice inv ON id.Invoice_ID = inv.Invoice_ID
JOIN Member m ON inv.Member_ID = m.Member_ID
JOIN Employee e ON inv.Employee_ID = e.Employee_ID
JOIN Product p ON id.Product_ID = p.Product_ID
ORDER BY id.Invoice_ID ASC, id.Detail_ID ASC;

SELECT 
    sc.cart_id,
    sc.Product_ID,
    p.Product_Name,
    p.Specification,
    p.Unit_Price,
    sc.Quantity AS Cart_Quantity,
    (p.Unit_Price * sc.Quantity) AS Item_Total
FROM shopping_cart sc
JOIN Product p ON sc.Product_ID = p.Product_ID;