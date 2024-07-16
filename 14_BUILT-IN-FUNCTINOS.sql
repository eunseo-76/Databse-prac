-- 14. built in functions(내장 함수)

-- (1) 문자열 관련 함수
-- ASCII(아스키코드), CHAR(숫자)
SELECT ASCII('A'), CHAR(65);

SELECT BIT_LENGTH('pie'), CHAR_LENGTH('pie'), LENGTH('pie');

-- bit : bit 수, char : 문자 수, length : byte 수
SELECT BIT_LENGTH('pie'), CHAR_LENGTH('pie'), LENGTH('pie');

SELECT menu_name, BIT_LENGTH(menu_name),
CHAR_LENGTH(menu_name), LENGTH(menu_name) FROM tbl_menu;
-- 한 글자 당 3byte

-- concat(문자열1, 문자열2, ...)
-- concat_ws(구분자, 문자열1, 문자열2, ...)
SELECT CONCAT('호랑이', '기린', '토끼');
select CONCAT_WS(',', '호랑이', '기린', '토끼');

SELECT
		 -- 첫 번째 인자인 숫자의  위치의 문자열 반환
		 ELT(2, '사과', '딸기', '바나나')
		 -- 첫 번째 인자 문자열의 위치 숫자 반환
	  , FIELD('딸기', '사과', '딸기', '바나나')
	    -- 첫 번째 인자 문자열의 셋 내부의 위치 숫자 반환
	  , FIND_IN_SET('바나나', '사과,딸,바나나')
	    -- 두 번째 인자 문자열이 첫 번째 인자 문자열 내부에서의 시작 위치
	  , INSTR('사과딸기바나나', '딸기')
	    -- instr과 인자 순서 반대로
	  , LOCATE('딸기','사과딸기바나나');
	  
-- format(숫자, 소수점 자리수) - 반올림 함
SELECT FORMAT(123123123123123.567567, 3);

-- bin: 2진수, oct: 8진수, hex: 16진수
SELECT BIN(65), OCT(65), HEX(65);

-- insert(기준문자열, 위치, 길이, 삽입할 문자열)
SELECT INSERT('내 이름은 아무개입니다.', 7, 3, '홍길동');

-- left, right
SELECT LEFT('Hello World!', 3), RIGHT('Hello World', 3);

-- upper, lower
SELECT UPPER('Hello World!'), LOWER('Hello World!');

-- lpad, rpad
SELECT LPAD('왼쪽', 6, '@'), RPAD('오른쪽', 6, '@');
-- 모자란 만큼을 세 번째 인자로 채우겠다

-- ltrim, rtrim
SELECT LTRIM('     왼쪽'), RTRIM('오른쪽     ');

-- trim
-- both, ledding, trailing으로 방향 설정 가능
SELECT TRIM('      mariadb       '), TRIM(BOTH '@' FROM '@@@@mariadb@@@@');

-- repeat
SELECT repeat('재밌어', 3);

-- replace
-- 기준값, 해당하는 문자, 교체할 문자
SELECT REPLACE('마리아db', '마리아', 'maria');

-- reverse
SELECT REVERSE('stressed');

-- space(길이): 길이만큼의 공백 반환
SELECT CONCAT('제 이름은', SPACE(5), '이고 나이는', SPACE(3),  '세 입니다');

-- substring
-- 대상 문자열, 자를 위치, 자를 길이
-- 길이 생략 시 문자열을 끝까지 반환
SELECT SUBSTRING('안녕하세요 반갑습니다.', 7, 2),
 		 SUBSTRING('안녕하세요 반갑습니다.', 7);
 		 
-- substring_index(문자열, 구분자, 횟수)
-- 찾아낸 위치에서 이후의 내용을 버림

-- '-' 붙이면 오른쪽에서 왼쪽으로 탐색(기본은 왼쪽에서 오른쪽)
-- 오른쪽에서 2번째 '.'에서부터 왼쪽을 전부 버림
SELECT
		 SUBSTRING_INDEX('hong.test@gmail.com', '.', 2)
	  , SUBSTRING_INDEX('hong.test@gmail.com', '.', -2);

-- (2) 숫자 관련 함수

-- abs: 절대값 반환 absolute vale : 절대값
SELECT ABS(-123);

-- ceiling, floor, round
-- ceiling : 올림 처리
-- floor: 내림 처리
-- round : 반올림 처리
SELECT CEILING(1234.56), FLOOR(1234.56), ROUND(1234.56);

-- conv (convert) : 진법 변환
-- (숫자, 원래 진수, 변환 진수)
SELECT CONV('A', 16, 10), CONV('A', 16, 2), CONV(1010, 2,  8);

-- mod : 나눗셈의 나머지 반환
SELECT MOD(75, 10), 75%10, 75 MOD 10;

-- pow : 거듭제곱 값, sqrt : 제곱근 반환
SELECT POW(2, 4), SQRT(16);

-- rand : 0 이상 1 미만의 임의의 실수를 반환 (random)
SELECT RAND();
-- m <= 임의의 정수 < n 을 구하고 싶다면
-- SELECT FLOOT(RAND() * (n - m) + m
SELECT FLOOR(RAND()*(11 - 1) + 1);

-- sign
-- 양수면 1 반환, 음수면 -1 반환, 0이면 0  반환
SELECT SIGN(10.1), SIGN(0), SIGN(-10.1);

-- n - m: 내가 원하는 값의 개수 만큼 곱하기
-- 원하는 범위에서는 1 떨어져 있기 때문에 + 1
-- 그 결과는 소수값이기 때문에 floor로 소수점을 떼어 줌

-- truncate : 소수점 자리 수 이후는 잘라내기
-- (대상 숫자, 소수점 자리 수)
SELECT TRUNCATE(12345.12345, 2), TRUNCATE(12345.12345, -2);
-- '-' 붙인 경우 소수점 12345.12345 에서 왼쪽으로 2만큼 이동하여 잘라낸 것
-- 12345.12345 > 123xx.xxxxx > 12300

-- (3) 날짜/시간 관련 함수

-- adddate, subdate
-- 기준 날짜 더하기, 빼기
SELECT
ADDDATE('2023-05-31', INTERVAL 30 DAY),
ADDDATE('2023-05-31', INTERVAL 6 MONTH),
SUBDATE('2023-05-31', INTERVAL 30 DAY),
SUBDATE('2023-05-31', INTERVAL 6 MONTH);

-- addtime, subtime
-- 
SELECT
		 ADDTIME('2023-05-31 09:00:00', '1:0:1')
	  , SUBTIME('2023-05-31 09:00:00', '1:0:1');
	  

-- 현재의 시스템 날짜/시간 반환
SELECT CURDATE(), CURRENT_DATE(), CURRENT_DATE;
SELECT CURTIME(), CURRENT_TIME(), CURRENT_TIME;
SELECT NOW(), LOCALTIME, LOCALTIME(), LOCALTIMESTAMP, LOCALTIMESTAMP();

-- year, month, dayofmonth
SELECT YEAR(CURDATE()), MONTH(CURDATE()), DAYOFMONTH(CURDATE());

-- hour, minute, second, microsecond
-- microsecond 사용법 잘못 된 듯.. 다시 알려준다고 하심
SELECT HOUR(CURTIME()), MINUTE(CURTIME()), SECOND(CURTIME()), MICROSECOND(CURTIME(6));
-- curtime은 인자가 없으면 시분초로 초 단위까지만 반환함
-- ms 단위까지 원한다면 인자를 써야함


-- date, time
-- now는 연월일시분초 다 가지는 데이터임
SELECT DATE(NOW()), TIME(NOW());

-- DATEDIFF, TIMEDIFF
SELECT
		 DATEDIFF('2023-05-31', '2023-02-27') -- 앞 날짜 - 뒷  날짜
	  , TIMEDIFF('17:07:11', '13:06:10'); -- 앞 시간 - 뒷 시간
	
SELECT
		 DAYOFWEEK(CURDATE()), MONTHNAME(CURDATE()), DAYOFYEAR(CURDATE());
		 
SELECT LAST_DAY('2023-02-01');

-- makedate, maketime
-- makedate(년도, 년도에 며칠이 지난 시점으로 할 것이냐)
-- maketime(시, 분, 초)
SELECT MAKEDATE(2023, 32), MAKETIME(17, 03, 02);

-- quarter (분기)
SELECT QUARTER('2023-05-01');

-- time_to_sec
SELECT TIME_TO_SEC('1:1:1');