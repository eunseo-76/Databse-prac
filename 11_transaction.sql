-- 11. transaction
-- : 데이터베이스에서 한 번에 수행되는 작업의 단위
-- 서비스 개발 시 반드시 개념 알아야 함

-- 기본적으로 commit이 자동으로 수행되도록(auto commit) 설정 되어 있으므로
-- 해당 설정을 변경한 뒤 테스트 한다.

SET autocommit = 1;	  -- autocommit 활성화
SET autocommit = ON;	  -- autocommit 활성화

SET autocommit = 0;	  -- autocommit 비활성화
SET autocommit = OFF;  -- autocommit 비활성화

START TRANSACTION;

SELECT * FROM tbl_menu;

INSERT INTO tbl_menu VALUES (NULL, '바나나해장국', 8500, 4, 'Y');
UPDATE tbl_menu SET menu_name = '수정된 이름' WHERE menu_code = 5;

-- transaction을 rollback
-- ROLLBACK;

-- transaction을 commit
COMMIT;
-- commit 이후 rollback => 마지막 commit 시점으로 돌아감
ROLLBACK;

-- primary key - (1) 중복 (2)x 값이 존재해야 한다 - null이 아님
-- 이므로 21, 23 이렇게 값이 떨어져 있어도 상관 x