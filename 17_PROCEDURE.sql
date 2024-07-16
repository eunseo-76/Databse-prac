-- 17. procedure (프로시저)

-- (1) 매개변수 없는 간단한 예제
DELIMITER //

CREATE PROCEDURE getAllEmployees()
BEGIN
    SELECT emp_id, emp_name, salary
    FROM employee;
END //

DELIMITER ;

-- 프로시저 호출
CALL getAllEmployees();