-- TEST7. 질문 게시판에 새로운 글이 INSERT 되었을 때 강사에게 알림 전송

DELIMITER // 

CREATE OR REPLACE TRIGGER QUESTION_NOTIF
    AFTER INSERT
    ON QUESTION_POST
    FOR EACH ROW
BEGIN
	 DECLARE LECTURE_TEACHER_ID INT;
	 
	 -- 질문 게시글이 올라온 강의의 강사 ID 조회
	 SELECT TEACHER_ID INTO LECTURE_TEACHER_ID
	 FROM LECTURE
	 WHERE LECTURE_ID = NEW.LECTURE_ID;
	 
	 INSERT
	 INTO NOTIFICATION
	 (USER_ID, NOTIF_TYPE, IS_READ, NOTIF_CONTENT)
    VALUES
    (
        LECTURE_TEACHER_ID,
        'Q',
        0,
        '나의 강의에 질문이 달렸습니다.'
    );
	 	 
END//

DELIMITER ;



SHOW TRIGGERS;
DROP TRIGGER if EXISTS QUESTION_NOTIF;

-- 10번 사용자가 17번 사용자(강사)가 만든 8번 강의에 대한 질문을 달았음
-- NOTIFICATION 테이블에 17번 사용자에 대한 알림이 INSERT 되어야 함
INSERT INTO QUESTION_POST
VALUES
(NULL, 10, 8, 'C++ 유니티', '선생님 C++ 강의 너무 좋은데 혹시 유니티 강의는 안 만드시나요?', NOW());


