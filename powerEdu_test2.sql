-- TEST2. 휴대폰 번호 형식 테스트
-- '0XX-YYYY-ZZZZ' 혹은 '0XX-YYY-ZZZZ' 형태만 입력 허용

-- 기존 휴대폰 번호 입력 테스트
INSERT INTO user
  VALUES
 (NULL, 'test2@gmail.com', 'tttt', 'test2', '테스트2', 'F', '1985-11-12', '44444444', 0, 0, 1);

SELECT * FROM user;
-- 기존에는 휴대폰 번호를 아무렇게나 입력해도 들어감

CREATE TABLE IF NOT EXISTS `USER`
(
    `USER_ID`    INT NOT NULL AUTO_INCREMENT COMMENT '사용자ID',
    `USER_EMAIL`    VARCHAR(100) NOT NULL COMMENT '사용자이메일',
    `USER_PW`    VARCHAR(255) NOT NULL COMMENT '비밀번호',
    `USER_NICKNAME`    VARCHAR(30) NOT NULL COMMENT '닉네임',
    `USER_NAME`    VARCHAR(255) NOT NULL COMMENT '이름',
    `USER_GENDER`    CHAR(1) NOT NULL COMMENT '성별',
    CHECK (USER_GENDER IN ('M', 'F')),
    `USER_BIRTH`    DATE NOT NULL COMMENT '생년월일',
    `USER_PHONE`    VARCHAR(13) NOT NULL COMMENT '휴대폰번호',
    CHECK (USER_PHONE REGEXP '^0[0-9]{2}-[0-9]{3,4}-[0-9]{4}$' OR USER_PHONE REGEXP '^0[0-9]{9,10}$'),
    `USER_AUTH`    BOOLEAN NOT NULL DEFAULT '1' COMMENT '권한',
    `IS_NOTIFIED`    BOOLEAN DEFAULT '1' NOT NULL COMMENT '알림수신여부',
    `IS_ACTIVE`    BOOLEAN DEFAULT '1' NOT NULL COMMENT '탈퇴여부',
 PRIMARY KEY ( `USER_ID` )
) COMMENT = '사용자';

-- INSERT 테스트 010-1234-5678 (INSERT 성공)
INSERT INTO user
  VALUES
 (NULL, 'test2@gmail.com', 'tttt', 'test2', '테스트2', 'F', '1985-11-12', '010-1234-5678', 0, 0, 1);

-- INSERT 테스트 01012345678 (INSERT 성공)
INSERT INTO user
  VALUES
 (NULL, 'test2-1@gmail.com', 'tttt', 'test2-1', '테스트2-1', 'F', '1985-11-12', '01012345678', 0, 0, 1);
 
-- INSERT 테스트 123-456-7890 (INSERT 실패)
INSERT INTO user
  VALUES
 (NULL, 'test2-1@gmail.com', 'tttt', 'test2-1', '테스트2-1', 'F', '1985-11-12', '123-456-7890', 0, 0, 1);