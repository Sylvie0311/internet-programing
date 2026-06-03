CREATE DATABASE IF NOT EXISTS members;
USE members;

DROP TABLE IF EXISTS members;
# members資料表
CREATE TABLE members(
	id VARCHAR(25) PRIMARY KEY NOT NULL,
    passwords VARCHAR(30) NOT NULL
);

INSERT INTO members(id,passwords) VALUES
('root','1234'),
('02',5678);

SELECT * FROM members;
