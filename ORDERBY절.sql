-- 02. ORDER BY : SELECT 문의 결과 집합을 정렬 
SELECT
       menu_code
     , menu_name
     , menu_price
  FROM tbl_menu
 ORDER BY menu_price DESC; -- 기본 정렬 기준은 오름차순(ASC). 내림차순(DESC)
 
 
-- 정렬 기준이 2개 이상인 경우
SELECT
       menu_code
     , menu_name
     , menu_price
  FROM tbl_menu
 ORDER BY menu_price DESC, menu_name ASC;
 
-- 연산 결과 활용
SELECT
       menu_code
     , menu_name
     , menu_price
     , menu_code * menu_price AS '연산 결과'
  FROM tbl_menu
 ORDER BY 연산 결과;
 
-- field
-- 값이 몇 번째 위치에 있는지 찾을 때 사용
SELECT FIELD('A', 'A', 'B', 'C'); 
SELECT FIELD('B', 'A', 'B', 'C'); 
SELECT FIELD('C', 'A', 'B', 'C'); 

-- field + order by 함께 사용 시 원하는 순서로 정렬 가능
SELECT
       menu_name
     , orderable_status
     , FIELD(orderable_status, 'N', 'Y') AS '필드'
  FROM tbl_menu
 ORDER BY 필드;

SELECT
       menu_name
     , orderable_status
     , FIELD(orderable_status, 'Y', 'N') AS '필드'
  FROM tbl_menu
 ORDER BY 필드;

SELECT
		 menu_name
	  , orderable_status
	  , FIELD(orderable_status, 'X') -- 해당 값이 없는 경우 0 출력!
  FROM tbl_menu;

 
-- null 데이터의 정렬 순서

-- 오름차순(1->2->3) 시 NULL을 처음으로(DEFAULT)
SELECT
		 category_code
	  , category_name
	  , ref_category_code
  FROM tbl_category
 ORDER BY ref_category_code ASC; -- ASC 생략 가능

-- 내림차순(3->2->1)시 NULL을 마지막으로(DEFAULT)
SELECT
		 category_code
	  , category_name
	  , ref_category_code
  FROM tbl_category
 ORDER BY ref_category_code DESC;

-- 옿름차순 시 NULL을 마지막으로
-- 마이너스 부호는 null을 제외하고 정렬을 반대로 뒤집음
SELECT
       category_code
     , category_name
     , ref_category_code
  FROM tbl_category
 ORDER BY -ref_category_code DESC;

-- 내림차순 시 NULL을 처음으로
SELECT
       category_code
     , category_name
     , ref_category_code
  FROM tbl_category
 ORDER BY -ref_category_code ASC;


 
SELECT
		 category_code
	  , category_name
	  , ref_category_code
  FROM tbl_category
 ORDER BY -ref_category_code ASC;
 
-- 별칭(alias) 작성 시 AS 뒤에 작성하며 특수 문자 포함할 경우 ' ' 로 작성
-- order by 절에서는 ' ' 작성 시 정렬 적용 불가


SELECT FIELD('A', 'A', 'B', 'C');

SELECT
		  FIELD(orderable_status, 'N', 'Y')
		 , orderable_status
  FROM tbl_menu;
  
 