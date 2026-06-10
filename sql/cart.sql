CREATE DATABASE IF NOT EXISTS cart;
USE cart;

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS shopping_cart;
DROP TABLE IF EXISTS Inventory;
DROP TABLE IF EXISTS Invoice_Detail;
DROP TABLE IF EXISTS Invoice;
DROP TABLE IF EXISTS Member;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Product;
SET FOREIGN_KEY_CHECKS = 1;

-- 器材品項資料表
CREATE TABLE Product (
    Product_ID VARCHAR(10),
    Product_Name VARCHAR(50) NOT NULL, 
    License_No VARCHAR(30),
    Specification VARCHAR(30),        
    Unit_Price INT NOT NULL,
    Product_introduction VARCHAR(100),
    PRIMARY KEY (Product_ID)
);
ALTER TABLE Product ADD COLUMN Image_Path VARCHAR(255);
-- 帳單
CREATE TABLE Invoice (
    Invoice_ID VARCHAR(20),
    Invoice_Date DATE NOT NULL,
    Total_Amount INT NOT NULL,         
    PRIMARY KEY (Invoice_ID)
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
    Inventory_ID INT AUTO_INCREMENT PRIMARY KEY,
    Product_ID VARCHAR(10) UNIQUE, 
    Quantity INT NOT NULL,
    Lot_Number VARCHAR(20),      
    Expiry_Date DATE,            
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
INSERT INTO Product (Product_ID, Product_Name, License_No, Specification, Unit_Price, Product_introduction) VALUES
('P001', '無菌針頭', '衛署醫器製字01', '21G', 15, '高規格無菌製程，針尖經特殊拋光，極致減痛。'),
('P002', '電子血壓計', '衛署醫器輸字02', 'HEM-7121', 1980, '一鍵輕鬆操作，大螢幕清晰顯示，支援最新壓脈帶著裝確認。'),
('P003', '醫用活性碳口罩', '衛署醫器製字03', '50入/盒', 150, '四層防護結構，有效阻隔飛沫與異味，配戴舒適透氣。'),
('P004', '醫用N95口罩', '衛署醫器製字04', '20入/盒', 89, '符合高防護標準，密合度極佳，適合高風險環境防護。'),
('P005', '專業醫療護具護腰', '衛署醫器製字05', '1入/包', 2700, '人體工學條支撐，強力魔鬼氈固定，有效舒緩腰部受力。'),
('P006', '防水透氣OK繃', '衛署醫器製字06', '15入/盒', 72, '超薄防水複方膜，阻絕水份細菌，黏性持久且不易過敏。'),
('P007', '親水性敷料人工皮', '衛署醫器製字07', '2入/包', 209, '完美吸收傷口滲出液，維持濕潤平衡，加速傷口修復。'),
('P008', '自立式手杖(右手用)', '衛署醫器製字08', '單支', 1900, '多點式防滑底座，輕量化鋁合金材質，高度多檔可調。'),
('P009', '固定式12吋後輪+頭靠 馬桶椅', '衛署醫器製字09', '單個', 4500, '防潑水連體軟墊，加厚鋼管穩固防側翻，附舒適頭靠。'),
('P010', '舒適乒乓約束帶(無拉鍊款)', '衛署醫器製字10', '1入/包', 225, '透氣網布設計，親膚內襯，安全固定限制而不傷皮膚。');

USE cart;
UPDATE Product SET Image_Path = 'images/P001.jpg' WHERE Product_ID = 'P001';
UPDATE Product SET Image_Path = 'images/P002.jpg' WHERE Product_ID = 'P002';
UPDATE Product SET Image_Path = 'images/P003.jpg' WHERE Product_ID = 'P003';
UPDATE Product SET Image_Path = 'images/P004.jpg' WHERE Product_ID = 'P004';
UPDATE Product SET Image_Path = 'images/P005.jpg' WHERE Product_ID = 'P005';
UPDATE Product SET Image_Path = 'images/P006.jpg' WHERE Product_ID = 'P006';
UPDATE Product SET Image_Path = 'images/P007.jpg' WHERE Product_ID = 'P007';
UPDATE Product SET Image_Path = 'images/P008.jpg' WHERE Product_ID = 'P008';
UPDATE Product SET Image_Path = 'images/P009.jpg' WHERE Product_ID = 'P009';
UPDATE Product SET Image_Path = 'images/P010.jpg' WHERE Product_ID = 'P010';
-- 帳單資料
INSERT INTO Invoice (Invoice_ID, Invoice_Date, Total_Amount) VALUES
('INV20260526001', '2026-05-26', 1500),
('INV20260421001', '2026-04-21', 3960),
('INV20260320001', '2026-03-20', 29334); 

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

-- 庫存資料
INSERT INTO Inventory (Product_ID, Quantity, Lot_Number, Expiry_Date) VALUES
('P001', 502, 'LOT001', '2028-12-31'), 
('P002', 13, 'LOT002', '2027-06-30'),
('P003', 150, 'LOT003', '2026-09-15'), 
('P004', 200, NULL, NULL), 
('P005', 700, NULL, NULL), 
('P006', 1344, NULL, NULL), 
('P007', 721, NULL, NULL), 
('P008', 153, NULL, NULL), 
('P009', 42, NULL, NULL), 
('P010', 138, NULL, NULL);

SELECT 
    p.Product_ID, 
    p.Product_Name, 
    p.Specification, 
    p.Unit_Price, 
    p.Product_introduction,
    IFNULL(i.Quantity, 0) AS Stock_Quantity,
    i.Lot_Number,
    i.Expiry_Date
FROM Product p
LEFT JOIN Inventory i ON p.Product_ID = i.Product_ID;



