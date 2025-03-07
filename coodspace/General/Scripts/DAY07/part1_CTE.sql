-- part1_CTE.sql
-- CTE(Common Table Expressions)
/* 서브쿼리를 상단에서 미리 이름을 부여하고 정의하여
 * 그 아래쪽에서 이름만으로 쉽게 사용할 수 있도록 하는 것.
 * - 메인 SQL과 서브쿼리를 분리함으로써 가독성 향상
 * - 같은 이름만으로 서브쿼리를 반복적을 사용하는 것으로 재사용성 증가 -> 생산성 증가
 * 사용 방법
 * WITH [재귀옵션] 임시테이블명 [(컬럼명1, 컬럼명2,...)] AS (서브쿼리)
 * SELECT * FROM 임시테이블명
 * 
 * CTE 다중 중첩
 * - 이러한 CTE는 상단에 여러 개를 정의해놓을 수 있으며
 * 	 각 CTE는 반점,으로 구분되어 WITH 구문 아래에서 여러 개 선언될 수 있다.
 * */
WITH AVG_SAL_GR_BY_DP AS (
	SELECT DEPARTMENT_ID, FLOOR(AVG(SALARY)) AS "AVG_SAL"
	FROM EMPLOYEES
	GROUP BY DEPARTMENT_ID
),
	D1700 AS ( 
	SELECT DEPARTMENT_ID , DEPARTMENT_NAME
	FROM DEPARTMENTS
	WHERE LOCATION_ID = 1700
),
	MAX_DP AS (
	SELECT DEPARTMENT_ID
	FROM AVG_SAL_GR_BY_DP
	WHERE AVG_SAL = (SELECT MAX(AVG_SAL) FROM AVG_SAL_GR_BY_DP)
)
SELECT M.DEPARTMENT_ID , D.DEPARTMENT_NAME AS "최대 평균급여부서"
FROM MAX_DP M
JOIN DEPARTMENTS D
ON M.DEPARTMENT_ID = D.DEPARTMENT_ID;

-- 실습 문제
/* 1. EMPLOYEES와 DEPARTMENTS 테이블을 사용하여
 * 각 부서별로 가장 높은 급여를 받는 직원의 목록을 CTE를 사용하여 조회하세요.
 * */
WITH MAX_SALARY_PER_DEPT AS (
	SELECT DEPARTMENT_ID, MAX(SALARY) MAX_SALARY
	FROM EMPLOYEES
	GROUP BY DEPARTMENT_ID
)
SELECT E.DEPARTMENT_ID 
--	, D.DEPARTMENT_NAME
	, E.FIRST_NAME, E.LAST_NAME, E.SALARY 
FROM EMPLOYEES E
JOIN MAX_SALARY_PER_DEPT M
	ON E.DEPARTMENT_ID = M.DEPARTMENT_ID
	AND E.SALARY = M.MAX_SALARY
--JOIN DEPARTMENTS D
--	ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY SALARY DESC, DEPARTMENT_ID;








