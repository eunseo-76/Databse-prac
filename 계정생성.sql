-- 계정 생성

-- swcamp 라는 이름으로 계정 생성
DROP USER 'swcamp'@'%';
CREATE USER 'swcamp'@'%' IDENTIFIED BY 'swcamp'; 

-- '%'는 외부에서 접속 요청을 허용 하는 옵션
-- IDENTIFIED BY 는 비밀번호

-- 데이터베이스(스키마) 생성
CREATE DATABASE menudb;

-- 존재하는 데이터베이스 확인
SHOW DATABASES;
menudb
-- swcamp의 주어진 권한 확인
SHOW GRANTS FOR 'swcamp'@'%';

-- menudb에 대한 모든 권한을 swcamp 계정에 부여
GRANT ALL PRIVILEGES ON menudb.* TO 'swcamp'@'%';

-- 세션 관리자에서 swcamp로 접속한 뒤 사용할 데이터베이스 선택
USE menudb;