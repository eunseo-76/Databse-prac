-- 13. constraints (제약 조건)
-- : 테이블에 데이터가 입력 되거나 수정 될 때의 규칙
--   데이터베이스 무결성 보장

-- (1) not null : null 값을 허용하지 않음
CREATE TABLE if NOT EXISTS user_notnull(
  user_no INT NOT NULL, -- 컬럼 레벨 제약 조건
  user_id VARCHAR(255) NOT NULL,
  user_pwd VARCHAR(255) NOT NULL,
  user_name VARCHAR(255) NOT NULL,
  gender VARCHAR(3),
  phone VARCHAR(255) NOT NULL,
  email VARCHAR(255)
)ENGINE = INNODB;

-- insert 테스트 (정상 입력)
INSERT
  INTO user_notnull
VALUES(
  1
, 'user01'
, 'pass01'
, '홍길동'
, '남'
, '010-1234-5678'
, 'hong123@gmail.com'
);

SELECT * FROM user_notnull;

-- insert 테스트 (not null 제약 조건 적용)
INSERT
  INTO user_notnull
VALUES(
  2
, NULL
, 'pass01'
, '홍길동'
, '남'
, '010-1234-5678'
, 'hong123@gmail.com'
);

-- (2) unique 제약 조건 : 중복 값 허가하지 않음
CREATE TABLE if NOT EXISTS user_unique(
  user_no INT NOT NULL UNIQUE, -- 컬럼 레벨 제약 조건
  user_id VARCHAR(255) NOT NULL,
  user_pwd VARCHAR(255) NOT NULL,
  user_name VARCHAR(255) NOT NULL,
  gender VARCHAR(3),
  phone VARCHAR(255) NOT NULL,
  email VARCHAR(255),
  UNIQUE(phone) -- 테이블 레벨 제약 조건(컬럼 명칭 명시)
)ENGINE = INNODB;

DESC user_unique;

-- insert 테스트 (정상 입력)
INSERT
  INTO user_unique
VALUES(
  1
, 'user01'
, 'pass01'
, '홍길동'
, '남'
, '010-1234-5678'
, 'hong123@gmail.com'
);

SELECT * FROM user_unique;

-- insert 테스트 (unique 제약 조건 적용)
INSERT
  INTO user_unique
VALUES(
  1
, 'user-1'
, 'pass01'
, '홍길동'
, '남'
, '010-1234-5678'
, 'hong123@gmail.com'
);


-- (3) primary key : 테이블의 식별자 역할(한 행을 구분)
-- not null + unique
-- 한 테이블 당 하나만 설정 가능
CREATE TABLE if NOT EXISTS user_primarykey(
  user_no INT PRIMARY KEY, -- 컬럼 레벨 제약 조건
  user_id VARCHAR(255) NOT NULL,
  user_pwd VARCHAR(255) NOT NULL,
  user_name VARCHAR(255) NOT NULL,
  gender VARCHAR(3),
  phone VARCHAR(255) NOT NULL,
  email VARCHAR(255)
  -- PRIMARY KEY -- 테이블 레벨 제약 조건
)ENGINE = INNODB;


-- insert 테스트 (정상 입력)
INSERT
  INTO user_primarykey
VALUES(
  1
, 'user01'
, 'pass01'
, '홍길동'
, '남'
, '010-1234-5678'
, 'hong123@gmail.com'
);

SELECT * FROM user_primarykey;

-- insert 테스트 (pk 제약 조건 적용)
INSERT
  INTO user_primarykey
VALUES(
  1 -- null, 1 넣어보면 오류 발생
, 'user-1'
, 'pass01'
, '홍길동'
, '남'
, '010-1234-5678'
, 'hong123@gmail.com'
);