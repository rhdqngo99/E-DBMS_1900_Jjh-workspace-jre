-- part1_trigger.sql
/* 트리거(trigger)
 * 특정 '테이블을 지정'하여 해당 테이블에서 '지정한 DML' 명령어가 동작했을 때,
 * 주어진 조건에 따라 트리거에 정의된 프로시저가 동작을 실행한다.
 * 이때, 프로시저에서 동작하는 내용이 DML 명령어가 실행되기 전 혹은 후에
 * 실행되도록 설정할 수 있다.
 * CREATE OR REPLACE TRIGGER 트리거명
 * BEFORE INSERT ON 테이블명
 * [FOR EACH ROW] -- 행 단위 코드 실행(선택), 기본값은 문장 단위 실행
 * [WHEN 조건식] -- 조건을 만족하는 경우 실행(선택)
 * BEGIN
 * 실행할 프로시저 작성
 * END;
 */
CREATE TABLE TBL_TRIGGER_TEST (
   ID NUMBER PRIMARY KEY,
   NAME VARCHAR2(100) NOT NULL
);
DROP TABLE TBL_TRIGGER_TEST;

CREATE TABLE TBL_TRIGGER_TIME (
   TRIG_FK_ID NUMBER,
   REGISTER_TIME DATE
);
DROP TABLE TBL_TRIGGER_TIME;
ALTER TABLE TBL_TRIGGER_TIME
ADD CONSTRAINT FK_TRIG FOREIGN KEY (TRIG_FK_ID) 
REFERENCES TBL_TRIGGER_TEST(ID);

/* TBL_TRIGGER_TEST에 INSERT를 실행하고 난 뒤
 * TBL_TRIGGER_TIME에 INSERT를 실행하는 트리거 만들기
 */
-- 트리거 만들기
CREATE OR REPLACE TRIGGER REGISTER_TIME
AFTER INSERT ON TBL_TRIGGER_TEST -- TEST 테이블에서 INSERT 실행 후
-- FOR EACH ROW
-- 영향을 받는 각 행마다(1->1) 트리거가 실행된다.
-- 10개의 행이 수정되면 수정된 개수만큼 트리거가 실행
-- 옵션X -> 10개 행 수정 시 1번만 트리거가 실행
FOR EACH ROW
-- WHEN 조건식
DECLARE
BEGIN
   INSERT INTO TBL_TRIGGER_TIME (
   TRIG_FK_ID, REGISTER_TIME)
   VALUES(:NEW.ID, SYSDATE);
--EXCEPTION
--   WHEN OTHERS THEN
--      ROLLBACK;
END;


ALTER TRIGGER REGISTER_TIME ENABLE; -- 트리거 활성화
ALTER TRIGGER REGISTER_TIME DISABLE; -- 비활성화
-- 트리거 타임 테이블의 ID값을 자동으로 증가시키는 시퀀스 생성
CREATE SEQUENCE SEQ_TRG;
DROP SEQUENCE SEQ_TRG;
CREATE SEQUENCE SEQ_TRG_TEST;
DROP SEQUENCE SEQ_TRG_TEST;


-- TEST 테이블에 새로운 데이터 추가
INSERT INTO TBL_TRIGGER_TEST (ID, NAME)
VALUES (SEQ_TRG_TEST.NEXTVAL, '이길동');

SELECT *
FROM TBL_TRIGGER_TEST;

SELECT *
FROM TBL_TRIGGER_TIME;

/* TBL_TRIGGER_TIME 테이블에 새로운 컬럼 UPDATE_TIME 컬럼을 추가
 * TBL_TRIGGER_TEST 테이블에 각 행마다 업데이트가 있을 때마다
 * 해당 되는 TIME 테이블의 행에 UPDATE_TIME 컬럼의 날짜값을 SYSDATE로 갱신
 */
-- 새로운 컬럼 추가. 기본값은 해당 행이 추가될 때의 시각을 자동으로 입력
ALTER TABLE TBL_TRIGGER_TIME ADD (UPDATE_TIME DATE DEFAULT SYSDATE);

CREATE OR REPLACE TRIGGER TRG_UPDATE_TIME
AFTER UPDATE ON TBL_TRIGGER_TEST
FOR EACH ROW -- 각 행마다 UPDATE에 대해서 동작한다.
DECLARE
BEGIN
   UPDATE TBL_TRIGGER_TIME
   SET UPDATE_TIME = SYSDATE
   WHERE :OLD.ID = TRIG_FK_ID;
END;

ALTER TRIGGER UPDATE_TIME ENABLE; -- 트리거 활성화

-- 트리거 실행
-- TEST 테이블의 한 행을 업데이트 한다.
UPDATE TBL_TRIGGER_TEST
SET NAME = '박길동'
WHERE NAME = '이길동';

SELECT *
FROM TBL_TRIGGER_TEST;

SELECT *
FROM TBL_TRIGGER_TIME;

-- 대상 테이블에 등록된 트리거의 이름과 타입, 이벤트 등을
-- 조회할 수 있다.
SELECT TRIGGER_NAME, TRIGGER_TYPE, TRIGGERING_EVENT
FROM user_triggers
WHERE table_name = 'TBL_TRIGGER_TEST';



