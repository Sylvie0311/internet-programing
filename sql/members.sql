CREATE DATABASE IF NOT EXISTS members;
USE members;

DROP TABLE IF EXISTS members;

CREATE TABLE members(
    id VARCHAR(25) PRIMARY KEY NOT NULL,
    passwords VARCHAR(30) NOT NULL,
    role ENUM('customer','admin') NOT NULL DEFAULT 'customer',
    birth DATE,
    address VARCHAR(50),
    phone VARCHAR(10),
    email VARCHAR(30)
);

-- 管理員帳號 (root) 顧客帳號 (02、user03)
INSERT INTO members(id,passwords,role,birth,address,phone,email) VALUES
('root','1234','admin','1996-05-12','台北市大安區莊重路20號','0965897412','user@gmail.com'),
('02','5678','customer','2006-01-24','新北市板橋區重慶南路24號','0965224887','02@gmail.com'),
('user03','8888','customer','1996-05-12','桃園市中壢區普忠路路6號','0951223478','user03@gmail.com');

SELECT * FROM members;
