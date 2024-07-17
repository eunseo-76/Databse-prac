-- 17. procedure (프로시저)

-- (1) 매개변수 없는 간단한 예제
-- 프로시저 생성
DELIMITER // -- '//'는 구분자

CREATE PROCEDURE getAllEmployees()
BEGIN
    SELECT emp_id, emp_name, salary
    FROM employee;
END // -- '//'는 구분자

DELIMITER ; -- 다시 구분자를 ;로 하겠다

-- 프로시저 호출
CALL getAllEmployees();


-- (2) in 매개변수 : 호출 시 전달된 값을 사용
-- 특정 부서의 직원 정보 조회 프로시저

DELIMITER // -- '//'는 구분자

CREATE PROCEDURE getEmployeesByDepartment(
	IN dept CHAR(2) -- 매개변수(프로시저를 호출할 때 넘어가는 값)
)
BEGIN
    SELECT emp_id, emp_name, salary
     FROM employee
	 WHERE dept_code = dept;
END // -- '//'는 구분자

DELIMITER ; -- 다시 구분자를 ;로 하겠다

-- 프로시저 호출
CALL getEmployeesByDepartment('D5');
CALL getEmployeesByDepartment('D9');

-- (3) out 매개변수 : 결과 값을 호출한 곳으로 반환
-- 특정 직원의 급여를 반환하는 프로시저

-- 프로시저 생성
DELIMITER // -- '//'는 구분자

CREATE PROCEDURE getAllEmployees()
BEGIN
    SELECT emp_id, emp_name, salary
    FROM employee;
END // -- '//'는 구분자

DELIMITER ; -- 다시 구분자를 ;로 하겠다

-- 프로시저 호출
CALL getAllEmployees();


-- (2) in 매개변수 : 호출 시 전달된 값을 사용
-- 특정 부서의 직원 정보 조회 프로시저

DELIMITER // -- '//'는 구분자

CREATE PROCEDURE getEmployeeeSalary(
	IN id VARCHAR(3),
	OUT sal DECIMAL(10,2) -- 반환해주는 것
)
BEGIN
    SELECT salary INTO sal -- 값을 저장할 수 있는 공간 선택
     FROM employee
	 WHERE emp_id = id;
END // -- '//'는 구분자

-- 받아온 id가 emp_id와 일치하는 행을 sal 변수에 집어넣는 것

DELIMITER ; -- 다시 구분자를 ;로 하겠다

-- 프로시저 호출
-- @ : 사용자 변수 선언
SET @sal = 0; -- 이 변수를 out 매개변수에 선언
CALL getEmployeeeSalary('201', @sal);
SELECT @sal;

-- (4) inout 매개변수
-- 특정 직원의 급여를 증가시키고 증가된 급여(보너스 포함) 반환하는 프로시저

-- 프로시저 생성
DELIMITER // -- '//'는 구분자

CREATE PROCEDURE updateAndReturnSalary(
	IN id VARCHAR(3),
	INOUT sal DECIMAL(10,2) -- 전달, 반환 둘다
)
BEGIN
    UPDATE employee -- 여기는 update
      SET salary = sal
    WHERE emp_id = id;
    
    SELECT salary + (salary * IFNULL(bonus, 0)) INTO sal -- 이 값이 테이블에 update 되지는 x
      FROM employee
    WHERE emp_id = id;
END // -- '//'는 구분자

DELIMITER ; -- 다시 구분자를 ;로 하겠다

-- 프로시저 호출
SET @new_sal = 9000000;
CALL updateAndReturnSalary('200', @new_sal);
SELECT @new_sal;

-- (5) if else 활용
-- 특정 직원의 급여가 특정 값보다 높은지 여부를 확인하는 프로시저

-- 프로시저 생성
DELIMITER // -- '//'는 구분자

CREATE PROCEDURE checkEmployeeSalary(
	IN id VARCHAR(3),
	IN threshold DECIMAL(10,2), -- 임계치, 기준치 가져옴. 임계치보다 salary가 높은지 판단 위해
	OUT result VARCHAR(50)
)
BEGIN
	-- 매개변수가 아닌 내붕에서 사용 될 변수 선언
	DECLARE sal DECIMAL(10,2);
	
	SELECT salary INTO sal
	  FROM employee
	 WHERE emp_id = id;
	 
	IF sal > threshold THEN
		SET result = '기준치를 넘는 급여입니다.';
	ELSE
		SET result = '기준치와 같거나 기준치 이하의 급여입니다.';
	END if; -- if 블럭의 종료(까먹지 마세요)
END // -- '//'는 구분자

DELIMITER ; -- 다시 구분자를 ;로 하겠다

-- 프로시저 호출
SET @result = '';
CALL checkEmployeeSalary('200', 3000000, @result); -- 200번이라는 사원이 3백만원 이상인지 확인
SELECT @result;

-- (6) case 활용
-- 프로시저 생성
DELIMITER //

CREATE PROCEDURE getDepartmentMessage(
	IN id VARCHAR(3), -- id 값 전달 받음
	OUT message VARCHAR(100) -- 메세지 반환
)
BEGIN
	DECLARE dept VARCHAR(50);
	
	SELECT dept_code INTO dept -- id 값 기준으로 부서 코드를 알아와서 dept에 넣기
	  FROM employee
	 WHERE emp_id = id;
	
	case -- case - end case 로 시작과 끝을 알림
		when dept = 'D1' then -- when 조건이 맞으면 then 실행
			SET message = '인사관리부 직원이시군요!';
		when dept = 'D2' then
			SET message = '인사관리부 직원이시군요!';
		when dept = 'D3' then
			SET message = '인사관리부 직원이시군요!';
		ELSE -- when 조건이 아무것도 맞지 않으면 else 실행
			SET message = '어떤 부서 직원이신지 모르겠어요!';
	END case;
END //

DELIMITER ;

-- 프로시저 호출
SET @message = '';
CALL getDepartmentMessage('221', @message); -- 200번이라는 사원이 3백만원 이상인지 확인
SELECT @message;

-- (7) while 활용
-- 프로시저 생성
DELIMITER //

CREATE PROCEDURE calculateSumUpTo(
	IN max_num INT, -- max_num에 10 전달했다고 가정
	OUT sum_result INT
)
BEGIN
	DECLARE current_num INT DEFAULT 1; -- 필요한 변수들 선언. 현재 번호 1, 총합 0
	DECLARE total_num INT DEFAULT 0;
	
	while current_num <= max_num DO -- while 반복할 조건 DO 수행할 동작
		SET total_num = total_num + current_num; -- 합계 = 합계 + 현재 숫자
		SET current_num = current_num +1; -- 현재 숫자 1씩 증가
	END while; -- while-end while
	
	SET sum_result = total_num; -- out 매개변수에 구한 결과 담기
END //

DELIMITER ;

-- 프로시저 호출
-- set @result = ''; 이렇게 선언 안 해도 되는 이유: 세션이 유지되는 동안은 계속 유지되기 때문
CALL calculateSumUpTo(10, @result); -- 200번이라는 사원이 3백만원 이상인지 확인
SELECT @result;

-- (8) 예외 처리
-- 보통 10 / 2 는 되지만 10 / 0 하면 나누기를 할 수 없다는 오류가 나옴.
-- 프로시저 생성
DELIMITER //

CREATE PROCEDURE divideNumbers(
	IN numerator DOUBLE, -- 나누어질 대상 ex) 10
	IN denominator DOUBLE, -- 나눌 수 ex) 2
	OUT result DOUBLE -- 나눈 결과
)
BEGIN
	DECLARE divisino_by_zero CONDITION FOR SQLSTATE '45000'; -- 사용자 정의 예외 선언(sql 자체에서 처리하는 오류 x)
	
	DECLARE exit handler FOR divisino_by_zero -- 예외 발생 시 어떻게 취급할 것이냐
	BEGIN -- 예외 발생 시 begin-end 사이의 동작을 발생시킨다
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = '0으로 나눌 수 없습니다.';
	END;
	
	if denominator = 0 then -- 나눌 값이 0 이면 예외 처리
		SIGNAL divisino_by_zero; -- 예외를 발생시킴 
	ELSE
		SET result = numerator / denominator;
	END if;
END //

DELIMITER ;

-- 프로시저 호출
CALL divideNumbers(10, 2, @result); -- 200번이라는 사원이 3백만원 이상인지 확인
SELECT @result;
CALL divideNumbers(10, 0, @result);


-- ----------------------------------------------------------------------------------
-- stored function
-- function 생성
DELIMITER //

CREATE FUNCTION getAnnualSalary(
	id VARCHAR(3) -- function은 in,out 매개변수 x 전달받고자 하는 값(이름, 자료형)만 나열
)
RETURNS DECIMAL(15,2) -- function은 연산 결과 값을 돌려줘야 함. 어떤 타입으로 돌려줄지 작성
DETERMINISTIC -- functon 호출 시 항상 동일한 값을 반환하는지
BEGIN
	DECLARE monthly_salary DECIMAL(10, 2); -- 월급, 연봉 변수 선언
	DECLARE annual_salary DECIMAL(15, 2);
	
	SELECT salary INTO monthly_salary -- 조회한 salary를 monthly_salary에
	  FROM employee
	 WHERE emp_id = id;
	
	   SET annual_salary = monthly_salary * 12;
	RETURN annual_salary;

END //

DELIMITER ;

-- function 확인
SELECT
		 emp_name
	  , salary
	  , getAnnualSalary(emp_id)
  FROM employee;
-- function : employee 테이블에 있는 emp_id를 전달하면, id에 맞는 salary를 조회하고
-- 12를 곱한 결과가 반환됨
-- sql 내장 함수도 이런 식으로 만들어졌을 것이라고 유추 가능