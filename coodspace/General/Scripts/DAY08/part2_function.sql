-- part2_function.sql
-- 사용자 정의 함수(FUNCTION)
/* 프로시저와 비슷하지만, 실행부에서 작성할 수 있는 코드는 PL/SQL뿐이다.(C, JAVA,...)
 * - 반드시 하나의 값을 반환해야 하며, 이것을 나타내는 예약어가 RETURN이다.
 * - DML문장(INSERT, UPDATE, DELETE)은 사용할 수 없음
 * - TCL(트랜젝션 제어 명령어)를 사용할 수 없음
 * - 함수 내에서 다른 함수 호출(사용) 가능
 * 
 * CREATE OR REPLACE FUNCTION 함수명
 * (매개변수1 IN 타입,
 * 매개변수2 IN 타입,...)
 * RETURN 반환값의타입
 * IS
 * 	-- 주로 반환할 값을 담을 변수를 선언
 * 	V_RETURN NUMBER;
 * BEGIN
 * 		-- 기타 연산
 * 		V_RETURN := 전달받은변수를 활용한 계산식(표현식);
 * 		-- 기타 연산
 * 		RETURN V_RETURN;
 * EXCEPTION
 * END;
 */

-- 전달받은 SALARY 값을 이용하여 연봉(12)을 계산하는 함수 작성
CREATE OR REPLACE FUNCTION ANNUAL_SAL
(P_SAL IN NUMBER,
P_COMMISSION IN NUMBER --,
--V_ANNUAL_SAL OUT NUMBER -- 반환할 값을 담을 변수
)
--RETURN V_ANNUAL_SAL NUMBER -- ERROR
RETURN NUMBER
IS
BEGIN
--	V_ANNUAL_SAL := (P_SAL * 12) + (P_SAL * NVL(P_COMMISSION, 0));
--	RETURN V_ANNUAL_SAL;
	RETURN (P_SAL * 12) + (P_SAL * NVL(P_COMMISSION, 0));
END;

-- 함수의 사용
SELECT FIRST_NAME, ANNUAL_SAL(SALARY, COMMISSION_PCT) AS ANNUAL_SALARY
FROM EMPLOYEES;	


SELECT BIRTH_DATE
FROM PLAYER
WHERE JOIN_YYYY IS NULL;
-- 같이 실습
-- PLAYER 테이블에서 JOIN_YYYY와 BIRTH_DATE의 'YYYY'를 비교하여
-- 그 차이를 반환하는 함수를 작성해보자.
CREATE OR REPLACE FUNCTION CALC_DIFF
(P_JOIN VARCHAR2,
P_DATE DATE)
RETURN NUMBER
IS
BEGIN
	RETURN TO_NUMBER(NVL(P_JOIN, 2010)) - TO_NUMBER(TO_CHAR(NVL(P_DATE, TO_DATE('1990-01-01', 'YYYY-MM-DD')), 'YYYY'));
END;

SELECT JOIN_YYYY, BIRTH_DATE, CALC_DIFF(JOIN_YYYY, BIRTH_DATE) AS DATE_DIFF
FROM PLAYER
WHERE JOIN_YYYY IS NOT NULL AND BIRTH_DATE IS NOT NULL;


-- 실습 심화
-- 외부에서 전달받는 매개변수를 두 개 더 선언하여
-- 만약 전달받은 P_JOIN과 P_DATE가 각각 NULL인 경우,
-- 대신할 값을 새로운 매개변수를 통해 설정하도록 개조해보자.
CREATE OR REPLACE FUNCTION CALC_DIFF_CUSTOM
(P_JOIN VARCHAR2,
P_DATE DATE,
P_DEFAULT_JOIN NUMBER,
P_DEFAULT_YYYY NUMBER
) -- 변수 두 개 더 추가하기
RETURN NUMBER
IS
BEGIN
	-- 2010 값과 '1990' 대신에 전달받은 새로운 변수이름을 사용한다.
	RETURN TO_NUMBER(NVL(P_JOIN, P_DEFAULT_JOIN)) 
	- TO_NUMBER(TO_CHAR(NVL(P_DATE, 
	TO_DATE(TO_CHAR(P_DEFAULT_YYYY) || '-01-01', 'YYYY-MM-DD')), 'YYYY'));
END;

-- 전달되는 값이 문자형이더라도 그 내용이 숫자로만 이루어져 있다면
-- 내부의 매개변수가 숫자형이라면, 숫자로 형변환하여 사용된다.
SELECT JOIN_YYYY, BIRTH_DATE
, CALC_DIFF_CUSTOM(JOIN_YYYY, BIRTH_DATE, '2010', '1990') AS DATE_DIFF
FROM PLAYER
WHERE JOIN_YYYY IS NOT NULL AND BIRTH_DATE IS NOT NULL;



