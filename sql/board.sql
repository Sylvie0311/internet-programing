CREATE DATABASE IF NOT EXISTS board;
USE board;


DROP TABLE IF EXISTS form;
DROP TABLE IF EXISTS guestbook;

#form資料表
CREATE TABLE form(
    new_name VARCHAR(10) PRIMARY KEY,
    new_mail VARCHAR(25),
    new_subject VARCHAR(30),
    new_content VARCHAR(100)
);

#guestbook資料表
CREATE TABLE IF NOT EXISTS guestbook (
  GBNO INT NOT NULL AUTO_INCREMENT COMMENT '留言編號' PRIMARY KEY,
  GBName VARCHAR(20) NOT NULL COMMENT '訪客姓名',
  Mail VARCHAR(50) DEFAULT NULL COMMENT 'E-mail',
  Subject VARCHAR(50) NOT NULL COMMENT '留言主題',
  Content TEXT DEFAULT NULL COMMENT '留言內容',
  Putdate DATE NOT NULL COMMENT '留言時間'
); 


INSERT INTO guestbook (GBName, Mail, Subject, Content, Putdate) VALUES
('李曉明', 'ming@gmail.com', 'N95醫療口罩', '出貨速度很快，服務態度良好', '2026-05-27'),
('王美麗', 'beautiful@gmail.com', '專業醫療護具護腰', '品質優良，讚!', '2026-05-27'),
('王寶釧', 'bouchun@gmail.com', '防水透氣ok蹦', '品質好的沒話說，賣家回復快速', '2026-05-27'),
('李樹隨', 'tree@gmail.com', '親水性敷料人工皮', '這是一次非常滿意的購物經驗', '2026-05-27');


SELECT * FROM guestbook;
