-- part2_loop.sql
/* LOOP문
 * 1. 기본 LOOP문
 * 실행할 명령문과 종료 조건만 존재하는 가장 기본적인 형태의 반복문이다.
 * 종료 조건을 만족하기 전까지 무한히 해당 코드 내용을 실행한다.
 * LOOP
 *       실행할 명령문;
 *       EXIT WHEN 종료조건식;
 * END LOOP;
 */

-- 1부터 10까지 출력하는 예제
DECLARE
   -- 반복문 안에서 종료조건에 도달하기 위해 사용하는 변수
   -- 시작값과 끝값을 고려하여 증가시키거나 감소시켜야 한다.
   V_NUM NUMBER := 1; -- 초기식
BEGIN
   LOOP
      -- 실행할 명령문
      DBMS_OUTPUT.PUT_LINE('CURRENT: ' || V_NUM);
      -- V_NUM이 종료 조건식에 도달하기 위해 값을 변화시키는 증감식
      V_NUM := V_NUM + 1; -- 증감식
      -- 반복문을 종료할 조건식
      EXIT WHEN V_NUM > 10; -- 조건식
   END LOOP;
END;

DECLARE
   -- 선언부
   -- 2단부터 9단까지 각각 1부터 9까지의 구구단을 출력
   DAN NUMBER := 2;
   GOP NUMBER := 1;
BEGIN
   LOOP
      DBMS_OUTPUT.PUT_LINE(DAN || '단');
      LOOP
         DBMS_OUTPUT.PUT_LINE(DAN || ' X ' || GOP
         || ' = ' || DAN * GOP);
         GOP := GOP + 1;
         EXIT WHEN GOP > 9;
      END LOOP;
      DAN := DAN + 1; -- 단은 1 증가
      GOP := 1; -- 곱은 1로 초기화
      EXIT WHEN DAN > 9; -- 단이 9를 초과하면 반복문 종료
   END LOOP;
END;

-- 더미 데이터(DUMMY DATA)
-- 테이블이나 테스트 데이터를 확인하기 위해 무작위로 넣는 데이터

DECLARE
   V_NUM NUMBER := 1;
BEGIN
   LOOP
      INSERT INTO TBL_TRIGGER_TEST(ID, NAME)
      VALUES(SEQ_TRG_TEST.NEXTVAL, '제갈길동' || SEQ_TRG_TEST.NEXTVAL);
      V_NUM := V_NUM + 1;
      EXIT WHEN V_NUM > 100;
   END LOOP;
END;

SELECT *
FROM TBL_TRIGGER_TEST ttt ;

-- WHILE LOOP문
/* 기본 LOOP문 과 다르게, WHILE LOOP에 다는 조건식은
 * 반복할 조건을 달아야 한다.
 * 기본 LOOP문은 종료 조건이 만족할 때 종료를 하고
 * 조건없이 해당 코드를 일단 실행
 * 
 * 
 */
DECLARE
	V_NUM NUMBER := 1;
BEGIN
	WHILE C <= 10 LOOP
		DBMS_OUTPUT.PUT_LINE('CURRENT:'||V_NUM);
		V_NUM := V_NUM + 1;
		CASE
			WHEN V_NUM=7 THEN EXIT WHEN V_NUM=7;
	END LOOP;
END;

/* FOR-LOOP문
 * 초기식, 조건식, 증감식을 직접 작성하던 이전의 LOOP문보다
 * 임시 변수(기본값 I)
 * 
 */
DECLARE
BEGIN
	FOR i IN 1..10 LOOP
		DBMS_OUTPUT.PUT_LINE('i1: ' || i);
	END LOOP;
	FOR a IN 1..10 LOOP
		DBMS_OUTPUT.PUT_LINE('a: ' || a);
	END LOOP;
END;









