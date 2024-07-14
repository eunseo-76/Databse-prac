-- q1
-- 재직 중이고 휴대폰 마지막 자리가 2인 직원 중 입사일이 가장 최근인 직원 3명의
-- 사원번호, 직원명, 전화번호, 입사일, 퇴직여부를 출력하세요.
-- 참고. 퇴사한 직원은 퇴직여부 컬럼값이 ‘Y’이고, 재직 중인 직원의 퇴직여부 컬럼값은 ‘N’
SELECT
		  emp_id
		, emp_name
		, phone
		, hire_date
		, ent_yn
  FROM employee
 WHERE ent_yn = 'n' AND phone LIKE '%2'
ORDER BY hire_date DESC
 LIMIT 3;


-- q2
-- 재직 중인 ‘대리’들의 직원명, 직급명, 급여, 사원번호, 이메일, 전화번호, 입사일을 출력하세요.
-- 단, 급여를 기준으로 내림차순 출력하세요.

-- 22행이나 나오는데 머징
SELECT
		  e.emp_name 직원명
		, j.job_name 직금병
		, e.salary 급여
		, e.emp_id 사원번호
		, e.email 이메일
		, e.phone 전화번호
		, e.hire_date 입사일
  FROM employee e
  JOIN job j ON e.job_code = e.job_code
 WHERE j.job_name = '대리' AND e.ent_yn ='N'
 ORDER BY e.salary DESC;


-- q3
-- 재직 중인 직원들을 대상으로 부서별 인원, 급여 합계, 급여 평균을 출력하고,
-- 마지막에는 전체 인원과 전체 직원의 급여 합계 및 평균이 출력되도록 하세요.
-- 단, 출력되는 데이터의 헤더는 컬럼명이 아닌
-- ‘부서명’, ‘인원’, ‘급여합계’, ‘급여평균’으로 출력되도록 하세요.





-- q4
-- 전체 직원의 직원명, 주민등록번호, 전화번호, 부서명, 직급명을 출력하세요.
-- 단, 입사일을 기준으로 오름차순 정렬되도록 출력하세요.

SELECT
		  e.emp_name 직원명
		, e.emp_no 주민등록번호
		, e.phone 전화번호
		, d.dept_title 부서명
		, j.job_name 직급명
  FROM employee e
  left JOIN department d ON e.dept_code = d.dept_id
  left JOIN job j ON e.job_code = j.job_code
ORDER BY hire_date ASC;
-- 그냥 join 했는데 안 되는 이유: dept_code가 null값인 게 있음.


-- q5
-- <1단계> 전체 직원 중 연결된 관리자가 있는 직원의 인원을 출력하세요.
-- 참고. 연결된 관리자가 있다는 것은 관리자사번이 NULL이 아님을 의미함

SELECT
		  COUNT(*)
  FROM employee
 WHERE manager_id IS NOT NULL;

-- <2단계> 1단계에서 조회한 내용에는 문제가 조금 있습니다. 관리자사번이 존재하여 연결된
-- 관리자가 있기는 하나, 해당 관리자가 직원 목록에 존재하지 않는 직원이 있습니다.
-- 따라서 1단계를 디벨롭하여 직원 목록에 관리자사번이 존재하는 직원의 인원을 출력하세요.

-- ent yn 말고 manager_id가 오류인 게 있음!!

SELECT
		  COUNT(*)
  FROM employee
 WHERE manager_id IS NOT NULL
 	AND manager_id IN (SELECT
									  emp_id	
		    					FROM employee);
 

-- 이거 2개는 왜 값이 다를까... 왜 이게 답이 아닌 지는 알겠음
        
SELECT
		  COUNT(*)
  FROM employee
 WHERE manager_id IS NOT NULL
 	AND manager_id not IN (SELECT
					  emp_id	
		    FROM employee
         WHERE ent_yn = 'Y');
         
SELECT
		  COUNT(*)
  FROM employee
 WHERE manager_id IS NOT NULL
 	AND manager_id IN (SELECT
					  emp_id	
		    FROM employee
         WHERE ent_yn = 'N');


-- <3단계> 모든 직원의 직원명과 관리자의 직원명을 출력하세요.
-- 참고. ‘모든 직원’이므로 관리자가 존재하지 않는 직원도 출력되어야 합니다.
SELECT
		  emp_name
  FROM employee;
  
-- 관리자의 직원명
SELECT
		  a.emp_name
		, 
  FROM employee a
  JOIN employee b ON a.emp_name = emp_code
 WHERE a.emp_


-- <4단계> 관리자가 존재하는 직원의 직원명, 부서명, 관리자의 직원명, 관리자의 부서명을 출력하세요.
