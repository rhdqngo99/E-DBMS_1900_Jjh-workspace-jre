-- 논리 연산자
-- AND
-- 그리고와 같은 의미를 가진 연산자로
-- 피연산자인 논리값이 모두 참일 경우, 그 결과로
-- 참이 나오는 연산자다.
-- 하나라도 거짓이라면 그 결과를 거짓이 나온다.
SELECT FIRST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
-- SALARY이 10000이상이고,
-- DEPARTMENT_ID가 90이상인 경우
WHERE SALARY >= 10000 AND DEPARTMENT_ID >= 90;

SELECT PLAYER_NAME, HEIGHT, WEIGHT
FROM PLAYER
--ORDER BY HEIGHT, WEIGHT
-- HEIGHT가 180이상이면서
-- WEIGHT가 75이상인 경우
WHERE HEIGHT >= 180 AND WEIGHT >= 75;

-- PLAYER 테이블에서
-- PLAYER_NAME, HEIGHT, WEIGHT를 조회
-- 조건: 키와 몸무게의 합이 250 이상이거나
-- 키가 185 초과인 경우
SELECT PLAYER_NAME, HEIGHT, WEIGHT
FROM PLAYER
WHERE ((HEIGHT + WEIGHT) >= 250) OR (HEIGHT > 185);

SELECT *
FROM PLAYER;
-- NULL값 여부 검사 연산자
-- IS NULL
SELECT PLAYER_NAME, NICKNAME
FROM PLAYER
--WHERE NICKNAME IS NULL; -- NULL인 경우
WHERE NICKNAME IS NOT NULL;
--AND NICKNAME LIKE '터프가이'; -- NULL이 아닌 경우














