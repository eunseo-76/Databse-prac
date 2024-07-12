-- 05. limit : select 문의 결과 집합에서 반환할 행의 개수 제한
SELECT
		 menu_code
		, menu_name
		, menu_price
  FROM tbl_menu
 ORDER BY menu_price DESC;
 
SELECT
		 menu_code
		, menu_name
		, menu_price
  FROM tbl_menu
 ORDER BY menu_price DESC
 -- [offset]: 시작할 행의 번호(인덱스) = 얼만큼 건너뛸 것인가? (인덱스는 0부터 넘버링)
 -- row_count : 이후 행부터 반환할 개수
 LIMIT 1, 4;
 -- 정렬한 순서에서 1개를 건너뛰고, 2번째 값부터 4개를 가져오겠다(2~5)

SELECT
		 menu_code
		, menu_name
		, menu_price
  FROM tbl_menu
 ORDER BY menu_price DESC
 LIMIT 5; -- top-n개의 행을 가져옴. offset 없이.