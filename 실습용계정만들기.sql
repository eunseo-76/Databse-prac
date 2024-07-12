CREATE USER 'practice'@'%' IDENTIFIED BY  'practice';

SHOW GRANTS FOR 'practice'@'%';

CREATE DATABASE employeedb;

SHOW DATABASES;

GRANT ALL PRIVILEGES ON employeedb.* TO 'practice'@'%';

USE employeedb;