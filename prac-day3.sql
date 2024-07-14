-- q1
-- 부서별 직원 급여의 총합 중 가장 큰 액수를 출력하세요.

SELECT
		 MAX()
  FROM employee e;

-- 부서별로 직원 분류
-- 부서별 직원 급여 sum
-- 부서별 직원 max select


SELECT
		 SUM(salary) AS '부서별 급여 총합'
  FROM employee
 GROUP BY dept_code;

-- 내 답
SELECT
		 MAX(dept_sum)
	FROM (SELECT
					 SUM(salary) AS 'dept_sum' -- 메인 쿼리에서 사용되므로 as 필수
			  FROM employee
			 GROUP BY dept_code) AS subquery; -- 여기는 왜 필수지?

-- 인라인 뷰인 서브쿼리에는 as가 반드시 있어야 함
-- 그런데 왜 두 개나??


-- q2
-- 서브쿼리를 이용하여 영업부인 직원들의 사원번호, 직원명, 부서코드, 급여를 출력하세요.
-- 참고. 영업부인 직원은 부서명에 ‘영업’이 포함된 직원임

-- 
-- 영업부 코드로 영업부 직원 분류
-- 영업부 직원 정보 select

SELECT
		 *
  FROM employee e
  JOIN department d ON e.dept_code = d.dept_id
 WHERE d.dept_title LIKE '%영업%';

-- 내 답
SELECT
		 emp_id
	  , emp_name
	  , dept_code
	  , salary
  FROM (SELECT
					 *
			  FROM employee e
			  JOIN department d ON e.dept_code = d.dept_id
			 WHERE d.dept_title LIKE '%영업%') AS subquery; -- 서브쿼리 as 필수
			 
			 
-- q3
-- 서브쿼리와 JOIN을 이용하여 영업부인 직원들의 사원번호, 직원명, 부서명, 급여를 출력하세요.

SELECT
		 *
  FROM employee e
  JOIN department d ON e.dept_code = d.dept_id
 WHERE d.dept_title LIKE '%영업%';

-- 내 답
SELECT
		 emp_id
	  , emp_name
	  , dept_title
	  , salary
  FROM(SELECT
					 *
			  FROM employee e
			  JOIN department d ON e.dept_code = d.dept_id
			 WHERE d.dept_title LIKE '%영업%') AS subquery;

-- q4
-- 1. JOIN을 이용하여 부서의 부서코드, 부서명, 해당 부서가 위치한 지역명, 국가명을 추출
-- 하는 쿼리를 작성하세요.

-- dept-location / location - national
-- 내 답
SELECT
		 d.dept_id
	  , d.dept_title
	  , local_name
	  , national_name
  FROM department d
  JOIN location l ON d.location_id = l.local_code
  JOIN national n USING (national_code);


-- q4
-- 2. 위 1에서 작성한 쿼리를 서브쿼리로 활용하여 모든 직원의 사원번호, 직원명, 급여, 부서
-- 명, (부서의) 국가명을 출력하세요.
-- 단, 국가명 내림차순으로 출력되도록 하세요.

SELECT
		 d.dept_id
	  , d.dept_title
	  , local_name
	  , national_name
  FROM department d
  JOIN location l ON d.location_id = l.local_code
  JOIN national n USING (national_code)
 ORDER BY national_code DESC;

-- 내 답
SELECT
		 emp_id
	  , emp_name
	  , salary
	  , dept_title
	  , national_name
  FROM employee e
  JOIN (SELECT
					 d.dept_id
				  , d.dept_title
				  , local_name
				  , national_name
			  FROM department d
			  JOIN location l ON d.location_id = l.local_code
			  JOIN national n USING (national_code)
			 ORDER BY national_code DESC) AS s ON e.dept_code = s.dept_id;
			 -- 서브쿼리 join 시 on 조건 까먹지 말기!!
			 
-- q5
-- 러시아에서 발발한 전쟁으로 인해 정신적 피해를 입은 직원들에게 위로금을 전달하려고 합
-- 니다. 위로금은 각자의 급여에 해당 직원의 급여 등급에 해당하는 최소 금액을 더한 금액으로
-- 정했습니다.

-- Q4에서 작성한 쿼리를 활용하여 해당 부서의 국가가 ‘러시아’인 직원들을 대상으로, 직원의
-- 사원번호, 직원명, 급여, 부서명, 국가명, 위로금을 출력하세요.
-- 단, 위로금 내림차순으로 출력되도록 하세요.

SELECT
		 *
  FROM employee e
  JOIN sal_grade sg USING (sal_level);
  
-- 내 답

SELECT
		 e.emp_id
	  , e.emp_name
	  , e.salary
	  , s.dept_title
	  , s.national_name
	  , sg.min_sal -- 추가
  FROM employee e
  JOIN (SELECT
					 d.dept_id
				  , d.dept_title
				  , local_name
				  , national_name
			  FROM department d
			  JOIN location l ON d.location_id = l.local_code
			  JOIN national n USING (national_code)
			 ORDER BY national_code DESC) AS s ON e.dept_code = s.dept_id
	JOIN sal_grade sg USING (sal_level) -- 추가
 WHERE national_name = '러시아';
 
-- 서브 쿼리는 이미 department 기준으로 join을 하기 때문에, employee의 sal_level과 join 해야하는
-- sal_grade는 서브쿼리와 join하지 못 함.