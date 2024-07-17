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
	   g.subject
	  , s.NAME
	  , s.class
	  , g.grade
  FROM students s
  JOIN grades g ON s.student_id = g.student_id
 ORDER BY g.subject ASC;

-- 4단계 : select * from view
SELECT * FROM student_grades;

-- 답안
-- students 테이블 생성
CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    class VARCHAR(50)
);

-- grades 테이블 생성
CREATE TABLE grades (
	 grade_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    subject VARCHAR(50),
    grade CHAR(1),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

-- 데이터 삽입
INSERT INTO students (name, class) VALUES 
('홍길동', 'A'),
('신사임당', 'B'),
('유관순', 'A');

INSERT INTO grades (student_id, subject, grade) VALUES 
(1, '수학', 'A'),
(1, '과학', 'B'),
(2, '수학', 'C'),
(2, '과학', 'B'),
(3, '수학', 'B'),
(3, '과학', 'A');

-- 뷰 생성
CREATE OR REPLACE VIEW student_grades AS
SELECT 
       g.subject
	  , s.name
	  , s.class
	  , g.grade
  FROM students s
  JOIN grades g ON s.student_id = g.student_id
 ORDER BY g.subject;

-- 뷰 조회
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

-- 답안
-- 인덱스 생성
CREATE INDEX idx_dept ON employee(dept_code);
-- 인덱스 조회
SHOW INDEX FROM employee;
-- 인덱스 삭제
DROP INDEX idx_dept ON employee;
ALTER TABLE employee DROP INDEX idx_dept;

-- q3 stored procedure 생성

DELIMITER // 

CREATE PROCEDURE addNumbers(
	IN num1 INT,
	IN num2 INT,
	OUT numSum INT
)
BEGIN
	SET numSum = num1 + num2;
END //

DELIMITER ;

-- 프로시저 호출
SET @SUM = 0;
CALL addNumbers(10, 20, @SUM);
SELECT @SUM;

-- 답안
DELIMITER //

CREATE PROCEDURE addNumbers(
	IN num1 INT, 
	IN num2 INT, 
	OUT sum INT
)
BEGIN
    SET sum = num1 + num2;
END//

DELIMITER ;


-- q4 stored function 생성
-- 현재 가격은 하나만 입력하는 건데 어떻게 모든 메뉴의 현재 가격을 출력하지??
DELIMITER //

CREATE FUNCTION increasePrice(
	currPrice DOUBLE, -- 현재 가격
	proportion DOUBLE --  비율
)
RETURNS DOUBLE -- 인상 예정가: 십의 자리까지 버림
DETERMINISTIC -- functon 호출 시 항상 동일한 값을 반환하는지
BEGIN
	RETURN currPrice * (1 + proportion);
END //

DELIMITER ;

-- function 확인
SELECT
	  menu_name 메뉴명
   , menu_price 기존가
	, truncate(increasePrice(menu_price, 0.1), -2) 예정가
  FROM tbl_menu;


-- 답안
DELIMITER //

CREATE FUNCTION increasePrice(
	current_price DOUBLE, 
	increase_rate DOUBLE
)
RETURNS DOUBLE
DETERMINISTIC
BEGIN
    RETURN current_price * (1 + increase_rate);
END//

DELIMITER ;

SELECT 
       menu_name 메뉴명
	  ,  menu_price 기존가
	  , TRUNCATE(increasePrice(menu_price, 0.1), -2) 예정가
 FROM tbl_menu;

-- q5 trigger 생성
-- 1단계 : salary_history 테이블 생성
CREATE TABLE if NOT EXISTS salary_history(
	 history_id INT PRIMARY KEY AUTO_INCREMENT,
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

CREATE TRIGGER trg_salary_update
	AFTER UPDATE
	ON employee
	FOR EACH ROW
BEGIN
	if OLD.salary <> NEW.salary then
		INSERT
			INTO salary_history(emp_id
									, old_salary
									, new_salary
									, change_date)
		 VALUES (OLD.emp_id
		 		 , OLD.salary
				 , NEW.salary
				 , NOW());
	END if;
END //

DELIMITER ;
-- 3단계 : employee의 특정 행의 salary 컬럼 수정 시 트리거 동작하는지 확인
UPDATE
		  employee
	SET salary = 5000000
 WHERE emp_id = '202';
SELECT * FROM salary_history;


-- 답안
CREATE TABLE salary_history (
	  history_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id VARCHAR(3),
    old_salary DECIMAL(10, 2),
    new_salary DECIMAL(10, 2),
    change_date DATETIME,
    FOREIGN KEY (emp_id) REFERENCES employee(emp_id)
);

DELIMITER //

CREATE TRIGGER trg_salary_update
BEFORE UPDATE ON employee -- after도 상관없음
FOR EACH ROW
BEGIN
	  IF OLD.salary <> NEW.salary THEN
	    INSERT INTO salary_history(emp_id, old_salary, new_salary, change_date)
	    VALUES (OLD.emp_id, OLD.salary, NEW.salary, NOW());
    END IF;
END //

DELIMITER ; 
