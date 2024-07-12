-- 02. ORDER BY : SELECT 문의 결과 집합을 정렬
SELECT
		 menu_code
		, menu_name
		, menu_price
		, menu_code * menu_price AS '연산결과'
	FROM tbl_menu
ORDER BY 연산결과;

-- field
SELECT FIELD('A', 'A', 'B', 'C');
SELECT FIELD('B', 'A', 'B', 'C');
SELECT FIELD('C', 'A', 'B', 'C');

SELECT
		 menu_name
		, orderable_status
		, FIELD(orderable_status, 'N', 'Y')
	FROM tbl_menu;
ORDER BY FIELD(oderable_status_, 'N', 'Y');

SELECT * FROM tbl_category;
