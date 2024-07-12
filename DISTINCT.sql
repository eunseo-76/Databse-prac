-- 04. distinct: 중복 컬럼 값 제거하고 조회
SELECT
		 category_code
	FROM tbl_menu
ORDER BY category_code;

-- 메뉴 테이블에 존재하는 카테고리 종류를 조회
SELECT
		 distinct category_code
	FROM tbl_menu
ORDER BY category_code;

-- null 값이 있는 컬럼에 사용했을 경우
SELECT
		 ref_category_code
  FROM tbl_category
 ORDER BY 1;
-- 숫자는 column의 순번으로 생각.
-- ref_category_code의 컬럼으로 정렬 하겠다는 의미로 order by 1

SELECT
		 distinct ref_category_code
  FROM tbl_category
 ORDER BY 1;
-- 이러면 null 필드가 하나만 됨


SELECT
		 category_code
		, category_name
		, ref_category_code
  FROM tbl_category
 ORDER BY 1; -- 1이면 category_name, 2면 category_name... 이런 의미임
 
-- 다중열에 distinct 키워드 사용 : 다중열 값들이 모두 동일하면 중복으로 판별
SELECT
		 category_code
		, orderable_status
  FROM tbl_menu;
 
-- distinct 키워드는 컬럼마다 붙이지 x
-- 여러 컬럼 가장 앞쪽에 붙임
SELECT
		 distinct category_code
		, orderable_status
  FROM tbl_menu;
-- 12의 Y 값이 여러 개 있었다면 하나만
-- 두 컬럼을 하나의 덩어리로 보았을 때 중복을 제거한다!