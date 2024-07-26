-- TEST6. 시청목표일이 지났을 때 알림 전송
-- 은 트리거가 아니라 이벤트로 하는 게 낫다 BY CHATGPT


-- 1번 사용자가 작성한 11번 게시글에 8번 사용자가 댓글을 달았음
INSERT INTO QUESTION_COMMENT
VALUES
(NULL, 11, 8, '시청목표일이 지났습니다!', NOW());
