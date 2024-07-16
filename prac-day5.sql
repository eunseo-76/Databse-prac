-- q1
-- 전화번호가 010으로 시작하는 직원의 직원명과 전화번호를 다음과 같이 출력하세요.

-- 내 답안
SELECT
		 emp_name AS EMP_NAME
	  , CONCAT_WS('-'
	  			     , SUBSTRING(phone, 1, 3)
				     , SUBSTRING(phone, 4, 4)
				     , SUBSTRING(phone, 4, 4)) AS PHONOE
  FROM employee
 WHERE phone LIKE '010%';
 
-- 답안
SELECT 
	emp_name,
	CONCAT(SUBSTRING(phone, 1, 3), '-', SUBSTRING(phone, 4, 4), '-', SUBSTRING(phone, 8, 4)) phone
FROM 
	employee 
WHERE 
	SUBSTRING(phone, 1, 3) = '010';


-- q2
-- 근속 일수가 20년 이상인 직원의 직원명, 입사일, 급여를 다음과 같이 출력하세요.
-- 단, 입사한 순서대로 출력하고 입사일이 같으면 급여가 높은 순서로 출력되도록 하세요.
-- 출력한 결과집합 헤더의 명칭은 각각 ‘직원명’, ‘입사일’, ‘급여’여야 함
-- 입사일은 ‘0000년 00월 00일’ 형식으로 출력해야 함
-- 급여는 천 단위로 , 를 찍어 출력해야 함

-- 내 답안
SELECT
		 emp_name AS 직원명
	  , concat(SUBSTRING(hire_date, 1, 4), '년 '
				, SUBSTRING(hire_date, 6, 2), '월 '
				, SUBSTRING(hire_Date, 9, 2), '일'
		  ) AS 입사
	  , FORMAT(salary, 0) AS 급여
  FROM employee;
 ORDER BY hire_date ASC;
 
-- 답안
SELECT 
	emp_name 직원명,
	CONCAT(YEAR(hire_date), '년 ', MONTH(hire_date), '월 ', DAY(hire_date), '일') 입사일,
	FORMAT(salary, 0) 급여
FROM 
	employee
WHERE 
	DATEDIFF(NOW(), hire_date) >= (20 * 365)
ORDER BY 
	hire_date, salary DESC;


-- q3
-- 모든 직원의 직원명, 급여, 보너스, 급여에 보너스를 더한 금액을 다음과 같이 출력하세요.
-- 단, 급여에 보너스를 더한 금액이 높은 순으로 출력되도록 하세요

-- 출력한 결과집합 헤더의 명칭은 각각 ‘EMP_NAME’, ‘SALARY’, ‘BONUS’,‘TOTAL_SALARY’여야 함
-- 보너스를 더한 급여는 소수점이 발생할 경우 반올림 처리함
-- 급여와 보너스를 더한 급여는 천 단위로 , 를 찍어 출력해야 함
-- 보너스는 백분율로 출력해야 함

-- 내 답안
SELECT
		 emp_name AS EMP_NAME
	  , salary AS SALARY
	  , concat(TRUNCATE(IFNULL(bonus, 0)*100, 0), '%') AS BONUS
	  , FORMAT(salary * (IFNULL(bonus, 0) + 1), 0) AS TOTAL_SALARY
  FROM employee
 ORDER BY TOTAL_SALARY DESC;
 
 SELECT
		 emp_name AS EMP_NAME
	  , salary AS SALARY
	  , concat(TRUNCATE(bonus * 100, 0), '%') AS BONUS
	  , FORMAT(salary * (IFNULL(bonus, 0) + 1), 0) AS TOTAL_SALARY
  FROM employee
 ORDER BY TOTAL_SALARY DESC;
 
-- 답안
SELECT 
	emp_name,
	FORMAT(salary, 0) salary,
	CONCAT(TRUNCATE(bonus * 100, 0), '%') bonus,
	FORMAT(salary + ROUND(salary * IFNULL(bonus, 0)), 0) total_salary
FROM 
	employee
ORDER BY 
	salary + ROUND(salary * IFNULL(bonus, 0)) DESC;
	-- format(...) 그대로 하면 문자 기준 정렬이기 떄문에
	-- format을 벗겨서 order by 해야 함

-- q4
-- 직원의 직원명과 이메일을 다음과 같이 출력하세요.
-- 출력한 결과집합 헤더의 명칭은 각각 ‘EMP_NAME’, ‘EMAIL’이어야 함
-- 이메일의 도메인 주소인 greedy.com 은 모두 동일하므로, 해당 문자열이 맞춰질 수 있
-- 도록 이메일의 앞에 공백을 두고 출력해야 함

-- 가장 긴 이메일 아이디에 맞춰서 앞에 공백 출력
-- 내 답안
SELECT
		 emp_name AS EMP_NAME
	  , SUBSTRING_INDEX(email, '@', 1)
	  , MAX(SUBSTRING_INDEX(email, '@', 1))
	  , lpad(email, LENGTH(MAX(SUBSTRING_INDEX(email, '@', 1))), ' ')
  FROM employee;

-- 답안
SELECT 
	emp_name,
	LPAD(email, (SELECT MAX(LENGTH(email)) FROM employee), ' ') email
FROM 
	employee;


-- 심화 답안

SELECT 
	emp_name,
	CONCAT( 
		LPAD (
			substring_index(email, '@', 1), 
            (SELECT MAX(LENGTH(substring_index(email, '@', 1))) FROM employee)
			, ' ') -- 여기까지 @ 앞의 부분 맞춰 줌
		, '@'
		, substring_index(email, '@', -1)) as email
 FROM 
	employee;
  

-- q5
-- 사내 행사 준비를 위해 직원 목록을 출력하려고 합니다. 직원 목록을 다음과 같이 출력하세요.
-- 단, 관리자의 이름순으로 정렬하여 출력되도록 하세요.
-- 직원명, 직급명, 주민등록번호, 부서가 있는 국가, 부서명, 해당 직원의 관리자 직원명을 출력해야 함

-- 출력한 결과집합 헤더의 명칭은 각각 ‘NAME_TAG’, ‘EMP_NO’, ‘BELONG’, ‘MANAGER_NAME’
-- 이어야 하며 출력 형식은 각각 아래와 같아야 함
	-- NAME_TAG : (직원명) (직급명)님
	-- EMP_NO : (생년월일6자리)-(뒷자리 한 자리를 제외하고는 *로 표시)
	-- BELONG : (부서의 국가)지사 (부서명) 소속
	
-- 내 답안
SELECT
		 concat(e.emp_name,' ', j.job_name, '님') AS NAME_TAG
	  , rpad(substring(e.emp_no, 1, 8), 14, '*') AS EMP_NO
	  , concat(n.national_name, '지사 ', d.dept_title, ' 소속') AS BELONG
	  , e2.emp_name AS MANAGER_NAME
  FROM employee e
  JOIN department d ON e.dept_code = d.dept_id -- a와 b 사이는 department로 연결해야함
  JOIN location l ON d.location_id = l.local_code
  JOIN NATIONAL n ON l.national_code = n.national_code
  JOIN job j ON e.job_code = j.job_code
  JOIN employee e2 USING (manager_id)
 ORDER BY e2.EMP_NAME ASC;
-- manager join 잘못 했는데?? self join? left join?

-- 답안
SELECT 
	CONCAT(e.emp_name, ' ', j.job_name, '님') name_tag,
	RPAD(SUBSTRING(e.emp_no, 1, 8), 14, '*') emp_no,
	CONCAT(n.national_name, '지사 ', d.dept_title, ' 소속') belong,
	ee.emp_name manager_name
FROM 
	employee e
LEFT JOIN 
	employee ee ON (e.manager_id = ee.emp_id)
LEFT JOIN 
	department d ON (e.dept_code = d.dept_id)
JOIN 
	job j ON (e.job_code = j.job_code)
JOIN 
	location l ON (d.location_id = l.local_code)
JOIN 
	national n ON (n.national_code = l.national_code)
ORDER BY 
	manager_name;