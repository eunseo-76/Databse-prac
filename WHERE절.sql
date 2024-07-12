-- 03. where : 특정 조건에 맞는 레코드만을 선택

-- 1. 비교 연산자 사용
SELECT
		 menu_code
		, menu_name
	FROM tbl_menu
WHERE orderable_status = 'Y';

-- 메뉴 가격이 13000원인 메뉴
SELECT
		 menu_code
		, menu_name
		, menu_price
	FROM tbl_menu
WHERE menu_price = 13000;

-- 대소 비교 (>, >=, <, <=)
SELECT
		 menu_code
		, menu_price
	FROM tbl_menu
WHERE menu_price <= 13000;


-- 2. 논리 연산자
-- (1) AND 연산자
SELECT 1 AND 2; -- T AND T
SELECT 1 AND 0, 0 AND 0, 0 AND NULL;
SELECT 1 AND NULL, NULL AND NULL;

-- 주문 가능하며 category_code가 10에 해당하는 메뉴 조회
SELECT
		 menu_code
		, menu_name
		, category_code
		, orderable_status
	FROM tbl_menu
WHERE orderable_status = 'Y'
	AND category_code = 10;
	
-- (2) OR: 또는
SELECT 1 OR 1, 1 OR 0, 0 OR 1;
SELECT 0 OR 0;
SELECT 1 OR NULL, 0 OR NULL, NULL OR NULL;

-- 가격이 5000원 이상이거나 카테고리 코드가 10인 메뉴 조회
SELECT
		 menu_code
		, menu_name
		, category_code
		, orderable_status
	FROM tbl_menu
WHERE menu_price >= 5000
	 OR category_code > 10;
	 
-- and 와 or의 우선 순위 고려
-- and가 or 보다 우선순위가 높다
SELECT 1 OR 0 AND 0;
SELECT (1 OR 0) AND 0;

SELECT FIELD('A', 'A', 'B', 'C');
SELECT FIELD('B', 'A', 'B', 'C');
SELECT FIELD('C', 'A', 'B', 'C');

SELECT
		 menu_name
		, orderable_status
		, FIELD(orderable_status, 'N', 'Y')
	FROM tbl_menu;
	
	
SELECT * FROM tbl_menu;


-- 3. between 연산자
SELECT
		 menu_name
		, menu_price
		, category_code
	FROM tbl_menu
WHERE menu_price >= 10000
	AND menu_price >= 25000
ORDER BY menu_price;

SELECT * FROM tbl_menu;
SELECT
		 menu_name
		, menu_price
		, category_code
	FROM tbl_menu
WHERE menu_price BETWEEN 10000 AND 25000
ORDER BY menu_price;

-- between은 한글은 안 되는 듯?
SELECT
		 menu_name
		, menu_price
		, category_code
	FROM tbl_menu
WHERE menu_name BETWEEN '과메기커틀릿' AND '흑마늘아메리카노'
ORDER BY menu_name;


-- not 연산자 사용
SELECT
		 menu_name
		, menu_price
		, category_code
	FROM tbl_menu
WHERE menu_price NOT BETWEEN 10000 AND 25000
ORDER BY menu_price;

-- 4. like 연산자
SELECT
		 menu_code
		, menu_name
	FROM tbl_menu
WHERE menu_name LIKE '흑%';

-- NOT 연산자 사용
SELECT
		 menu_code
		, menu_name
	FROM tbl_menu
WHERE menu_name NOT LIKE '%마늘%';

-- 메뉴 가격이 5000원 이상이고, 카테고리 코드가 10이며,
-- 메뉴 이름에 갈치가 들어가는 메뉴 조회(모든 컬럼 값 조회)

SELECT
		 menu_code
		, menu_name
		, category_code
		, menu_price
		, orderable_status
	FROM tbl_menu
WHERE menu_price >= 5000 
	AND category_code = '10' 
	AND menu_name LIKE '%갈치%';
	

-- 5. in 연산자
SELECT
		 menu_code
		, category_code
	FROM tbl_menu
WHERE category_code = 4
	OR category_code = 5
	OR category_code = 6
ORDER BY category_code;

-- 줄맞춤 이쁘게 어떻게 하지?;;

SELECT
		 menu_code
		, category_code
	FROM tbl_menu
WHERE category_code IN (4, 5, 6)
ORDER BY category_code;

-- 6. IS NULL : null 값 비교
SELECT
		 category_code
		, category_name
		, ref_category_code
	FROM tbl_category
WHERE ref_category_code IS NULL;

SELECT
		 category_code
		, category_name
		, ref_category_code
	FROM tbl_category
WHERE ref_category_code IS NOT NULL;