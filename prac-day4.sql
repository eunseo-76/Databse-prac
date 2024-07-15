-- #: pk
-- *: not null
-- o: null able null이 가능함

-- q1
-- 다음 논리ERD와 물리ERD를 참고하여, 아래 조건을 만족하는 테이블을 생성하는 DDL 구
-- 문을 작성하세요.

-- 내 답
CREATE TABLE if NOT EXISTS TEAM_INFO (
  TEAM_CODE INT auto_increment PRIMARY KEY COMMENT '소속코드',
  TEAM_NAME VARCHAR(100) NOT NULL COMMENT '소속명',
  TEAM_DETAIL VARCHAR(500) COMMENT '소속상세정보',
  USE_YN CHAR(2) NOT NULL DEFAULT 'Y' COMMENT '사용여부'
  CHECK(USE_YN IN ('Y', 'N'))
) ENGINE = INNODB COMMENT '소속정보';
DESC team_info;
SELECT * FROM team_info;

CREATE TABLE if NOT EXISTS MEMBER_INFO(
	MEMBER_CODE INT auto_increment PRIMARY KEY COMMENT '회원코드',
	MEMBER_NAME VARCHAR(70) NOT NULL COMMENT '회원이름',
	BIRTH_DATE DATE COMMENT '생년월일',
	DIVISION_CODE CHAR(2) COMMENT '구분코드',
	DETAIL_INFO VARCHAR(500) COMMENT '상세정보',
	CONTACT VARCHAR(50) NOT NULL COMMENT '연락처',
	TEAM_CODE INT NOT NULL COMMENT '소속코드',
	ACTIVE_STATUS CHAR(2) NOT NULL DEFAULT 'Y' COMMENT '활동상태',
	CHECK(ACTIVE_STATUS IN ('Y', 'N', 'H')),
	FOREIGN KEY(TEAM_CODE) REFERENCES TEAM_INFO(TEAM_CODE)
) ENGINE = INNODB COMMENT '회원정보';

DESC member_info;

-- 답안
DROP TABLE IF EXISTS member_info;
DROP TABLE IF EXISTS team_info;

CREATE TABLE IF NOT EXISTS team_info (
	team_code INT AUTO_INCREMENT COMMENT '소속코드',
	team_name VARCHAR(100) NOT NULL COMMENT '소속명',
	team_detail VARCHAR(500) COMMENT '소속상세정보',
	use_yn CHAR(2) NOT NULL DEFAULT 'Y' COMMENT '사용여부',
	PRIMARY KEY (team_code),
	CHECK (use_yn IN ('Y', 'N'))
) ENGINE=INNODB COMMENT '소속정보';

CREATE TABLE member_info (
	member_code INT AUTO_INCREMENT COMMENT '회원코드',
	member_name VARCHAR(70) NOT NULL COMMENT '회원이름',
	birth_date DATE COMMENT '생년월일',
	division_code CHAR(2) COMMENT '구분코드',
	detail_info VARCHAR(500) COMMENT '상세정보',
	contact VARCHAR(50) NOT NULL COMMENT '연락처',
	team_code INT NOT NULL COMMENT '소속코드',
	active_status CHAR(2) NOT NULL DEFAULT 'Y' COMMENT '활동상태',
	PRIMARY KEY (member_code),
	FOREIGN KEY (team_code) REFERENCES team_info (team_code),
	CHECK (active_status IN ('Y', 'N', 'H'))
) ENGINE=INNODB COMMENT '회원정보';

-- q2
-- Q1에서 생성한 TEAM_INFO 테이블과 MEMBER_INFO 테이블에 아래와 같이 데이터를
-- INSERT하는 쿼리를 작성하세요.
-- 단, 삽입 대상 컬럼명은 반드시 명시해야 합니다.

-- 내 답
INSERT
  INTO team_info
(team_code, team_name, team_detail, USE_yn)
VALUES
(NULL, '음악감상부', '클래식 및 재즈 음악을 감상하는 사람들의 모임', 'Y'),
(NULL, '맛집탐방부', '맛집을 찾아다니는 사람들의 모임', 'N'),
(NULL, '행복찾기부', NULL, 'Y');
SELECT * FROM team_info;

INSERT
  INTO member_info
(member_code, MEMNER_NAME, birth_date, division_code, detail_info, contact, team_code, active_status)
VALUES
(NULL, '송가인', '1999-01-30', '1', '안녕하세요 송가인입니다~', '010-9494-9494', 1, 'H'),
(NULL, '임영웅', '1992-05-03', NULL, '국민아들 임영웅입니다~', 'hero@trot.com', 1, 'Y'),
(NULL, '태진아', NULL, NULL, NULL, '(1급 기밀)', 3, 'Y');

SELECT * FROM member_info;

DELETE FROM member_info where 1=1; -- auto_increment 초기화 안 됨
TRUNCATE TABLE member_info; -- auto_increment 초기화 됨

-- 답안
INSERT INTO 
	team_info(team_code, team_name, team_detail, use_yn)
VALUES 
	(null, '음악감상부', '클래식 및 재즈 음악을 감상하는 사람들의 모임', 'Y');
INSERT INTO 
	team_info(team_name, team_detail, use_yn)
VALUES 
	('맛집탐방부', '맛집을 찾아다니는 사람들의 모임', 'N');
INSERT INTO 
	team_info(team_name)
VALUES 
	('행복찾기부');
    
INSERT INTO 
	member_info(member_code, member_name, birth_date, division_code, detail_info, contact, team_code, active_status)
VALUES 
	(null, '송가인', '1990-01-30', 1, '안녕하세요 송가인입니다~', '010-9494-9494', 1, 'H');
INSERT INTO 
	member_info(member_name, birth_date, detail_info, contact, team_code, active_status)
VALUES 
	('임영웅', '1992-05-03', '국민아들 임영웅입니다~', 'hero@trot.com', 1, 'Y');
INSERT INTO 
	member_info(member_name, contact, team_code)
VALUES 
	('태진아', '(1급 기밀)', 3);