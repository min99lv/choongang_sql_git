create table sampleTBL(
    memo varchar2(50)
);

-- 테이블 스페이스 권한이 없어서 불가능
-- "no privileges on tablespace '%s'"

-- X 
-- 테이블 스페이스 권한이 없다 불가능
select * from scott.emp;

-- ok
-- 스캇이 셀레트 권한을 줌
select * from scott.emp;

-- 그랜트 성공함 with grant option 권한부여 재할당 가능
grant select on scott.emp to usertest04 with grant option;



-- OK 스캇에서 권한부여
select * from scott.stud_101;


-- 스캇에서 권한부여를 받았을 때 with grant option을 해주지 않았기 때문에 권한 부여 불가능
-- 권한 불충분
-- 오류 ORA-01031: insufficient privileges
-- .현SELECT 권한 부여 개발자 권한 부여 , WITH GRANT OPTION  --> 니가 해라 권한 부여
grant select on scott.stud_101 to usertest04;
GRANT SELECT on scott.stud_101 TO usertest02;

-- .현SELECT 권한 부여 개발자 권한 부여 , WITH GRANT OPTION  --> 니가 해라 권한 부여
select * from scott.job3;
grant select on scott.job3 to usertest04 with grant option;

--   X 권한 회수 상태
select * from scott.job3;