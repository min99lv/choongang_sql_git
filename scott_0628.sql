-----------------------------------------------------------------
----- SUB Query   ***
-- 하나의 SQL 명령문의 결과를 다른 SQL 명령문에 전달하기 위해 
-- 두 개 이상의 SQL 명령문을 하나의 SQL명령문으로 연결하여
-- 처리하는 방법
-- 종류 
-- 1) 단일행 서브쿼리
-- 2) 다중행 서브쿼리
-------------------------------------------------------------------
--  1. 목표 : 교수 테이블에서 ‘전은지’ 교수와 직급이 동일한 모든 교수의 이름 검색
--    1-1 교수 테이블에서 ‘전은지’ 교수의 직급 검색 SQL 명령문 실행

--   1-2 교수 테이블의 직급 칼럼에서 1 에서 얻은 결과 값과 동일한 
--       직급을 가진 교수 검색 명령문 실행
SELECT name, position
FROM professor
WHERE position = '전임강사'
;
-- 1.목표 : 교수 테이블에서 ‘전은지’ 교수와 직급이 
--  동일한 모든 교수의 이름 검색--> SUB Query
SELECT name, position
FROM professor
WHERE position = (
                    SELECT position 
                    FROM professor
                    WHERE name = '전은지' 
                 )
;
-- ( ) 괄호 안이 1번으로 실행된다 = 한방처리 괄호안이 서브쿼리 

-- 종류 
-- 1) 단일행 서브쿼리
--  서브쿼리에서 단 하나의 행만을 검색하여 메인쿼리에 반환하는 질의문
--  메인쿼리의 WHERE 절에서 서브쿼리의 결과와 비교할 경우에는 반드시 단일행 비교 
--  연산자 중 하나만 사용해야함

--  문1) 사용자 아이디가 ‘jun123’인 학생과 같은 학년인 학생의 학번, 이름, 학년을 출력하여라
SELECT studno, name, grade
FROM student
WHERE grade = (
                select grade
                from student
                where userid = 'jun123'
              )
;
--  문2)  101번 학과 학생들의 평균 몸무게보다 몸무게가 적은 학생의 이름, 학년 ,
--          학과번호, 몸무게를  출력
--  조건 : 학과별 오름차순 출력
select name, grade, deptno, weight
FROM student
where weight < (
                    select avg(weight)
                    from student
                    where deptno = 101
                )
order by deptno
;
--  문3) 20101번 학생과 학년이 같고, 키는 20101번 학생보다 큰 학생의 
-- 이름, 학년, 키, 학과명 를 출력하여라
--  조건 : 학과별 내림차순 출력
select s.name, s.grade, s.height, d.dname
FROM student s, department d
where s.deptno = d.deptno
and   s.grade = (
                        select grade
                        from student
                        where studno = 20101  
)
and s.height > (
-- 172
                        select height
                        from student
                        where studno = 20101  
)
order by d.dname desc
;
---------------------------------------------------------------------------------
-- 2) 다중행 서브쿼리
-- 서브쿼리에서 반환되는 결과 행이 하나 이상일 때 사용하는 서브쿼리
-- 메인쿼리의 WHERE 절에서 서브쿼리의 결과와 비교할 경우에는 다중 행 비교 연산자 
--  를 사용하여 비교
-- 다중 행 비교 연산자 : IN, ANY, SOME, ALL, EXISTS
-- 1) IN         : 메인 쿼리의 비교 조건이 서브쿼리의 결과중에서 하나라도 일치하면 참, 
--                    ‘=‘비교만 가능
-- 2) ANY, SOME  : 메인 쿼리의 비교 조건이 서브쿼리의 결과중에서 하나라도 일치하면 참
-- 3) ALL             : 메인 쿼리의 비교 조건이 서브쿼리의 결과중에서 모든값이 일치하면 참, 
-- 4) EXISTS        : 메인 쿼리의 비교 조건이 서브쿼리의 결과중에서 만족하는 값이 하나라도 존재하면 참
--------------------------------------------------------------------------------
-- 1. IN연산자를 이용한 다중 행 서브쿼리
SELECT name, grade, deptno
FROM student
WHERE deptno = (
                select deptno
                from department
                where college = 100
                )
;-- --  single-row subquery returns more than one row
-- 하나 이상의 리턴값을 서브쿼리가 가졋기때문에 메인쿼리 오류가 난다 
-- college= 100 이면 deptno = 101, 102 이기때문에 리턴값이 두개 = 로 표현 불가능
-- 1. IN연산자를 이용한 다중 행 서브쿼리
SELECT name, grade, deptno
FROM student
WHERE deptno in (
                select deptno
                from department
                where college = 100
                )
;
-- 위랑 같은 의미
SELECT name, grade, deptno
FROM student
WHERE deptno in (
                    101,102
                )
;
--  2. ANY 연산자를 이용한 다중 행 서브쿼리
--      :메인 쿼리의 비교 조건이 서브쿼리의 결과중에서 하나라도 일치하면 참
-- 문)모든 학생 중에서 4학년 학생 중에서 키가 제일 작은 학생보다 
--      키가 큰 학생의 학번, 이름, 키를 출력하여라
SELECT studno, name, height
FROM student
WHERE height > any (
-- any : 어떤것보다 큰 것 175, 176, 177 --> min 생각 
            SELECT height
            FROM student
            WHERE grade = '4'
            )
;
--  3. ALL 연산자를 이용한 다중 행 서브쿼리
SELECT studno, name, height
FROM student
WHERE height > ALL (
-- all : 모든것보다 큰 것 175, 176, 177 --> max 생각 
            SELECT height
            FROM student
            WHERE grade = '4'
            )
;
-- 4. EXISTS 연산자를 이용한 다중 행 서브쿼리
-- :메인 쿼리의 비교 조건이 서브쿼리의 결과중에서 만족하는 값이 하나라도 존재하면 참
-- 사용목적 : 성능때문에 사용
SELECT profno, name, sal, comm, position
FROM professor
WHERE EXISTS(
-- : 존재가 1row라도 있다면 실행시켜라
                SELECT position
                FROM professor
                WHERE comm is not null
            )
;
SELECT profno, name, sal, comm, position
FROM professor
WHERE EXISTS(
-- : 서브쿼리 존재가 1row라도 있다면 메인쿼리 실행 
                SELECT position
                FROM professor
               -- WHERE deptno = 202
                WHERE deptno = 203 -- 1row도 존재하지 않기때문에 메인쿼리 실행 X
            )
;
-- 문1)  보직수당을 받는 교수가 한 명이라도 있으면 
--       모든 교수의 교수 번호, 이름, 보직수당 그리고 급여와 보직수당의 합(NULL처리)을 출력
SELECT profno, name,sal, comm,sal+NVL(comm,0) sal_comm
FROM professor
WHERE EXISTS (
                select profno
                FROM professor
                WHERE comm is not null
             )
;
-- 문2) 학생 중에서 ‘goodstudent’이라는 사용자 아이디가 없으면 1을 출력하여라
SELECT 1 userid_exist
FROM dual
WHERE NOT EXISTS ( 
                    SELECT userid
                    FROM student
                    WHERE userid = 'goodstudent'
                )
;

-- 다중 컬럼 서브쿼리
-- 서브쿼리에서 여러 개의 칼럼 값을 검색하여 메인쿼리의 조건절과 비교하는 서브쿼리
-- 메인쿼리의 조건절에서도 서브쿼리의 칼럼 수만큼 지정
-- 종류
-- 1) PAIRWISE : 칼럼을 쌍으로 묶어서 동시에 비교하는 방식
-- 2) UNPAIRWISE : 칼럼별로 나누어서 비교한 후, AND 연산을 하는 방식
-- 다중컬럼 서브쿼리
-- 1) PAIRWISE :칼럼을 쌍으로 묶어서 동시에 비교하는 방식
-- 문1)    PAIRWISE 비교 방법에 의해 학년별로 몸무게가 최소인 
--          학생의 이름, 학년, 몸무게를 출력하여라
SELECT name, grade, weight
FROM student
WHERE (grade,weight) IN (
                        SELECT grade,min(weight)
                        FROM student
                        GROUP BY grade
                        )
;
--  2) UNPAIRWISE : 칼럼별로 나누어서 비교한 후, AND 연산을 하는 방식
-- UNPAIRWISE 비교 방법에 의해 학년별로 몸무게가 최소인 학생의 이름, 학년, 몸무게를 출력
SELECT name, grade, weight
FROM student
-- 1,2,3,4 AND 52,42,70,72 = 섞여서 나온다 1학년에 52,70,72......
WHERE grade IN (
                        SELECT grade
                        FROM student
                        GROUP BY grade
                      
                )
AND weight IN (                 --52, 42, 70, 72
                        SELECT min(weight)
                        FROM student
                        GROUP BY grade
               )
                    
;
-- 상호연관 서브쿼리     ***
-- 메인쿼리절과 서브쿼리간에 검색 결과를 교환하는 서브쿼리
-- 문1)  각 학과 학생의 평균 키보다 키가 큰 학생의 이름, 학과 번호, 키를 출력하여라
--                실행순서 1
----              실행순서 3
select deptno, name, grade, height --실행 1 /마지막 refresh 실행 3
from student s1
WHERE height > (
                select avg(height)
                from student s2
                -- where s2.deptno = 101
                --                  실행순서 2
                WHERE s2.deptno = s1.deptno -- 실행 2
                ) -- 서브쿼리 안에 메인쿼리 테이블이 들어간다
order by deptno
;

-------------  HW  -----------------------
-- 1. Blake와 같은 부서에 있는 모든 사원에 대해서 사원 이름과 입사일을 디스플레이하라
-- 2
SELECT ename, hiredate, deptno
from emp 
where deptno = (
                select deptno
                from emp
                where ename = 'BLAKE'
                -- 강사님 코드
                -- where inicap(ename) = 'Blake' 
)
;
-- 2. 평균 급여 이상을 받는 모든 사원에 대해서 사원 번호와 이름을 디스플레이하는 질의문을 생성. 
--    단 출력은 급여 내림차순 정렬하라
select empno,ename
from emp
where sal>= (  
        select avg(sal)
        from emp
        )
order by sal desc
;
-- 3. 보너스를 받는 사원의 부서 번호와 
--    급여에 일치하는 사원의 이름, 부서 번호 그리고 급여를 디스플레이하라.
select ename,deptno,sal,comm
from emp
where (deptno,sal) in (
                select deptno,sal
                from emp
                where comm is not null 
                ) 
;


SELECT e1.ename 사원, e1.deptno "부서 번호",e1.sal 급여
FROM emp e1
JOIN emp e2 ON e1.sal = e2.sal
WHERE e1.comm IS NOT NULL
AND e1.empno != e2.empno
ORDER BY 급여 DESC
;
-------------------------------------------------------------------------------
--  데이터 조작어 (DML:Data Manpulation Language)  **      ----------------------
-- 1.정의 : 테이블에 새로운 데이터를 입력하거나 기존 데이터를 수정 또는 삭제하기 위한 명령어
-- 2. 종류 
--  1) INSERT : 새로운 데이터 입력 명령어
--  2) UPDATE : 기존 데이터 수정 명령어
--  3) DELETE : 기존 데이터 삭제 명령어
--  4) MERGE : 두개의 테이블을 하나의 테이블로 병합하는 명령어

-- 1) Insert
INSERT INTO dept values (73,'인사')
; -- not enough values
INSERT INTO dept values (73,'인사','이대')
;
INSERT INTO dept(deptno,dname,loc)values (74,'회계팀','충정로')
;
INSERT INTO dept(deptno,loc,dname)values (75,'신대방','자재팀') -- 위치를 맞춰주어야함
;
INSERT INTO DEPT (deptno,loc) values (76,'홍대') 
; --  값을 주지 않은곳은 null로 들어간다

--9910	백미선		전임교사		24/06/28		101
--9920	최윤식		조교수		06/01/01		102
INSERT INTO professor(profno,name,position,hiredate,deptno) 
        values('9910','백미선','전임교사',sysdate,101)
;
INSERT INTO professor(profno,name,position,hiredate,deptno) 
        values('9920','최윤식','조교수',to_Date('06/01/01','yy/mm/dd'),102)
;
-- 테이블 삭제 
DROP TABLE JOB3
;
-- 테이블 생성
CREATE TABLE JOB3
(   jobno          NUMBER(2)      PRIMARY KEY,
	jobname       VARCHAR2(20)
) ;
insert into job3                values(10,'학교')
;
insert into job3 (jobno,jobname)values(11,'공무원')
;
insert into job3 (jobname,jobno)values('공기업',12)
;
insert into job3                values(13,'대기업')
;
insert into job3                values(14,'중소기업')
;
-- hw
--10	기독교
--20	카톨릭교
--30	불교
--40	무교
CREATE TABLE Religion   
(   religion_no         NUMBER(2)     CONSTRAINT PK_ReligionNo3 PRIMARY KEY,
	 religion_name     VARCHAR2(20)
) ;

insert into religion values (10,'기독교');
insert into religion (religion_no,religion_name) values (20,'카톨릭교');
insert into religion (religion_name,religion_no) values ('불교',30);
insert into religion values (40,'무교');

--------------------------------------------------
-----   다중 행 입력                          ------
--------------------------------------------------
-- 1. 생성된 TBL이용 신규 TBL 생성 --> 테이블 복사개념같음
CREATE TABLE dept_second
as select * from dept
; 
-- 2. tbl 가공 생성 
-- 원하는 조건으로 테이블 생성 / 부서번호 = 20인 사람
-- 프라이머리키는 복제되지 않는다.
CREATE TABLE emp20
as select empno, sal*12 annsal
    from emp
    where deptno = 20
    ;
-- 3. TBL 구조만
create table dept30
as select deptno, dname
    from dept
    where 0 = 1 -- -> 같지 않다는 의미 스키마만 생성되어 있음 --껍데기만
    ; -- 1= 1 1=2;??????
-- 4. columm 추가
Alter table dept30
add(birth date)
;
INSERT into dept30 values (10,'중앙학교',sysdate)
;
-- 5. Column 변경
ALTER table dept30
MODify dname Varchar(11)
;-- value is too big 중앙학교12byte이므로 불가능 
ALTER table dept30
MODify dname Varchar(30)
; -- 키우는것은 가능하지만 크기를 줄일때는 들어가있는데이터의 맥시멈 데이터보다 커야한다
-- 6.Column 삭제
ALTER TABLE dept30
DROP COLUMN dname
;
-- 7. TBL 명 변경
RENAME dept30 to dept35
;
-- 8. TBL 제거
DROP TABLE dept35
;
-- 9. Truncate
TRUNCATE table dept_second
;
-- INSERT ALL(unconditional INSERT ALL) 명령문
-- 서브쿼리의 결과 집합을 조건없이 여러 테이블에 동시에 입력
-- 서브쿼리의 컬럼 이름과 데이터가 입력되는 테이블의 칼럼이 반드시 동일해야 함
CREATE table height_info
(   studNO number(5),
    NAME    varchar2(20),
    height number(5,2)
)
;
    CREATE table weight_info
(   studNO number(5),
    NAME    varchar2(20),
    weight number(5,2)
)
;
insert all
into height_info values(studNo, name, height)
into weight_info values(studNo, name, weight)
select studno, name, height, weight, grade
from student
where grade >= '2'
;
delete height_info;
delete weight_info;

-- INSERT ALL 
-- [WHEN 조건절1 THEN
-- INTO [table1] VLAUES[(column1, column2,…)]
-- [WHEN 조건절2 THEN
-- INTO [table2] VLAUES[(column1, column2,…)]
-- [ELSE
-- INTO [table3] VLAUES[(column1, column2,…)]
-- subquery;

-- 학생 테이블에서 2학년 이상의 학생을 검색하여 
-- height_info 테이블에는 키가 170보다 큰 학생의 학번, 이름, 키를 입력
-- weight_info 테이블에는 몸무게가 70보다 큰 학생의 학번, 이름, 몸무게를 
-- 각각 입력하여라
insert all
when height > 170 then 
    into height_info values(studNo, name, height)
when weight > 75 then
    into weight_info values(studNo,name, weight)
select studno, name, height, weight
from student
where grade >= '2'
; -- 조건별로 입력 가능...........................
-- 데이터 수정 개요
-- UPDATE 명령문은 테이블에 저장된 데이터 수정을 위한 조작어
-- WHERE 절을 생략하면 테이블의 모든 행을 수정
--- Update 
-- 문1) 교수 번호가 9903인 교수의 현재 직급을 ‘부교수’로 수정하여라
update professor
set position = '부교수', userid = 'kkk'
where profno = 9903
-- or 1 = 1  rollback
;
--  문2) 서브쿼리를 이용하여 학번이 10201인 학생의 학년과 학과 번호를
--        10103 학번 학생의 학년과 학과 번호와 동일하게 수정하여라
update student 
set (grade,deptno) = ( -- 페어와일즈
        select grade,deptno -- 3학년 101
        from student
        where studno = 10103 
        )
where studno = 10201
;
-- 데이터 삭제 개요 - dml
-- DELETE 명령문은 테이블에 저장된 데이터 삭제를 위한 조작어
-- WHERE 절을 생략하면 테이블의 모든 행 삭제

-- 문1) 학생 테이블에서 학번이 20103인 학생의 데이터를 삭제
delete
from student
where studno = 20103
;

-- 문2) 학생 테이블에서 컴퓨터공학과에 소속된 학생을 모두 삭제하여라 hw --> rollback 
-- commit xx
delete 
from student 
where deptno = (
                    select deptno
                    from department 
                    where dname = '컴퓨터공학과'
              )
;
ROLLBACK;
----------------------------------------------------------------------------------
---- MERGE
--  1. MERGE 개요
--     구조가 같은 두개의 테이블을 비교하여 하나의 테이블로 합치기 위한 데이터 조작어
--     WHEN 절의 조건절에서 결과 테이블에 해당 행이 존재하면 UPDATE 명령문에 의해
--     새로운 값으로 수정,그렇지 않으면 INSERT 명령문으로 새로운 행을 삽입
------------------------------------------------------------------------------------
-- 1] MERGE 예비작업 
--  상황 
-- 1) 교수가 명예교수로 2행 Update
-- 2) 김도경 씨가 신규 Insert

Create table professor_temp
as select * from professor
    where position = '교수'
;
update professor_temp
set position = '명예교수'
where position = '교수'
;
insert into professor_temp
values (9999,'김도경','arom21','전임강사',200,sysdate,10,101)
;

commit;
-- 2] professor MERGE 수행 
-- 목표 : professor_temp에 있는 직위   수정된 내용을 professor Table에 Update
--                         김도경 씨가 신규 Insert 내용을 professor Table에 Insert
-- 1) 교수가 명예교수로 2행 Update
-- 2) 김도경 씨가 신규 Insert
merge into professor p
using professor_temp f
ON (p.profno = f.profno)
when matched then -- pk가 같으면 직위를 업데이트
    update set p.position = f.position
when not matched then -- pk가 없으면 신규 insert
    insert values(f.profno,f.name,f.userid,f.position,f.sal,f.hiredate,f.comm,f.deptno)
;
-- 없으면 인서트 있으면 업데이트



