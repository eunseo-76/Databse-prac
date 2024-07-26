UPDATE USER
  SET IS_ACTIVE = 0, IS_NOTIFIED = 0
 WHERE USER_ID = 1;
 
UPDATE `USER`
SET `IS_ACTIVE` = 0,
    `USER_EXIT_DATE` = NOW(),
    `USER_EMAIL` = 'deleted',
    `USER_PHONE` = '000-0000-0000',
    `USER_NAME` = '탈퇴한 사용자',
    `USER_NICKNAME` = 'Deleted'
WHERE `IS_ACTIVE` = 1
  AND `USER_ID` = 21;
  

UPDATE NOTIFICATION
SET IS_READ = 1
WHERE USER_ID = 3;


-- lecture
CREATE TABLE IF NOT EXISTS `LECTURE`
(
    `LECTURE_ID`    INT NOT NULL AUTO_INCREMENT COMMENT '강의ID',
    `TEACHER_ID`    INT NOT NULL COMMENT '강사ID',
    `LECTURE_TITLE` VARCHAR(255) NOT NULL COMMENT '강의명',
    `LECTURE_DESCRIPTION`    LONGTEXT NOT NULL COMMENT '강의설명',
    `LECTURE_TIME`    INT NOT NULL COMMENT '강의시간',
    `LECTURE_DIFFICULTY`    CHAR(1) NOT NULL COMMENT '난이도' CHECK(LECTURE_DIFFICULTY IN ('상', '중', '하')),
    `LECTURE_PRICE`    DECIMAL(10) NOT NULL COMMENT '강의구매가격',
    `IS_INTERESTED`    BOOLEAN DEFAULT '0' NOT NULL COMMENT '관심등록여부',
    FOREIGN KEY (`TEACHER_ID`) REFERENCES `USER`(`USER_ID`),
 	  PRIMARY KEY (`LECTURE_ID`)
) COMMENT = '강의';

-- lecture dummy
INSERT INTO LECTURE
 VALUES
(NULL, 1, '입문자바', '이것은 입문자바에 대한 강의입니다.', 100, '하', 10000, 0),
(NULL, 4, '기본자바', '이것은 기본자바에 대한 강의입니다.', 300, '중', 23000, 0),
(NULL, 6, '심화자바', '이것은 심화자바에 대한 강의입니다.', 500, '상', 47000, 0),
(NULL, 8, '입문파이썬', '이것은 입문파이썬에 대한 강의입니다.', 120, '하', 15000, 0),
(NULL, 10, '기본파이썬', '이것은 기본파이썬에 대한 강의입니다.', 370, '중', 37000, 0),
(NULL, 13, '심화파이썬', '이것은 심화파이썬에 대한 강의입니다.', 480, '상', 52000, 0),
(NULL, 15, '입문c++', '이것은 입문c++에 대한 강의입니다.', 150, '하', 18000, 0),
(NULL, 17, '기본c++', '이것은 기본c++에 대한 강의입니다.', 390, '중', 34000, 0);

-- QUESTION_POST
CREATE TABLE IF NOT EXISTS `QUESTION_POST`
(
    `QUESTION_ID`    INT NOT NULL AUTO_INCREMENT COMMENT '질문게시판ID',
    `USER_ID`    INT NOT NULL COMMENT '사용자ID',
    `LECTURE_ID` 	INT NOT NULL COMMENT '강의ID',
    `USER_NICKNAME`	VARCHAR(30) NULL COMMENT '사용자닉네임',
    `QUESTION_TITLE`    VARCHAR(255) NOT NULL COMMENT '질문제목',
    `QUESTION_CONTENT`    LONGTEXT NOT NULL COMMENT '질문내용',
    `QUESTION_TIME`    DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '작성시간',
    `IS_DELETED`	BOOLEAN DEFAULT 0 NOT NULL COMMENT '질문삭제여부',
 PRIMARY KEY ( `QUESTION_ID` ),
 FOREIGN KEY(`USER_ID`) REFERENCES `USER`(`USER_ID`),
 FOREIGN KEY(`LECTURE_ID`) REFERENCES `LECTURE`(`LECTURE_ID`)
) COMMENT = '질문게시글';

INSERT INTO question_post
VALUES
(1, 2, 1, '별명1', '이 부분이 이해가 안가요', '평소에도 궁금한 내용이었는데, 강의보고 이해가 안가서 질문 남깁니다.', '2021-04-18 15:27', 0),
(2, 3, 1, '별명2', 'JAVA에서의 형 변환', '소괄호와 함께하면 괜찮을까요? 아니면, parse를 써야할까요?', '2021-03-19 12:13', 0),
(3, 7, 4,  '별명3','파이썬 아나콘다', '용량이 너무 많이 차지해서, 다른걸로 하려는데 추천 부탁드립니다.', '2022-04-13 9:01', 0),
(4, 9, 3,  '별명4','멀티 스레딩의 존재 여부', '멀티 스레딩을 왜 하는지 궁금합니다. JVM은 하나의 프로세서에서 진행되고, 스레드를 분할하면 효율이 적어지지 않나요?', '2023-07-09 00:53', 0);


-- REVIEW_POST
CREATE TABLE IF NOT EXISTS `REVIEW_POST`
(
	 `REVIEW_ID`	INT NOT NULL AUTO_INCREMENT COMMENT '후기게시판ID',
	 `USER_ID`	INT NOT NULL COMMENT '사용자ID',
	 `LECTURE_ID`	INT NOT NULL COMMENT '강의ID',
	 `USER_NICKNAME` VARCHAR(30) COMMENT '사용자닉네임',
	 `REVIEW_TITLE`	VARCHAR(255) NOT NULL COMMENT '후기게시판제목',
	 `REVIEW_CONTENT`	LONGTEXT NOT NULL COMMENT '후기게시판내용',
	 `REVIEW_RATE` INT NOT NULL COMMENT '후기별점',
	 `REVIEW_TIME`	DATETIME NOT NULL DEFAULT NOW() COMMENT '작성시간',
	 `LIKE_COUNT` INT COMMENT '좋아요_개수',
	 `IS_DELETED` BOOLEAN NOT NULL DEFAULT 0 COMMENT '후기삭제여부',
	 PRIMARY KEY(`REVIEW_ID`),
	 FOREIGN KEY(`USER_ID`) REFERENCES `USER`(`USER_ID`),
	 FOREIGN KEY(`LECTURE_ID`) REFERENCES `LECTURE`(`LECTURE_ID`),
	 CHECK (`REVIEW_RATE` BETWEEN 1 AND 5)
) COMMENT = '후기게시글';

-- question_comment

CREATE TABLE IF NOT EXISTS `QUESTION_COMMENT`
(
    `COMMENT_ID`    INT NOT NULL AUTO_INCREMENT COMMENT '댓글ID',
 	  `QUESTION_ID`    INTEGER NOT NULL COMMENT '질문게시판ID',
    `USER_ID`    INT NOT NULL COMMENT '사용자ID',
    `USER_NICKNAME` VARCHAR(30) NULL COMMENT '사용자닉네임',
    `COMMENT_CONTENT`    VARCHAR(255) NOT NULL COMMENT '댓글내용',
    `COMMENT_TIME`    DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '작성시간',
    `IS_DELETED`	BOOLEAN DEFAULT 0 NOT NULL COMMENT '댓글삭제여부',
 PRIMARY KEY ( `COMMENT_ID` ),
 FOREIGN KEY (`USER_ID`) REFERENCES `USER`(`USER_ID`),
 FOREIGN KEY (`QUESTION_ID`) REFERENCES `QUESTION_POST`(`QUESTION_ID`)
) COMMENT = '댓글';