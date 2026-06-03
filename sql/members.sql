CREATE DATABASE IF NOT EXISTS members;
USE members;

DROP TABLE IF EXISTS members;

CREATE TABLE members(
    id VARCHAR(25) PRIMARY KEY NOT NULL,
    passwords VARCHAR(30) NOT NULL,
    role ENUM('customer','admin') NOT NULL DEFAULT 'customer'
);

-- 管理員帳號 (root) 顧客帳號 (02)
INSERT INTO members(id,passwords,role) VALUES
('root','1234','admin'),
('02','5678','customer');

SELECT * FROM members;
