-- 10. DML(Data Manipulation Language)
-- : 데이터 조작 언어. 테이블에 값을 삽입하거나 수정하거나 삭제함

-- DML은 저자에 따라 select를 포함하기도, 포함하지 않기도 함.

-- (1) INSERT : 새로운 행을 추가
INSERT
 INTO tbl_menu -- 추가하고 싶은 테이블 명
VALUES -- 추가할 내용
(
  NULL -- null 입력했는데 숫자가 등록되는 이유는? menu_code가 auto increment 설정되어있기 때문
, '바나나해장국'
, 8500
, 4
, 'Y'
);

SELECT * FROM tbl_menu;

-- null 허용 가능 컬럼 or auto_increment 컬럼을 제외하고 insert
-- null 허용 가능 컬럼 or auto_increment 컬럼은 쓰지 않아도 됨
-- 하고 싶은 컬럼을 지정해서 insert 가능
INSERT
  INTO tbl_menu
( -- 이 내용이 생략되면 모든 컬럼에 대해 입력해야 한다! 순서도 잘 지켜야 함!
  menu_name
, menu_price
, category_code
, orderable_status
)
VALUES
(
  '초콜릿죽'
, 6500
, 7
, 'Y'
);

SELECT * FROM tbl_menu;

-- 컬럼을 명시적으로 작성했을 경우 데이터의 순서를 바꾸는 것도 가능
INSERT
  INTO tbl_menu
(
  orderable_status 
,  menu_price
, menu_name
, category_code
)
VALUES
(
  'Y'
, 6500
, '파인애플탕'
, 4
);

-- multi insert
INSERT
  INTO tbl_menu
VALUES
(NULL, '참치맛아이스크림', 1700, 12, 'Y'),
(NULL, '멸치맛아이스크림', 1500, 12, 'Y'),
(NULL, '소세지맛커피', 2500, 8, 'Y');

-- primary key의 경우 200 같은 아무 숫자를 넣어도 들어감(?)
-- 이미 있는 값이면  auto_increment 됨(?) 제대로 들은 게 맞나?

-- (2) UPDATE : 테이블에 기록 된 컬럼의 값을 수정
UPDATE tbl_menu
   SET category_Code = 7 -- 수정하고 싶은  컬럼
     , menu_name = '딸기맛붕어빵'
 WHERE menu_code = 24; -- 수정하고 싶은 대상 행을 미리 찾음
 
-- subquery를 update 절에 활용할 수 있다
-- 0~n개의 행이 업데이트 되며 테이블 전체 행의 수는 변화 없음
-- 수정하고 싶은 내용을 찾고자 할 때 서브쿼리를 이용해서 가져오는 것도 가능
UPDATE tbl_menu
   SET category_code = 6
 WHERE menu_code = (SELECT menu_code
 						    FROM tbl_menu
							WHERE menu_name = '파인애플탕');
-- where 절에서 조건을 만족하는 행을 찾아 update 하는 건데
-- 아무것도 update 되지 않을 수 있음(하단 영향 받은 행: 0)
-- 이렇게 조건이 잘못되면 (문법적 오류가 아니라도) update가 안 될 수도 있다

-- (3) DELETE : 테이블의 행을 삭제하는 구문
-- WHERE 절을 이용한 삭제
DELETE
  FROM tbl_menu
 WHERE menu_code = 24;
-- 현재는 menu_code가 고유값이라 하나의 행만 삭제됨.
-- 만약 24 code 가 없거나 5개나 있어었다면 0개가 삭제되거나 5개가 삭제될 수도 있음
 
-- limit을 활용한 삭제(offset 지정은 불가)
-- limit 1, 20 여기서 1이 offset. 1개를 뛰어넘는 것.
DELETE
  FROM tbl_menu
 ORDER BY menu_price
 LIMIT 2; -- 상위 2개 값 삭제

SELECT * FROM tbl_menu ORDER BY menu_price;

-- delete의 조건 없이 삭제 => 모든 행 삭제
DELETE
  FROM tbl_menu
 WHERE 1 = 1; -- where에 당연한 조건을 넣으면 경고 알람이 안 뜸
 
-- (4) REPLACE
-- replace를 통해 중복 된 데이터를 덮어 쓸 수 있다.
-- 있을 때 수정, 없을 때 삽입 하고 싶을 때 replace를 사용한다.
-- 일반적으로 많이 사용되지는 않음
REPLACE
  INTO tbl_menu -- INTO 생략도 가능함
VALUES
(
  17 -- replace가 아니라 insert 일 경우 menu_code 컬럼이 primary key(중복 값이 없어야 함)라 실행 x
, '참기름소주'
, 5000
, 10
, 'Y'
);
-- replace는 삽입+삭제 동작이므로 영향받은 행 2개가 됨

-- replace + set 함께 쓰면 where 절 없이 update 가능
REPLACE tbl_menu
	 SET menu_code = 2
     , menu_name = '우럭쥬스'
     , menu_price = 2000
     , category_code = 9
     , orderable_status = 'N'
     
