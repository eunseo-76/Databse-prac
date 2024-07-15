-- 12. DDL(Data Definition Language)
-- : 데이터베이스의 스키마를 정의하거나 수정

-- (1) CRAETE : 테이블 생성
CREATE TABLE if NOT EXISTS tb ( -- 이미 있는 tbl 만들 시 오류 발생하는 것을 방지. 생략 가능.
	pk INT PRIMARY KEY, -- 컬럼 레벨 제약 조건
	fk INT,
	col1 VARCHAR(255),
	CHECK(col1 IN('Y', 'N')) -- 테이블 레벨 제약 조건 (Y, N 이외의 다른 데이터가 들어오지 않게 CHECK)
) ENGINE = INNODB;

-- 컬럼이름 데이터타입 (제약조건)
-- 순으로 입력 ex) pk INT PRIMARY KEY

-- 테이블 구조 확인
DESCRIBE tb;
DESC tb;

-- insert 테스트
INSERT
  INTO tb
VALUES(
  1
, 10
, 'Y'
);

SELECT * FROM tb2;

-- auto_increment 적용
-- insert 시 pk에 해당하는 컬럼에 자동 번호 발생

CREATE TABLE if NOT EXISTS tb2 ( 
	pk INT auto_increment PRIMARY KEY,
	fk INT,
	col1 VARCHAR(255),
	CHECK(col1 IN('Y', 'N')) 
) ENGINE = INNODB;

SELECT * FROM tb2;

-- insert 테스트(여러 번 insert 해봐도 자동으로 숫자가 올라감)
INSERT
  INTO tb2
VALUES(
  null
, 10
, 'Y'
);

-- (2) ALTER : 테이블에 추가/변경/수정/삭제

-- 2-1. 열 추가
ALTER TABLE tb2
ADD col2 INT NOT NULL; -- 컬럼이름 데이터타입 (제약조건)

DESC tb2;

-- 2-2. 열 이름 및 데이터 형식 변경
ALTER TABLE tb2
CHANGE COLUMN fk change_fk INT NOT NULL;

DESC tb2;
SELECT * FROM tb2;

-- 2-3. 컬럼 삭제
ALTER TABLE tb2
DROP COLUMN col2;

DESC tb2;

-- 2-4. 제약조건 추가 및 삭제
ALTER TABLE tb2
DROP PRIMARY KEY; 
-- 오류 발생 이유
-- (1) auto increment 설정되어 있어서
-- (2) primary key라서

-- auto_increment 설정이 있을 경우 pk 제약조건 제거 불가
-- auto_increment 설정 제거
ALTER TABLE tb2
MODIFY pk INT; -- auto intrement 명시 사라짐

DESC tb2;

-- 다시 pk 제약 조건 제거
ALTER TABLE tb2
DROP PRIMARY KEY; -- primary key가 뭔지 알기 때문에 어떤 컬럼인지 쓰지 않음

DESC tb2;

-- 다시 pk 제약 조건 제거
ALTER TABLE tb2
ADD PRIMARY KEY(pk); -- 누구에게 primary key 줄 지 명시

DESC tb2;

-- 2-5. 컬럼 다중 추가
ALTER TABLE tb2
ADD col3 DATE NOT NULL,
ADD col4 TINYINT NOT NULL;

DESC tb2;

-- (3) DROP : 테이블 삭제 구문
DROP TABLE if EXISTS tb2; -- 테이블이 존재하지 않을 경우 오류 발생 방지 위해. 옵션.
-- 여러 개의 테이블 한 번에 삭제 가능
DROP TABLE if EXISTS tb, tb2, tb3;

-- (4) TRUNCATE
-- 논리적으로는 delete 구문과 차이가 없어 보이지만
-- drop 이후 테이블을 재생성 해주는 동작이 일어난다. (drop +  create)
SELECT * FROM tb;

TRUNCATE tb; -- 테이블에 있던 모든 데이터의 row 제거
DELETE FROM tb; -- 테이블에 있는 행을 하나씩 지움
-- auto commit이 아닐 때, delete 이후 rollback을 하면 원래대로 돌아감
-- truncate 한 후 rollback 해도 데이터는 살아나지 않음. 테이블을 지우고 재생성하기 때문.
-- 그래서 truncate는 DML 구문이 아니다!
-- 테이블을 리셋하고 싶을 때 TRUNCATE를 쓴다. 행을 하나하나 지우는 대신 drop 해 버림.
