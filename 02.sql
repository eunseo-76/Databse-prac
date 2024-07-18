DROP TABLE if EXISTS jig_cutting CASCADE;
DROP TABLE if EXISTS jig_detail CASCADE;
DROP TABLE if EXISTS jig_no CASCADE;
DROP TABLE if EXISTS jig_thk CASCADE;
DROP TABLE if EXISTS jig_type CASCADE;

CREATE TABLE if NOT EXISTS jig_cutting
(
  cut_id INT AUTO_INCREMENT PRIMARY KEY
, drill VARCHAR(45)
, router VARCHAR(45)
, drill_router VARCHAR(45)
)ENGINE=INNODB;

DESC jig_cutting;

CREATE TABLE if NOT EXISTS jig_no
(
  serial_no INT PRIMARY KEY
)ENGINE= INNODB;

DESC jig_no;

CREATE TABLE if NOT EXISTS jig_detail
(
  serial_no INT PRIMARY KEY
, cust VARCHAR(50) NOT NULL
, tool VARCHAR(50) NOT NULL
, model VARCHAR(100) NOT NULL
, DATE DATETIME NOT NULL
, TYPE VARCHAR(50) NOT NULL
, thk VARCHAR(50) NOT NULL
, cutting VARCHAR(50) NOT NULL
, hole_count VARCHAR(50) NOT NULL
)ENGINE=INNODB;

DESC jig_detail;