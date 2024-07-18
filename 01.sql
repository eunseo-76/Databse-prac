-- 1) 새로운 계정 만들기
CREATE USER 'tm'@'%' IDENTIFIED BY 'tm';

USE mysql; -- mysql db로 계정 정보 확인 위함
SELECT * FROM USER; -- 새로운 계정 생성 확인

-- 2) db 생성 후 계정에 권한 부여
CREATE DATABASE jigfile; -- db 생성 

GRANT ALL PRIVILEGES ON jigfile.* TO 'tm'@'%'; -- db에 대한 모든 권한 부여
SHOW GRANTS FOR 'tm'@'%'; -- 계정 권한 확인

USE jigfile;