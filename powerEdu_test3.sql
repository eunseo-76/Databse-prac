-- test3. 


INSERT INTO lecture
 VALUES
(NULL, 1, '입문자바', '이것은 입문자바에 대한 강의입니다.', 100, '하', 10000, 0),
(NULL, 4, '기본자바', '이것은 기본자바에 대한 강의입니다.', 300, '중', 23000, 0),
(NULL, 6, '심화자바', '이것은 심화자바에 대한 강의입니다.', 500, '상', 47000, 0),
(NULL, 8, '입문파이썬', '이것은 입문파이썬에 대한 강의입니다.', 120, '하', 15000, 0),
(NULL, 10, '기본파이썬', '이것은 기본파이썬에 대한 강의입니다.', 370, '중', 37000, 0),
(NULL, 13, '심화파이썬', '이것은 심화파이썬에 대한 강의입니다.', 480, '상', 52000, 0),
(NULL, 15, '입문c++', '이것은 입문c++에 대한 강의입니다.', 150, '하', 18000, 0),
(NULL, 17, '기본c++', '이것은 기본c++에 대한 강의입니다.', 390, '중', 34000, 0);

ALTER TABLE lecture AUTO_INCREMENT = 1;

DELIMITER //

CREATE OR REPLACE TRIGGER interest_lecture_insert
    BEFORE INSERT ON interest_lecture
    FOR EACH ROW
BEGIN
  IF NEW.`IS_INTERESTED` = TRUE AND OLD.`IS_INTERESTED` = FALSE THEN
    INSERT INTO `INTEREST_LECTURE` (`LECTURE_ID`, `INTEREST_USER_ID`, `IS_INTERESTED`)
    VALUES (NEW.`LECTURE_ID`, NEW.`TEACHER_ID`, TRUE);
  END IF;
 END//      

DELIMITER ;

-- delete 실행

INSERT INTO interest_lecture
VALUES (NULL, 1, 2, 0);


DELIMITER //

CREATE TRIGGER interest_lecture_insert
    BEFORE INSERT ON interest_lecture
    FOR EACH ROW
BEGIN
  IF NEW.`IS_INTERESTED` = TRUE THEN
    INSERT INTO `INTEREST_LECTURE` (`LECTURE_ID`, `INTEREST_USER_ID`, `IS_INTERESTED`)
    VALUES (NEW.`LECTURE_ID`, NEW.`INTEREST_USER_ID`, TRUE);
  END IF;
END//

DELIMITER ;

-- test
DELIMITER //

CREATE TRIGGER interest_lecture_insert
    BEFORE INSERT ON interest_lecture
    FOR EACH ROW
BEGIN
  IF NEW.`IS_INTERESTED` = TRUE THEN
  	 SET NEW.`LE
    INSERT INTO `INTEREST_LECTURE` (`LECTURE_ID`, `INTEREST_USER_ID`, `IS_INTERESTED`)
    VALUES (NEW.`LECTURE_ID`, NEW.`INTEREST_USER_ID`, TRUE);
  END IF;
END//

DELIMITER ;


-- interest_lecture 테이블에 데이터 삽입
INSERT INTO interest_lecture
VALUES (NULL, 1, 2, 1),  -- 이 행이 INTEREST_LECTURE 테이블에 추가될 것입니다.
       (NULL, 2, 2, 0); -- 이 행은 추가되지 않아야 합니다.

-- INTEREST_LECTURE 테이블에서 데이터 확인
SELECT * FROM interest_lecture;


-- ----------------------------------------------------------

-- 2. LECTURE 테이블 생성
CREATE TABLE IF NOT EXISTS `LECTURE`
(
    `LECTURE_ID` INT NOT NULL AUTO_INCREMENT COMMENT '강의ID',
    `TEACHER_ID` INT NOT NULL COMMENT '강사ID',
    `LECTURE_TITLE` VARCHAR(255) NOT NULL COMMENT '강의명',
    `LECTURE_DESCRIPTION` LONGTEXT NOT NULL COMMENT '강의설명',
    `LECTURE_TIME` INT NOT NULL COMMENT '강의시간',
    `LECTURE_DIFFICULTY` CHAR(1) NOT NULL COMMENT '난이도' CHECK (`LECTURE_DIFFICULTY` IN ('상', '중', '하')),
    `LECTURE_PRICE` DECIMAL(10,2) NOT NULL COMMENT '강의구매가격',
    `IS_INTERESTED` BOOLEAN DEFAULT FALSE NOT NULL COMMENT '관심강의여부',
    PRIMARY KEY (`LECTURE_ID`),
    FOREIGN KEY (`TEACHER_ID`) REFERENCES `USER`(`USER_ID`)
) COMMENT = '강의';


