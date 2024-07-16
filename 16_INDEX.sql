-- 16. index : 데이터 검색 속도 향상을 위해 사용

CREATE TABLE phone(
	phone_code INT PRIMARY KEY,
	phone_name VARCHAR(100),
	phone_price DECIMAL(10, 2)
);

INSERT
  INTO phone
VALUES
(1, 'galaxyS23', 1200000),
(2, 'iPhone14pro', 1430000),
(3, 'galaxyZfold3', 1730000);

explain SELECT * FROM phone WHERE phone_name = 'galaxyS23';

-- phone_name 컬럼에 인덱스 생성
CREATE INDEX idx_name ON phone (phone_name);

-- 인덱스 생성 후 실행 계획이 인덱스 사용으로 변경 됨
EXPLAIN SELECT * FROM phone WHERE phone_name = galaxyS23;

-- 복합 인덱스 생성
CREATE INDEX idx_name_price ON phone(phone_name, phone_price);

-- 인덱스 조회
SHOW INDEX FROM phone;

-- 인덱스 최적화 (재구성)
-- 인덱스 안에 들어가는 값의 변화가 많은 경우, 인덱스를 다시 재구성할 필요가 있음.
ALTER TABLE phone DROP INDEX idx_name;
ALTER TABLE phone ADD INDEX idx_name(phone);
OPTIMIZE TABLE phone; -- InnoDB만 가능
-- 운영 중인 서비스에서 이런 식으로 alter, optimize 하면 문제가 생기고 막힐 수 있기 떄문에
-- 막 실행하면 안 된다!
-- pk 처럼 한 번 값이 부여되면 잘 변하지 않는 것을 인덱스를 만드는 게 좋음