-- 18. trigger

-- tbl_menu, tbl_oder, tbl_order_menun 테이블
-- tbl_oder : 1 20240717 11:08:30 total_price
-- tbl_oder_menu : 1(tbl_oder의 oder_code) 1(tbl_menu의 menu_code) 2(개수)

-- tbl_oder_menu에 데이터가 삽입될 때 tbl_oder에 total_price를 입력하도록 함

-- trigger 생성
DELIMITER //

CREATE TRIGGER after_order_menu_insert
	AFTER INSERT -- 이벤트 발생 전, 후 선택
	ON tbl_order_menu -- tbl_oder_menu에 insert 상황이 발생한 후에 trigger 동작
	FOR EACH ROW -- 여러 행이 insert 되면 각 행을 모두 대상으로 trigger 동작
BEGIN
	UPDATE tbl_order -- tbl_oder_menu에 insert가 되면 tbl_oder를 update
	SET total_order_price = total_order_price + NEW.order_amount * (SELECT -- new : insert에서 가지고 있는 값
																								  menu_price
																							  FROM tbl_menu
																							 WHERE menu_code = NEW.menu_code)
	WHERE order_code = NEW.order_code;

END //

DELIMITER ;

-- insert 테스트
-- 이거 insert할 떄는 trigger 동작 x
INSERT
  INTO tbl_order
VALUES
(
  NULL
, DATE_FORMAT(CURRENT_DATE, '%Y%m%d') -- 현재 날짜와 시간을 숫자 8개로 표기되게 함
, DATE_FORMAT(CURRENT_TIME, '%H%i%s') -- %Y-%m-%d 이런 식으로 해도 됨(8개로 맞춰놔서 실행은x...)
, 0
);

INSERT
  INTO tbl_order_menu
(
  order_code
, menu_code
, order_amount
)
VALUES( -- 1번 주문 건은 4번 메뉴를 3개 구매한 주문이다
  1
, 4
, 3
);