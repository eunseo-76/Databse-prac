-- TEST5-1. 사용자 이메일 주소로 비밀번호 찾기

SELECT USER_PW
  FROM USER
 WHERE USER_EMAIL = 'user8@gmail.com' AND IS_ACTIVE = 1;
 
-- TEST5-2. (로그인 한) 사용자의 닉네임, 비밀번호, 핸드폰 번호 변경
UPDATE USER
SET
  USER_NICKNAME = 'minho_choi'
, USER_PW ='12choi**92mh'
, USER_PHONE = '010-0000-0000'
WHERE USER_EMAIL = 'user10@gmail.com' AND IS_ACTIVE = 1;

-- TEST5-3. 내가 작성한 게시글에 댓글이 달리면 알림 전송
-- 알림 STATUS 추가 필요

DELIMITER // 

CREATE OR REPLACE TRIGGER COMMENT_NOTIF
    AFTER INSERT -- 댓글 테이블에 새 댓글이 INSERT 되면
    ON QUESTION_COMMENT
    FOR EACH ROW
    USER_ID
    
    
BEGIN
END//

DELIMITER ;

-- 댓글 INSERT(게시판ID) -> 게시글을 작성한 사람의 ID에 알림을 보내줘야 함
-- 댓글 INSERT -> 
--  댓글 테이블의 게시판 ID를 보고, 해당 게시글을 작성한 USER_ID 획득 ->
-- 해당 USER_ID를 이용해 알림테이블에 알림 정보 INSERT

INSERT
INTO NOTIFICATION
(
USER_ID, NOTIF_TYPE, IS_READ, NOTIF_CONTENT
)
VALUES
(_______, 'C', 0, NOTIF_CONTENT = '내가 작성한 글에 댓글이 달렸습니다.'
);

-- 어떤 게시글을 누가 작성했고 누가 댓글을 달았는지 알려주는 쿼리
SELECT
  p.question_id AS '댓글이 달린 게시글'
, p.user_id AS '게시글 작성자'
, c.comment_id AS '댓글 id'
FROM question_post p
LEFT JOIN question_comment c ON p.question_id = c.question_id
WHERE p.question_id = c.question_id;

SELECT
  p.user_id AS '게시글 작성자'
FROM question_post p
LEFT JOIN question_comment c ON p.question_id = c.question_id
WHERE p.question_id = c.question_id;


INSERT
INTO notification
(user_id, notif_type, is_read, notif_content)
VALUES
(
(SELECT
  p.user_id AS '게시글 작성자'
FROM question_post p
LEFT JOIN question_comment c ON p.question_id = c.question_id
WHERE p.question_id = c.question_id)
, 'C'
, 0
, '내가 작성한 글에 댓글이 달렸습니다.'
);


-- 이렇게 하면 select가 여러 개 row 가져온다는 오류
DELIMITER // 

CREATE OR REPLACE TRIGGER COMMENT_NOTIF
    AFTER INSERT -- 댓글 테이블에 새 댓글이 INSERT 되면
    ON QUESTION_COMMENT
    FOR EACH ROW
BEGIN
    INSERT
    INTO NOTIFICATION
	   (user_id, notif_type, is_read, notif_content)
	 VALUES
	   (
		(SELECT
		  p.user_id AS '게시글 작성자'
		FROM question_post p
		LEFT JOIN question_comment c ON p.question_id = c.question_id
		WHERE p.question_id = c.question_id)
		, 'C'
		, 0
		, '내가 작성한 글에 댓글이 달렸습니다.'
		);	 
END//

DELIMITER ;

-- 최종 트리거
DELIMITER // 

CREATE OR REPLACE TRIGGER COMMENT_NOTIF
    AFTER INSERT -- 댓글 테이블에 새 댓글이 INSERT 되면
    ON QUESTION_COMMENT
    FOR EACH ROW
BEGIN
	 DECLARE POST_AUTHOR_ID INT;
	 
	 -- 새 댓글이 달린 게시글의 작성자 id 조회
	 SELECT USER_ID INTO POST_AUTHOR_ID
	 FROM QUESTION_POST
	 WHERE QUESTION_ID = NEW.QUESTION_ID;
	 
	 INSERT
	 INTO NOTIFICATION
	 (USER_ID, NOTIF_TYPE, IS_READ, NOTIF_CONTENT)
    VALUES
    (
        POST_AUTHOR_ID,
        'C',
        0,
        '내가 작성한 글에 댓글이 달렸습니다.'
    );
	 
	 
END//

DELIMITER ;



SHOW TRIGGERS;
DROP TRIGGER if EXISTS comment_notif;

-- 댓글 insert 테스트
INSERT INTO question_comment
VALUES
(NULL, 20, 1, '이것도 모르시남...', NOW());

-- 1번 사용자가 작성한 11번 게시글에 8번 사용자가 댓글을 달았음
INSERT INTO QUESTION_COMMENT
VALUES
(NULL, 11, 8, '챗지피티한테 물어보세요', NOW());
