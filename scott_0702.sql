-----------------------------------------------------------------------------------------
--   11. View 
------------------------------------------------------------------------------
-- View : 하나 이상의 기본 테이블이나 다른 뷰를 이용하여 생성되는 가상 테이블
--        뷰는 데이터딕셔너리 테이블에 뷰에 대한 정의만 저장
--       장점 :   1)보안 
                    2) 고급기술자가 초급기술자의 sql능력을 커버해줌
--       단점 :   Performance(성능)은 더 저하

-- 뷰 생성
CREATE or REPLACE view view_professor 
AS
SELECT profno, name, userid, position, hiredate, deptno -- 가져오고싶은 컬럼(급여정보 제외)
FROM professor; 

-- 조회하는 순간 professor가 받아서 전체적으로 실행 --> 두번 이동하기때문에 성능저하
SELECT * FROM view_professor;

-- 뷰에서 데이터 추가
-- 뷰에 입력된 값이 professor테이블에도 입력이 된다 --> 넣지 않은 값은 null로 들어감
--제약조건에 걸리지 않는다면 뷰를 통한 입력 가능
INSERT INTO view_professor VALUES(2000,'view','userid','position',sysdate,101);

--name에 제약조건 not null이 있는데 name을 입력하지 않아서 에러!
-- ORA-01400: cannot insert NULL into ("SCOTT"."PROFESSOR"."NAME")
insert into view_professor (profno,userid, position, hiredate, deptno)
        values(2001,'userid2','position2',sysdate,101);
        
-- 현장work01 --> VIEW 이름 v_emp_sample  : emp(empno , ename , job, mgr,deptno)
create or replace view v_emp_samle
as
select empno, ename, job, mgr, deptno
from emp;
-- 제약조건 pk: empno  fk : deptno
insert into v_emp_samle (empno, ename, job, mgr, deptno)
        values(2001,'userid2','position2',7839,10);
        
-- 현장 work02 --> 복합 view / 통계 뷰  v_emp_complex(emp, dept)
-- join을 사용하여 만든다
create or replace view v_emp_complex
as 
select *
from emp natural join dept;
-- 오라클 조인 --> 복합키가 입력이 된다
create or replace view v_emp_complex3
as 
select e.empno, e.ename, e.job, e.deptno, d.dname, d.loc
from emp e,dept d
where e.deptno = d.deptno 
;
-- 복합 뷰 데이터 추가 --> 기본적으로 불가능
-- 제약조건 확인 pk empno, deptno 
-- 오류 메세지 : cannot modify more than one base table through a join view
insert into v_emp_complex (empno, ename,deptno)
    values(1500,'홍길동',20);
-- 넣어야하는 컬럼을 다 넣고 데이터추가는 기본적으로 불가능하다
-- 오류 메세지 : cannot modify more than one base table through a join view
insert into  v_emp_complex (empno, ename, deptno, dname, loc)
    values(1500,'홍길동',77,'공무팀','낙성대');

-- orcle join insert OK
insert into v_emp_complex3 (empno, ename)
    values(1501,'홍길동1');
insert into v_emp_complex3 (empno, ename,deptno)
    values(1502,'홍길동3',20);
insert into v_emp_complex3 (empno, ename, deptno, dname, loc)
    values(1503,'홍길동4',77,'공무팀','낙성대');
    
create or replace view v_emp_complex4
as 
select  d.deptno, d.dname, d.loc, e.empno, e.ename, e.job
from dept d,emp e
where d.deptno = e.deptno 
;
insert into v_emp_complex4 (empno, ename)
    values(1600,'홍길동1');
-- 오류
insert into v_emp_complex4 (empno, ename,deptno)
    values(1601,'홍길동3',20);
insert into v_emp_complex4 (empno, ename, deptno, dname, loc)
    values(1603,'홍길동4',77,'공무팀','낙성대');
insert into v_emp_complex4 (deptno, ename,deptno)
    values(78,'공무팀','낙성대');
    
-- natural join --> 어떤 테이블에 포함되어있는 컬럼인지 명확하지 않아서 오류 
-- oracle join --> 중복되는 컬럼을 제외하고 가능

------------     View  HomeWork     ----------------------------------------------------

---문1)  학생 테이블에서 101번 학과 학생들의 학번, 이름, 학과 번호로 정의되는 단순 뷰를 생성
---     뷰 명 :  v_stud_dept101
create or replace view v_stud_dept101
as select studno, name, deptno
from student
where deptno = 101;
--문2) 학생 테이블과 부서 테이블을 조인하여 102번 학과 학생들의 학번, 이름, 학년, 학과 이름으로 정의되는 복합 뷰를 생성
--      뷰 명 :   v_stud_dept102
create or replace view v_stud_dept101
as select s.studno, s.name, d.deptno
from student s, department d
where s.deptno = d.deptno 
and d.deptno = 102;
--문3)  교수 테이블에서 학과별 평균 급여와     총계로 정의되는 뷰를 생성
--  뷰 명 :  v_prof_avg_sal       Column 명 :   avg_sal      sum_sal
create or replace view v_prof_avg_sal
as 
select deptno, avg(sal) avg_sal, sum(sal) sum_sal
from professor
group by deptno;

-- 2. group 함수 column 등록 안됨
insert into v_prof_avg_sal
values(203,,600,300);

-- view 삭제
drop view v_stud_dept102;

select view_name, text
from user_views;
---------------------------------------------------------------------------------------------------
---- 계층적 질의문
---------------------------------------------------------------------------------------------------
-- 1. 관계형 데이터 베이스 모델은 평면적인 2차원 테이블 구조
-- 2. 관계형 데이터 베이스에서 데이터간의 부모 관계를 표현할 수 있는 칼럼을 지정하여 
--    계층적인 관계를 표현
-- 3. 하나의 테이블에서 계층적인 구조를 표현하는 관계를 순환관계(recursive relationship)
-- 4. 계층적인 데이터를 저장한 칼럼으로부터 데이터를 검색하여 계층적으로 출력 기능 제공

-- 사용법
-- SELECT 명령문에서 START WITH와 CONNECT BY 절을 이용
-- 계층적 질의문에서는 계층적인 출력 형식과 시작 위치 제어
-- 출력 형식은  top-down 또는 bottom-up
-- 참고) CONNECT BY PRIOR 및 START WITH절은 ANSI SQL 표준이 아님


-- top - down 형식
-- 문1) 계층적 질의문을 사용하여 부서 테이블에서 학과,학부,단과대학을 검색하여 단대,학부
-- 학과순으로 top-down 형식의 계층 구조로 출력하여라. 단, 시작 데이터는 10번 부서
select level,deptno, dname, college
from department
start with deptno = 10 -- 시작부 얘 부터 보여줌
connect by prior deptno = college; -- 자식부터 내세움

-- bottom - up 형식
-- 문2)계층적 질의문을 사용하여 부서 테이블에서 학과,학부,단과대학을 검색하여 학과,학부
-- 단대 순으로 bottom-up 형식의 계층 구조로 출력하여라. 단, 시작 데이터는 102번 부서이다
select deptno, dname, college
from department
start with deptno = 102 -- 시작부 얘 부터 보여줌
connect by prior college = deptno ; -- 부모부터 내세움

--- 문3) 계층적 질의문을 사용하여 부서 테이블에서 부서 이름을 검색하여 단대, 학부, 학과순의
---         top-down 형식으로 출력하여라. 단, 시작 데이터는 ‘공과대학’이고,
---        각 LEVEL(레벨)별로 우측으로 2칸 이동하여 출력
select  lpad(' ',(level-1)*2) || dname  as 조직도
from department
start with deptno = 10
connect by prior deptno = college;


------------------------------------------------------
---      TableSpace  
---  정의  :데이터베이스 오브젝트 내 실제 데이터를 저장하는 공간
--           이것은 데이터베이스의 물리적인 부분이며, 세그먼트로 관리되는 모든 DBMS에 대해 
--           저장소(세그먼트)를 할당
-- 테이블이 저장되는 곳,,,, 이라는 뜻 같음 
------------------------------------------------------
-- 1. TableSpace 생성
create tableSpace user1 Datafile 'C:\BACKUP\tableSpace\user1.ora' SIZE 100M;
create tableSpace user2 Datafile 'C:\BACKUP\tableSpace\user2.ora' SIZE 100M;
create tableSpace user3 Datafile 'C:\BACKUP\tableSpace\user3.ora' SIZE 100M;
create tableSpace user4 Datafile 'C:\BACKUP\tableSpace\user4.ora' SIZE 100M;

-- 테이블스페이스 삭제
-- DROP TABLESPACE user4 INCLUDING CONTENTS AND DATAFILES;

-- 2. 테이블의 테이블 스페이스 변경
--    1) 테이블의 NDEX와 Table의  테이블 스페이스 조회
select index_name, table_name, tablespace_name
from user_indexes;
-- 인덱스를 테이블 스페이스로 변경
alter index PK_RELIGIONNO3 REBUILD tablespace user1;

select table_name, tablespace_name
from user_tables;
alter table job3 move tablespace user2;

-- 3. 테이블 스페이스 size 변경
alter Database DATAFILE 'C:\BACKUP\tableSpace\user4.ora' resize 200M;

------------------백업

-- cmd창
-- Oracle 전체 Backup  (scott) --> system1_0702.sql확인 --> cmd창에서 설정 & 오라백업폴더에서 실행
EXPDP scott/tiger Directory=mdBackup2 DUMPFILE=scott.dmp;

-- Oracle 전체 Restore  (scott)
IMPDP scott/tiger Directory=mdBackup2 DUMPFILE=scott.dmp;

-- Oracle 부분 Backup후  부분 Restore
exp scott/tiger file=dept_second.dmp tables=dept_second
-- 테이블을 덤프파일로 만들어넣겟다
exp scott/tiger file=address.dmp tables=address
-- 부분 복구
imp scott/tiger file=dept_second.dmp tables=dept_second
imp scott/tiger file=address.dmp tables=address

----------------------------------------------------------------------------------------
-------                     Trigger 
--  1. 정의 : 어떤 사건이 발생했을 때 내부적으로 실행되도록 데이터베 이스에 저장된 프로시저
--              트리거가 실행되어야 할 이벤트 발생시 자동으로 실행되는 프로시저 
--              트리거링 사건(Triggering Event), 즉 오라클 DML 문인 INSERT, DELETE, UPDATE이 
--              실행되면 자동으로 실행
--  2. 오라클 트리거 사용 범위
--    1) 데이터베이스 테이블 생성하는 과정에서 참조 무결성과 데이터 무결성 등의 복잡한 제약 조건 생성하는 경우 
--    2) 데이터베이스 테이블의 데이터에 생기는 작업의 감시, 보완 
--    3) 데이터베이스 테이블에 생기는 변화에 따라 필요한 다른 프로그램을 실행하는 경우 
--    4) 불필요한 트랜잭션을 금지하기 위해 
--    5) 컬럼의 값을 자동으로 생성되도록 하는 경우 
-------------------------------------------------------------------------------------------
-- 트리거 생성
Create or replace trigger triger_test 
before --  지정된 이벤트가 발생하기전 실행
update on dept 
for each row -- old, new 사용 위해서
begin -- 시작과 끝을 명시
    DBMS_OUTPUT.enable;                             -- triger는 앞에 :을 한다 띄어쓰기 X
    DBMS_OUTPUT.PUT_LINE('변경 전 컬럼 값: ' || :old.dname); -- 현재 이름
    DBMS_OUTPUT.PUT_LINE('변경 후 컬럼 값: ' || :new.dname); -- 변경 후 이름
END; 

update dept
set dname ='회계3팀' -- 변경 후 이름 
where deptno = 71;

commit;

rollback;

----------------------------------------------------------
-- 현장 워크 ) emp Table의 급여가 변화시
--       화면에 출력하는 Trigger 작성( emp_sal_change)
--       emp Table 수정전
--      조건 : 입력시는 empno가 0보다 커야함

--출력결과 예시
--     이전급여  : 10000
--     신  급여  : 15000
 --    급여 차액 :  5000
----------------------------------------------------------
Create or replace trigger emp_sal_change
before DELETE OR INSERT OR update on emp
for each row
    when (new.empno > 0)
    declare -- 선언
        sal_diff number;
begin   -- := 문법
    sal_diff := :new.sal - :old.sal;
    DBMS_OUTPUT.PUT_LINE('이전 급여: ' || :old.sal); -- 현재 이름
    DBMS_OUTPUT.PUT_LINE('신 급여: ' || :new.sal); -- 변경 후 이름
    --DBMS_OUTPUT.PUT_LINE('급여 차액: ' || :new.sal-old.sal); -- 현재 이름
    DBMS_OUTPUT.PUT_LINE('급여 차액: ' || sal_diff); 
END;

update emp
set sal = 1000
where empno = 7369;


--------------------------------------------------------------------------------------------------
--  EMP 테이블에 INSERT,UPDATE,DELETE문장이 하루에 몇 건의 ROW가 발생되는지 조사
--  조사 내용은 EMP_ROW_AUDIT에 
--  ID ,사용자 이름, 작업 구분,작업 일자시간을 저장하는 
--  트리거를 작성
-------------------------------------------------------------------------------------------------
-- 1. SEQUENCE
--DROP  SEQUENCE  emp_row_seq;
create sequence emp_row_seq;
-- 2. Audit Table
--DROP  TABLE  emp_row_audit;
create table emp_row_audit(
     e_id number(6) constraint emp_row_pk primary key,
     e_name varchar2(30),
     e_gubun varchar2(10),
     e_date date
 );
 
 -- 3. trigger
 create or replace trigger emp_row_aud
    after insert or update or delete on emp
    for each row
    begin
        if inserting then
            insert into emp_row_audit
                values(emp_row_seq.nextVAL,:new.ename,'inserting',sysdate);
        elsif updating then
            insert into emp_row_audit
                values(emp_row_seq.nextVAL,:old.ename,'updating',sysdate);
        elsif deleting then
            insert into emp_row_audit
                values(emp_row_seq.nextVAL,:old.ename,'deleting',sysdate);
        end if;
End;

insert into emp(empno,ename, sal,deptno)
    values(3000,'유지원',3500,50);
    
insert into emp(empno,ename, sal,deptno)
    values(3100,'황정후',3500,51);

update emp
set ename = '황보슬'
where empno = 1600;

delete emp
where empno = 1502;

rollback;

            