-- 07. GROUPING

-- group by : 결과 집합을 특정 열의 값에 따라 그룹화
-- having : group by 절과 함께 사용하여 그룹의 조건을 적용 // having은 단독으로 쓰이는 경우 x

-- category code 기준으로 그룹핑 한 다음 조회하겠다
-- group 함수가 없으면 그냥 distinct와 다를 바가 없음
SELECT
		 category_code
  FROM tbl_menu
GROUP BY category_code;

-- group by는 그룹 함수와 함께 쓰임
-- count 함수
SELECT
		 category_code
		, COUNT(*)
  FROM tbl_menu
GROUP BY category_code;


-- count 함수의 특성
-- count 함수는 꼭 group by와 같이 쓸 필요 x
SELECT
		 COUNT(*)						-- 모든 행
		,COUNT(category_code)      -- 컬럼명 기재 시 값이 있는 행만 카운트
		,COUNT(ref_category_code) -- null 값 존재 시 카운트하지 않음
  FROM tbl_category;
  
  
-- sum 함수 사용: 합계(숫자로 된 데이터)를 나타내는 함수
SELECT
		 category_code
		, SUM(menu_price)
  FROM tbl_menu
GROUP BY category_code;

-- avg 함수 사용 : 평균(숫자로 된 데이터)을 나타내는 함수
SELECT
		 category_code
		, AVG(menu_price)
  FROM tbl_menu
GROUP BY category_code;

-- min, max 함수 사용 :
SELECT
		 category_code
		,MIN(menu_price)
  FROM tbl_menu
GROUP BY category_code;


SELECT
		 category_code
		,max(menu_price)
  FROM tbl_menu
GROUP BY category_code;


-- sum, avg는 숫자 데이터에 사용
-- count, min, max는 모든 데이터에 사용
SELECT
		 MIN(emp_name)
		,MAX(emp_name)
		,MIN(hire_date)
		,MAX(hire_date)
  FROM employee;
  
-- group by에서 2개 이상의 그룹 생성
-- 2개 컬럼을 모두 grouping 하는 기준으로 세워라
-- menu의 가격과 cateogry까지 같은 그룹은 1개 밖에 없어서 이런 결과가..
SELECT
		 menu_price
		,category_code
		,COUNT(*)
  FROM tbl_menu
GROUP BY menu_price, category_code;

-- join과 함께 사용
-- category 별로 묶었을 때 가격의 평균을 알기 위함
-- select 뒤에 category_code만 들어가도 되지 않나? -> select 뒤의 명시된 조건과 group by 조건이 똑같아야 함!
SELECT
		 a.category_code
		,b.category_name
		,avg(a.menu_price)
  FROM tbl_menu a
  JOIN tbl_category b ON (a.category_code = b.category_code) -- join은 대상 테이블을 여러 개 사용하기 때문에 from과 붙여서 사용
GROUP BY a.category_code, b.category_name;

-- having 절 사용 : 그루핑된 결과에 대한 조건
SELECT
		 a.category_code
		,b.category_name
		,AVG(a.menu_price) 메뉴가격평균
  FROM tbl_menu a
  JOIN tbl_category b ON (a.category_code = b.category_code)
GROUP BY a.category_code, b.category_name
-- HAVING AVG(a.menu_price) <= 10000;
HAVING 메뉴가격평균  <= 10000;

-- select : 조회 컬럼
-- from : 조회 대상 테이블
-- join : 조회 대상 테이블
-- where : 테이블 행을 조건으로 필터링
-- group by : 대상 컬럼으로 결과 집합 그루핑
-- having : 그루핑 결과를 조건으로 필터링
-- order by : 정렬 기준

-- 집계 함수 rollip
-- 컬럼 한 개를 활용했을 경우
SELECT
		 category_code
		 ,SUM(menu_price)
  FROM tbl_menu
GROUP BY category_code
  WITH ROLLUP;

-- 컬럼 두 개를 활용했을 경우
-- 중간 집계 후 최종 가격이 나타난다
SELECT
		 menu_price
		,category_code
		,SUM(menu_price)
  FROM tbl_menu
GROUP BY menu_price, category_code
  WITH ROLLUP;
