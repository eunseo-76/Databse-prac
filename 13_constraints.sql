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

-- (4) Foreign key : 참조 제약 조건(참조 무결성 위배하지 않도록)
-- 참조 대상 테이블
CREATE TABLE if NOT EXISTS user_grade(
  grade_code INT NOT NULL UNIQUE,
  grade_name VARCHAR(255) NOT NULL
);
DESC user_grade;
INSERT
  INTO user_grade
VALUES
(10, '일반회원'),
(20, '우수회원'),
(30, '특별회원');

SELECT * FROM user_grade;

-- fk 적용할 테이블
CREATE TABLE if NOT EXISTS user_foreignkey1(
  user_no INT PRIMARY KEY,
  user_id VARCHAR(255) NOT NULL,
  user_pwd VARCHAR(255) NOT NULL,
  user_name VARCHAR(255) NOT NULL,
  gender VARCHAR(3),
  phone VARCHAR(255) NOT NULL,
  email VARCHAR(255),
  grade_code INT,
  FOREIGN KEY(grade_code) REFERENCES user_grade(grade_code)
)ENGINE = INNODB;

DESC user_foreignkey1;
SELECT * FROM user_foreignkey1;

-- insert 테스트 (정상 입력)
INSERT
  INTO user_foreignkey1
VALUES(
  1
, 'user01'
, 'pass01'
, '홍길동'
, '남'
, '010-1234-5678'
, 'hong123@gmail.com'
, 10
);

SELECT * FROM user_foreignkey1;

-- insert 테스트 (fk 제약 조건 적용)
INSERT
  INTO user_foreignkey1
VALUES(
  2
, 'user01'
, 'pass01'
, '홍길동'
, '남'
, '010-1234-5678'
, 'hong123@gmail.com'
, 40 -- null 이면 insert 잘 됨
);

-- fk 제약 조건이 걸려있을 때 들어갈 수 있는 값은: 참조하고 있는 컬럼의 값, null 값
-- 그 외 값을 입력하면 오류 발생

-- fk 적용 시 삭제를 설정
CREATE TABLE if NOT EXISTS user_foreignkey2(
  user_no INT PRIMARY KEY,
  user_id VARCHAR(255) NOT NULL,
  user_pwd VARCHAR(255) NOT NULL,
  user_name VARCHAR(255) NOT NULL,
  gender VARCHAR(3),
  phone VARCHAR(255) NOT NULL,
  email VARCHAR(255),
  grade_code INT,
  FOREIGN KEY(grade_code) REFERENCES user_grade(grade_code)
  ON UPDATE SET NULL ON DELETE SET NULL
  -- update 또는 delete할 때 update, delete 가능하게 하고 참조값을 null로 설정
  -- 부모 테이블에서 행이 update, delete 될 때 자식 테이블의 fk 값이 null이 된다
  -- 부모 테이블의 변경이 자식 테이블에 미치는 영향을 정의하는 것
  
  -- ON UPDATE SET CASCADE ON DELETE SET CASCADE
  -- update 시 변경 된 값으로 참조 값도 변경하고
  -- delete 시 참조 값이 있는 행도 삭제
)ENGINE = INNODB;

DESC user_foreignkey2;
SELECT * FROM user_foreignkey2;

-- insert 테스트 (정상 입력)
INSERT
  INTO user_foreignkey2
VALUES(
  2
, 'user01'
, 'pass01'
, '홍길동'
, '남'
, '010-1234-5678'
, 'hong123@gmail.com'
, 20
);

SELECT * FROM user_foreignkey2;

-- 참조 대상 테이블 user_grade 수정
UPDATE user_grade
   SET grade_code = NULL
 WHERE grade_code = 10;
-- 첫 번째 테이블은 삭제 불가하게 되어 있어서 오류 발생

-- 삭제 불가로 되어 있는 첫 번째 테이블 삭제 후 테스트
-- gui 에서 user_grade의 grade_code null 허용 > 저장 후 다시 테스트
DROP TABLE user_foreignkey1;
UPDATE user_grade
   SET grade_code = NULL
 WHERE grade_code = 10;
SELECT * FROM user_foreignkey2; -- grade_code가 null로 되어있는 것 확인 가능

DELETE
  FROM user_grade
 WHERE grade_code = 20; -- 20 넣어놓은 값이 null로 바뀜
 
-- 기본적으로 foreignkey 설정해놓고 아무것도 안 하면 삭제 불가!

-- (5) check 제약 조건
-- 원하는 값의 범위 확인
CREATE TABLE if NOT EXISTS user_check (
  user_no INT AUTO_INCREMENT PRIMARY KEY,
  user_name VARCHAR(255) NOT NULL,
  gender VARCHAR(3) CHECK (gender IN ('남', '여')),
  age INT CHECK(age >= 19)
);
DESC user_check;

-- insert 테스트 (정상 수행)
INSERT
  INTO user_check
VALUES
(NULL, '홍길동', '남', 20);

SELECT * FROM user_check;

-- insert 테스트 (check 제약 조건 위반)
INSERT
  INTO user_check
VALUES
-- (NULL, '홍길동', '남성', 20); -- '남' 이 아니라 '남성'
(NULL, '홍길동', '남', 18); -- 나이가 19이상이 아님
SELECT * FROM user_check;

-- (6) default : 컬럼에 null 대신 기본 값 적용 가능
-- insert 시 아무것도 안 쓰면 null이 들어가지만
-- null이 아니라 다른 값이 들어가도록 설정 가능
-- 컬럼이름 데이터 타입 default 제약 조건 <- 이 순서로 작성ㅇ
CREATE TABLE if NOT EXISTS tbl_country(
  country_code INT AUTO_INCREMENT PRIMARY KEY,
  country_name VARCHAR(255) DEFAULT '한국',
  population VARCHAR(25) DEFAULT '0명',
  add_day DATE DEFAULT(CURRENT_DATE), -- 현재 시간을 기본 값으로 처리
  add_time DATETIME DEFAULT (CURRENT_TIME)
) ENGINE = INNODB;

DESC tbl_country;

INSERT
  INTO tbl_country
VALUES (NULL, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
-- 존재하는 모든 컬럼의 값을 다 써 줌

SELECT * FROM tbl_country;

INSERT
  INTO tbl_country
(country_name)
VALUES
('미국');
-- 특정 컬럼에만 명시적으로 값을 넣고 나머지는 default로
-- 위의 insert 보단 이걸 위해서 사용한다