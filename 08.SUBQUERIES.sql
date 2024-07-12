-- 08. subqueries
-- 서브쿼리: 다른 쿼리(메인 쿼리) 내에서 실행되는 쿼리
-- 서브쿼리를 통해 복잡한 메인 쿼리를 한 번에 여러 작업을
-- 수행하도록 할 수 있다.


-- 서브쿼리
SELECT
		 category_code
  FROM tbl_menu
 WHERE menu_name = '민트미역국';
 
 
-- 메인쿼리
SELECT
		 menu_name
  FROM tbl_menu
 WHERE category_code = 4;
 
-- 메인쿼리 내에서 서브쿼리 작성
SELECT
		 menu_name
  FROM tbl_menu
 WHERE category_code = (SELECT
										 category_code
								  FROM tbl_menu
								 WHERE menu_name = '민트미역국');
								 
-- 서브쿼리를 활용한 메인 쿼리
--- 이번에는 where이 아니라 from 절에서 사용
-- from 절에서 쓰이는 서브쿼리는 인라인뷰라고 한다
-- 서브쿼리가 조회의 대상이 됨! 내가 원하는 결과를 인라인 뷰로 만들고
-- 그 결과에서 다시금 무언가를 조회하는 용도로도 활용이 된다
SELECT
		 MAX(COUNT)
  FROM (SELECT COUNT(*) AS 'count'
  				 FROM tbl_menu
  				GROUP BY category_code) AS countmenu;
  				
-- 상관 서브 쿼리
-- 메인 쿼리가 서브 쿼리의 결과에 영향을 주는 형태

-- 서브쿼리가 메인 쿼리에 있는 값과 비교하고 있음. 서브쿼리만 따로 실행불가
-- 실행 순서: 메인 쿼리의 table 접근. 그리고 where 절로. > 판단하려면 서브쿼리.
-- 서브 쿼리 역시 tbl_menu 접근
-- a table의 첫 메뉴가 있음. 이 메뉴는 4번 카테고리를 가지고 있음.
-- 똑같은 atable에서 4번인 애들의 평균을 냄. 8000원이 나오면 그걸 처음 본 테이블의 값들과 가격과 비교.
SELECT
		 menu_code
		,menu_name
		,menu_price
		,category_code
		,orderable_status
  FROM tbl_menu a
WHERE menu_price > (SELECT AVG(menu_price)
						    FROM tbl_menu
						   WHERE category_code = a.category_code);
						   
-- exists : 조회 결과가 있을 때 true, 없을 때 false
SELECT
		 category_name
  FROM tbl_category a
 WHERE EXISTS (SELECT 1
 					  FROM tbl_menu b
 					 WHERE b.category_code = a.category_code)
ORDER BY 1;
-- 서브쿼리는 메인 쿼리가 함께 있어야 하는 상관 쿼리
-- select 할 지를 where 절에서 판단.

-- 이거 is null 로는 안 되나? is null은 어떤 값이 있냐 없냐고
-- exist는 특정 값을 찾는건가?

-- CTE(Common Table Expression)
-- 인라인 뷰로 쓰이는 서브쿼리로 미리 정의해서 사용
WITH menucate AS (
	SELECT menu_name
		, category_name
	  FROM tbl_menu a
	  JOIN tbl_category b ON a.category_code = b.category_code
)
SELECT -- 이 메인 쿼리가 복잡해진다면 서브쿼리를 넣었을 때 읽기 힘들 수 있음
		 * -- 그래서 미리 정의해두고 가져온다
  FROM menucate
ORDER BY menu_name;