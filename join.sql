SELECT * FROM tbl_menu;

-- 조인의 종류
-- 1. INNER JOIN: 두 테이블의 교집합을 반환(INNER 생략 가능)
-- (1) ON: 컬럼명이 동일하거나 동일하지 않거나 사용 가능
SELECT
		 a.menu_name
		,b.category_name
  FROM tbl_menu a
  JOIN tbl_category b ON a.category_code = b.category_code;

-- (2) USING: 컬럼명이 동일한 경우만 사용 가능
SELECT
		 a.menu_name
		,b.category_name
  FROM tbl_menu a
  JOIN tbl_category b USING (category_code); -- 하나의 컬럼 명칭만 써 주면 됨

-- employeeedb의 employee와 department join employeedb
SELECT
		 a.emp_name
		,b.dept_title
  FROM employee a
  JOIN department b ON a.dept_code = b.dept_id; -- INNER JOIN 이렇게 써도 됨
  
-- 2. LEFT JOIN
-- : 첫 번째 테이블의 모든 레코드와 두 번째 테이블에서 일치하는 레코드를 반환
SELECT
		 a.emp_name
		,b.dept_title
  FROM employee a
  LEFT JOIN department b ON a.dept_code = b.dept_id;

-- 3. RIGHT JOIN
-- : 두 번째 테이블의 모든 레코드와 첫 번째 테이블에서 일치하는 레코드를 반환
SELECT
		 a.emp_name
		,b.dept_title
  FROM employee a
  RIGHT JOIN department b ON a.dept_code = b.dept_id;

-- 4. CROSS JOIN
-- 두 테이블의 가능한 모든 조합을 반환하는 조인
SELECT
		 a.menu_name
	  , b.category_name
  FROM tbl_menu a
CROSS JOIN tbl_category b;


-- 5. self join
-- : 같은 테이블 내에서 행과 행 사이의 관계를 찾기 위해 사용되는 유형
SELECT
		 a.category_name 소분류
		,b.category_name 대분류
  FROM tbl_category a
  JOIN tbl_category b ON a.ref_category_code = b.category_code;


-- 사원이름, 매니저 이름
SELECT * FROM employee;

--내 답안
SELECT
		 a.emp_name AS '사원 이름'
		,b.emp_name AS '매니저이름'
  FROM employee a
  JOIN employee b ON a.emp_id = b.manager_id;
  
-- 정답
SELECT
		 a.emp_name 사원명
		,b.emp_name 관리자명
  FROM employee a -- employee a가 사원 정보를 쭉 살펴보는 기준
  JOIN employee b ON a.manager_id = b.emp_id;
-- 가지고 있는 사원의 전체 정보가 나오지는 않음. inner join을 했기 때문. null 값이 있는 사람들이 빠짐.

SELECT
		 a.emp_name 사원명
		,b.emp_name 관리자명
  FROM employee a
  left JOIN employee b ON a.manager_id = b.emp_id;
-- 매니저가 할당되지 않은 사람들은 보이지 않음
-- 반대로 매니저명 기준으로 하면 사원이 짤리나?

-- employeedb에서 다중 테이블 join
-- 사원명, 부서명, 직급명 조회
SELECT
		 a.emp_name
		,b.dept_title
		,c.job_name
  FROM employee a
  JOIN department b ON a.dept_code = b.dept_id;
  JOIN job c ON a.job_code = c.job_code;
-- 왜 job table 조인이 안 되지

-- 사원명, 근무 지역명, 근무 국가명 조회
-- 원하는 정보: emp_name, local_name, 
SELECT
		 a.emp_name
		,c.local_name
		,d.national_name
  FROM employee a
  JOIN department b ON a.dept_code = b.dept_id -- a와 b 사이는 department로 연결해야함
  JOIN location c ON b.location_id = c.local_code
  JOIN NATIONAL d ON c.national_code = d.national_code;
-- 조회하고 싶은 정보가 꼭 두 개 테이블에만 있는 게 아님!
-- 다시 테이블을 join, 또 join, 또 join 하는 상황이 있을 수도 있다!
  