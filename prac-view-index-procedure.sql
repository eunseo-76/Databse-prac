-- q1 view 생성하기

-- 1단계: create table
CREATE TABLE if NOT EXISTS students(
	 student_id INT PRIMARY KEY,
	 name VARCHAR(255),
	 class VARCHAR(255)
) ENGINE=INNODB;

DESC students;

CREATE TABLE if NOT EXISTS grades(
	 grade_id INT PRIMARY KEY,
	 student_id INT,
	 FOREIGN KEY (student_id)
	 REFERENCES students(student_id),
	 subject VARCHAR(255),
	 grade CHAR
) ENGINE=INNODB;

DESC grades;

-- 2단계: 데이터 insert
INSERT
  INTO students
VALUES
(1, '유관순', 'A'),
(2, '신사임당', 'B'),
(3, '홍길동', 'A');

SELECT * FROM students;

INSERT
  INTO grades
VALUES
(1, 1, '과학', 'A'),
(2, 1, '수학', 'B'),
(3, 2, '과학', 'B'),
(4, 2, '수학', 'C'),
(5, 3, '과학', 'B'),
(6, 3, '수학', 'A');

-- 3단계: create view
CREATE VIEW student_grades AS
SELECT
	   subject
	  , NAME
	  , class
	  , grade
  FROM students s
  JOIN grades g ON s.student_id = g.student_id
 ORDER BY grade ASC;

-- 4단계 : select * from view
SELECT * FROM student_grades;

-- q2 index 생성/삭제

-- index 생성
CREATE INDEX emp_idx ON employee (dept_code);
-- index 조회
SELECT * FROM employee WHERE dept_code = 'D9';
explain SELECT * FROM employee WHERE dept_code = 'D9';
-- index 삭제
DROP INDEX emp_idx ON employee;
SHOW INDEX FROM employee;

-- q3 stored procedure 생성

DELIMITER // 

CREATE PROCEDURE addNumbers(
	IN num1 INT,
	IN num2 INT,
	OUT numSum INT
)
BEGIN
	DECLARE sumofnums INT DEFAULT 0;
	set sumofnums = num1 + num2;
	set numSum = sumofnums;
	-- 그냥 numSum = num1 + num2는 안 되나?
END //

DELIMITER ;

-- 프로시저 호출
SET @SUM = 0;
CALL addNumbers(10, 20, @SUM);
SELECT @SUM;


-- q4 stored function 생성
DELIMITER //

CREATE FUNCTION increasePrice(
	currPrice INT,
	proportion INT
)
RETURNS INT -- 10의 자리까지 버림??
DETERMINISTIC -- functon 호출 시 항상 동일한 값을 반환하는지
BEGIN
	DECLARE incrPrice INT;
	SELECT menu_price
	
	SELECT salary INTO currPrice;
	  FROM tbl_menu;
	
	   SET incrPrice = currPrice * (proportion + 1);
	RETURN incrPrice;

END //

DELIMITER ;


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

-- q5 trigger 생성
-- 1단계 : salary_history 테이블 생성
CREATE TABLE if NOT EXISTS salary_history(
	 history_id INT PRIMARY KEY,
	 emp_id VARCHAR(255),
	 FOREIGN KEY (emp_id)
	 REFERENCES employee(emp_id),
	 subject VARCHAR(255),
	 old_salary DECIMAL(10,2),
	 new_salary DECIMAL(10,2),
	 change_date DATETIME
) ENGINE=INNODB;

DESC salary_history;
-- 2단계 : trg_salary_update 트리거 생성
CREATE TRIGGER trg_salary_upate
	AFTER UPDATE
	ON employee
	FOR EACH ROW
BEGIN
	INSERT salary_history 
	SET new_salary = OLD.old_salary + NEW.old_salary
	WHERE emp_id = NEW.emp_id;

END //
-- 3단계 : employee의 특정 행의 salary 컬럼 수정 시 트리거 동작하는지 확인
