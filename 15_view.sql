-- 15. view : select 쿼리문을 저장한 객체로, 가상 테이블로 불림
-- 실질적인 데이터를 물리적으로 저장하는 것이 아니라 논리적으로 저장
-- (1) 보안성, (2) 복잡한 select 구문을 간결하게 작성 가능

-- view 생성
-- as 뒤에 만들고 싶은 논리적인 뷰에 대한 select 구문 작성
CREATE VIEW hansik AS
SELECT
		 menu_code
	  , menu_name
	  , menu_price
	  , category_code
	  , orderable_status
  FROM tbl_menu
 WHERE category_code = 4;
 
-- view 조회
SELECT * FROM hansik;

-- 베이스 테이블의 데이터 변경 => view의 데이터 변경
INSERT
  INTO tbl_menu
VALUES (NULL, '식혜맛국밥', 5500, 4, 'Y');

SELECT * FROM tbl_menu;

-- view를 통한 dml => 
INSERT
  INTO hansik
VALUES (null, '수정과맛국밥', 5500, 4, 'Y'); -- 99는 처리해줘야 함. auto_increment 부여하지 않았기 때문

SELECT * FROM hansik;
SELECT * FROM tbl_menu;

UPDATE hansik
  SET menu_name = '버터맛 국밥'
	 , menu_price = 5700
 WHERE menu_code = 99;
 
DELETE
  FROM hansik
 WHERE menu_code = 99;
-- menu 테이블, hansik 뷰 둘 다 삭제 됨!

-- 위의 예시와는 달리, 경우에 따라서는 view 에서 dml 구문 작성이 불가할 수도 있음

-- view로 dml 명령이 조작이 불가능한 경우
-- (1) 뷰 정의에 포함 되지 않은 컬럼을 조작하는 경우
-- (2) 뷰에 포함되지 않는 컬럼 중 베이스테이블에 not null 조건이 있는 경우
-- (3) 산술 표현식이 정의된 경우
-- (4) join을 이용해 여러 테이블을 연결한 경우
-- (5) distinct를 포함한 경우
-- (6) 그룹함수 또는 group by 절을 포함한 경우

-- 생성한 view 삭제
DROP VIEW hansik;

-- view 생성 시의 옵션 : or replace
-- 원래 있던 걸 또 생성하면 오류가 나지만 이렇게 하면 이미 있는 view는 replace 됨
CREATE OR REPLACE VIEW hansik AS
SELECT
		 menu_codeinformation_schema
	  , menu_name
	  , menu_price
	  , category_code
	  , orderable_status
  FROM tbl_menu
 WHERE category_code = 4;