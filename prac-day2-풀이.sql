-- 1. 이름에 '형'자가 들어가는 직원들의 사번, 사원명, 부서명을 조회하시오.(1행)
SELECT
		  e.emp_id
		, e.emp_name
		, d.dept_title
  FROM employee e
  JOIN department d on e.dept_code = d.dept_id
 WHERE e.emp_name LIKE '%형%';

-- 2. 해외영업팀에 근무하는 사원명, 직급명, 부서코드, 부서명을 조회하시오.(9행)
SELECT
		  e.emp_name
		, j.job_name
		, e.dept_code
		, d.dept_title
  FROM employee e
  JOIN department d ON e.dept_code = d.dept_id
  JOIN job j ON e.job_code = j.job_code
 WHERE d.dept_title LIKE '%해외영업%'; -- where 위치는 상관 없나?

-- 3. 보너스포인트를 받는 직원들의 사원명, 보너스포인트, 부서명, 근무지역명을 조회하시오.(8행)(INNER JOIN 결과)
SELECT
		  e.emp_name
		, e.bonus
		, d.dept_title
		, l.local_name
  FROM employee e
  JOIN department d ON e.dept_code = d.dept_id -- department와 employee 조인 (dept title 위함)
  JOIN location l ON d.location_id = l.local_code -- location과 department 조인 (local name 위함)
 WHERE e.bonus IS NOT NULL;


-- 4. 부서코드가 D2인 직원들의 사원명, 직급명, 부서명, 근무지역명을 조회하시오.(3행)
SELECT
		  e.emp_name
		, j.job_name
		, d.dept_title
		, l.local_name
  FROM employee e
  JOIN job j ON e.job_code = j.job_code -- employee 와 job 조인 (job_name 위함)
  JOIN department d ON e.dept_code = d.dept_id -- employee 와 department 조인 (dept_title 위함)
  JOIN location l ON d.location_id = l.local_code -- location과 department 조인 (local_name 위함)
 WHERE e.dept_code = 'D2';


-- 5. 급여 테이블의 등급별 최소급여(MIN_SAL)보다 많이 받는 직원들의
-- 사원명, 직급명, 급여, 연봉을 조회하시오.
-- 연봉에 보너스포인트를 적용하시오.(20행)

SELECT
		  e.emp_name
		, j.job_name
		, e.salary
		, (12 * e.salary) + (1 + e.bonus) AS '연봉(보너스적용)'
  FROM employee e
  JOIN job j ON e.job_code = j.job_code -- employee 와 job 조인 (job_name 위함)
  JOIN sal_grade s ON e.sal_level = s.sal_level
 WHERE e.salary > s.min_sal;

-- 답안 : null 값을 처리하는 방법
-- ex) 월급이 2백만원이고 보너스 비율이 0.1일 때
-- 총 연봉 = 200 * 1.1 * 12
-- 숫자 * null 은 연산 불가하기 때문에 답이 이상하게 나올 수 있음

-- null 이면 0 반환
SELECT
       a.emp_name "사원명"
     , b.job_name "직급명"
     , a.salary "급여"
--      , a.salary * ( 1 + NVL(a.bonus, 0)) * 12 "연봉" // NVL은 oracle 함수
     , a.salary * ( 1 + IFNULL(a.bonus, 0)) * 12 "연봉"
  FROM employee a
  JOIN job b ON (a.job_code = b.job_code)
  JOIN sal_grade c ON (a.sal_level = c.sal_level)
 WHERE a.salary > c.min_sal;

 
-- 6. 한국(KO)과 일본(JP)에 근무하는 직원들의 
-- 사원명, 부서명, 지역명, 국가명을 조회하시오.(15행)

SELECT
		  e.emp_name
		, dept_title
		, l.local_name
		, n.national_name
  FROM employee e
  JOIN department d ON e.dept_code = d.dept_id -- employee 와 department 조인 (dept_title 위함)
  JOIN location l ON d.location_id = l.local_code
  JOIN national n ON l.NATIONAL_CODE = n.national_code -- location과location 조인 (national 위함)
 WHERE l.national_code IN ('KO','JP');


-- 7. 보너스포인트가 없는 직원들 중에서 직급코드가 J4와 J7인 직원들의 사원명, 직급명, 급여를 조회하시오.
-- 단, join과 IN 사용할 것(8행)
SELECT
		  e.emp_name
		, j.job_name
		, e.salary
  FROM employee e
  JOIN job j ON e.job_code = j.job_code
 WHERE (e.bonus IS NULL) AND (j.job_code IN ('J4', 'J7'));


-- 8. 직급이 대리이면서 아시아 지역(ASIA1, ASIA2, ASIA3 모두 해당)에 근무하는 직원 조회(2행)
-- 사번(EMPLOYEE.EMP_ID), 이름(EMPLOYEE.EMP_NAME), 직급명(JOB.JOB_NAME), 부서명(DEPARTMENT.DEPT_TITLE),
-- 근무지역명(LOCATION.LOCAL_NAME), 급여(EMPLOYEE.SALARY)를 조회하시오
-- (해당 컬럼을 찾고, 해당 컬럼을 지닌 테이블들을 찾고, 테이블들을 어떤 순서로 조인해야 하는지 고민하고 SQL문을 작성할 것)

SELECT
		  *
  FROM employee e
  JOIN department d ON e.dept_code = d.dept_id -- location 아시아 선택 위함
  JOIN location l ON d.location_id = l.local_code
  JOIN job j ON e.job_code = j.job_code
 WHERE j.job_code


-- 답안

SELECT
       a.emp_id
     , a.emp_name
     , b.job_name
     , c.dept_title
     , d.local_name
     , a.salary
  FROM employee a
  JOIN job b ON (a.job_code = b.job_code)
  JOIN department c ON (a.dept_code = c.dept_id)
  JOIN location d ON (c.location_id = d.local_code)
 WHERE b.job_name = '대리'
--   AND d.local_name IN ('asia1', 'asia2', 'asia3');
   AND d.local_name LIKE '%asia%';
