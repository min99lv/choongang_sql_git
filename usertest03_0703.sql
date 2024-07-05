-- 테이블 생성
create table sampleTBL(
    memo varchar2(50)
);
-- 행 추가
insert into sampletbl values ('7월 더움');
insert into sampletbl values  ('결실 맺으리라');

COMMIT;

select * from sampleTbl;


-- X
-- 권한이 없다
select * from scott.emp;
zzzzzzzzzzdndhk~~~~~~WGFEJ

-- x --> ok (usertest04가 권한 할당)
-- usertest04에서 권한을 부여해줘서 조회 권한이 생김
select * from scott.emp;

-- ok --> x (usertest04가 권한을 회수)
select * from scott.emp;

---------------------------------------------------------------
-- X
select * from scott.job3;
-- X --> ok (usertest04가 권한 할당)
select * from scott.job3;
grant select on scott.job3 to usertest03;

-- scott 에서 권한 회수
select * from scott.job3;
