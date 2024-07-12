-- 09. set operators : 두 개 이상의 select문의 결과 집합을 결합
-- union, union all, intersect, minus

-- 1. union
-- 두 개 이상의 select 문의 결과를 결합하여 중복 레코드 제거 후 반환
SELECT
		 menu_code
		,menu_name
		,menu_price
		,category_code
		,orderable_status
  FROM tbl_menu
 WHERE category_code = 10
 UNION
 SELECT
		 menu_code
		,menu_name
		,menu_price
		,category_code
		,orderable_status
  FROM tbl_menu
 WHERE menu_price < 9000;
-- 6개 와 9개 였지만 UNION 하니 최종적으로 10개 항이 나옴(중복 있음)

-- 2. union all
-- 두 개 이상의 select 문의 결과를 결합하여 중복 레코드 제거하지 않고 반환
SELECT
		 menu_code
		,menu_name
		,menu_price
		,category_code
		,orderable_status
  FROM tbl_menu
 WHERE category_code = 10
 UNION ALL
 SELECT
		 menu_code
		,menu_name
		,menu_price
		,category_code
		,orderable_status
  FROM tbl_menu
 WHERE menu_price < 9000;
 
-- 3. INTERSECT : 두 select 의 결과 중 공통되는 레코드만 반환
-- mysql, mariaddb에서는 제공하지 않는 연산자로 inner join 또는 in 연산자로
-- 구현 가능하다

-- inner join
SELECT
		 a.menu_code
		,a.menu_name
		,a.menu_price
		,a.category_code
		,a.orderable_status
  FROM tbl_menu a
  JOIN (SELECT
					 menu_code
					,menu_name
					,menu_price
					,category_code
					,orderable_status
  			  FROM tbl_menu
          WHERE menu_price < 9000) b ON (a.menu_code = b.menu_code) 
 WHERE a.category_code = 10;
 

-- in 연산자
SELECT
		 a.menu_code
		,a.menu_name
		,a.menu_price
		,a.category_code
		,a.orderable_status
  FROM tbl_menu a
 WHERE a.category_code = 10
   AND a.menu_code IN (SELECT
   									 menu_code
					  			   FROM tbl_menu
					           WHERE menu_price < 9000);
					           
-- 4. minus : 첫 번쨰 select 문의 결과에서 두 번째 select 문의
-- 결과가 포함하는 레코드를 제외한 레코드를 반환
-- mysql, mariadb는 제공하지 않는 연산자로 left join을 통해 구현 가능

SELECT
		 a.menu_code
		,a.menu_name
		,a.menu_price
		,a.category_code
		,a.orderable_status
  FROM tbl_menu a
  left JOIN (SELECT
					 menu_code
					,menu_name
					,menu_price
					,category_code
					,orderable_status
  			  FROM tbl_menu
          WHERE menu_price < 9000) b ON (a.menu_code = b.menu_code) 
 WHERE a.category_code = 10
   AND b.menu_code IS NULL;
-- a와 b의 중복은 5새. a 총 6, b 총 9개. 우리는 a -(a교b) 하려는 것
-- left join 해서 b의 결과를 빼고 남은 결과 조회(b 카테고리가 null인 것만 남기겠다)
