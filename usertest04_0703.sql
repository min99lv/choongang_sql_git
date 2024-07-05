04

-- 테이블 생성
create table sampleTBL4(
    memo varchar2(50)
);
-- 행 추가
insert into sampletbl4 values ('7월 더움4');
insert into sampletbl4 values  ('결실 맺으리라4');


select * from sampletbl4;
-- XXXXX 권한을 회수하고 resource와 커넥트 권한만 주어졌기때문에 불가능 
select * from scott.emp;

-- select
-- Ok  -> scott가 권한을 할당
-- 스캇(오너쉽)이 student 리드 권한을 주니까 보기 가능 
select * from scott.student;

-- update
-- x -> insufficient privileges -> 조회 조건만 스캇이 주었기때문에 업데이트 불가능
update scott.student
set name = '김춘추'
where studno = '30102';

-- usertest02 에서 권한을 부여해주어서 가능함
select * from scott.emp;

-- 할당
grant select on scott.emp to usertest03; 


-- 권한 회수 emp  usertest03의 권한을 회수함
revoke select on scott.emp from usertest03; --> 성공


-- .현SELECT 권한 부여 개발자 권한 부여 , WITH GRANT OPTION  --> 니가 해라 권한 부여
select * from scott.job3;
grant select on scott.job3 to usertest03;


-------------------------
-- system -> usertest04 (systemtbl)
SELECT * FROM system.systemtbl;

-- 공용동의어를 얻어서 좀 편하게 사용 가능
SELECT * FROM pub_system;
-- 현장용 시스템 공용동의어
SELECT * FROM systemtbl;

-- scott에서 만든 전용동의어 만들었지만 스캇만 사용가능 -> 전용동의어라서 !!!!! 
select * from privateTBL;


---------------시스템에서 다른사용자 -> 동의어 권한을 줌
create SYNONYM privateTBL for SYSTEM.privatetbl;
-- 전용 동의어 사용 됨.... 
select * from privateTbL;