CREATE DATABASE IF NOT EXISTS board;
USE board;

DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS form;
DROP TABLE IF EXISTS guestbook;

#orders 資料表
CREATE TABLE orders (
    order_id VARCHAR(20) PRIMARY KEY COMMENT '訂單編號',
    member_id VARCHAR(50) NOT NULL COMMENT '會員帳號(對應登入ID)',
    order_date DATE NOT NULL COMMENT '訂購日期',
    total_amount INT NOT NULL COMMENT '總金額',
    status VARCHAR(20) NOT NULL COMMENT '訂單狀態'
);

#form 資料表
CREATE TABLE form(
    new_name VARCHAR(10) PRIMARY KEY,
    new_mail VARCHAR(25),
    new_subject VARCHAR(30),
    new_content VARCHAR(100)
);

#guestbook 資料表
CREATE TABLE IF NOT EXISTS guestbook (
  GBNO INT NOT NULL AUTO_INCREMENT COMMENT '留言編號' PRIMARY KEY,
  GBName VARCHAR(50) NOT NULL COMMENT '訪客姓名',
  Mail VARCHAR(100) DEFAULT NULL COMMENT 'E-mail',
  Subject VARCHAR(255) NOT NULL COMMENT '留言主題',
  Content TEXT DEFAULT NULL COMMENT '留言內容',
  Putdate DATE NOT NULL COMMENT '留言時間'
); 

#orders資料（將部分訂單綁定給一般會員'02'其餘綁給其他帳號）
INSERT INTO orders (order_id, member_id, order_date, total_amount, status) VALUES
('ORDA68F5689', '02', '2025-11-20', 1500, '待出貨'),
('ORD5478W556', '02', '2025-06-10', 7430, '已出貨'),
('ORDK786C236', '02', '2025-12-10', 8733, '待出貨'),
('ORDG568H410', 'user03', '2025-12-12', 10345, '待出貨');

INSERT INTO guestbook (GBName, Mail, Subject, Content, Putdate) VALUES
('李曉明', 'ming@gmail.com', 'N95醫療口罩', '出貨速度很快，服務態度良好', '2026-05-27'),
('王美麗', 'beautiful@gmail.com', '專業醫療護具護腰', '品質優良，讚!', '2026-05-27'),
('王寶釧', 'bouchun@gmail.com', '防水透氣ok蹦', '品質好的沒話說，賣家回復快速', '2026-05-27'),
('李樹隨', 'tree@gmail.com', '親水性敷料人工皮', '這是一次非常滿意的購物經驗', '2026-05-27');

SELECT * FROM orders;
SELECT * FROM form;
SELECT * FROM guestbook;
