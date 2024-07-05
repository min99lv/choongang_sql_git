-------------------------------------------------------------
------------            제약조건(Constraint)        ***          ------------
--  정의  : 데이터의 정확성과 일관성을 보장
-- 1. 테이블 생성시 무결성 제약조건을 정의 가능
-- 2. 테이블에 대해 정의, 데이터 딕셔너리에 저장되므로 응용 프로그램에서 입력된 
--     모든 데이터에 대해 동일하게 적용
-- 3. 제약조건을 활성화, 비활성화 할 수 있는 융통성
-------------------------------------------------------------

-------------------------------------------------------------
------------            제약조건(Constraint)   종류      ***  ------------
-- 1. NOT NULL  : 열이 NULL을 포함할 수 없음
-- 2. 기본키(primary key) : UNIQUE +  NOT NULL + 최소성  제약조건을 결합한 형태
-- 3. 참조키(foreign key) :  테이블 간에 외래 키 관계를 설정 ***
-- 4. CHECK : 해당 칼럼에 저장 가능한 데이터 값의 범위나 조건 지정
-------------------------------------------------------------
-- 1.  제약조건(Constraint) 적용 위한 강좌(subject) 테이블 인스턴스
create table subject(
    -- 제약조건명을 넣지 안으면 시스템 일련번호를 줌 --> 관리가 쉽지 않음
    -- subno number(5) primary key,
    subno number(5) constraint subject_no_pk primary key,
    subname varchar2(20) constraint subject_name_nn not null,
    term varchar2(1) constraint subject_term_ck check(term in ('1','2')),
    typeGubun varchar2(1)
);

comment on COLUMN subject.subno is '수강번호';
comment on COLUMN subject.subname is '수강과목';
comment on COLUMN subject.term is '학기';

INSERT INTO subject(subno, subname, term, typegubun)
            values(10000,'컴퓨터개론','1','1');
INSERT INTO subject(subno, subname, term, typegubun)
            values(10001,'DB개론','2','1');
INSERT INTO subject(subno, subname, term, typegubun)
            values(10002,'jsp개론','1','1');

-- pk constraint --> unique           
-- 값을 정확하게 넣는 방법 pk의 제약조건에 걸리기때문에 오류
INSERT INTO subject(subno, subname, term, typegubun)
            values(10001,'Spring개론','1','1');

-- pk constraint --> not null
-- subno가 notnull이기 때문에 작성하지 않으면 오류             
INSERT INTO subject(subno, term, typegubun)
            values(10003,'1','1');  
            
-- subname NN            
-- subname이 not null 이기때문에 안된다
INSERT INTO subject(subno, term, typegubun)
            values(10003,'1','1'); 
            
-- check constraint --> term
-- term의 범위를 벗어나기때문에 오류
INSERT INTO subject(subno, subname, term, typegubun)
            values(10003,'Spring개론3','5','1');
            
-- Table 선언시 못한것을 추후 정의 가능
-- Student Table 의 idnum을 unique로 선언
-- 값의 중복된 키가 있으면 오류 
Alter table student
add constraint stud_idnum_uk unique(idnum)
;
-- 행 삽입
insert into student(studno, name, idnum)
    values(30101,'대조영','8012301036613')
;
-- idnum --> unique constraint
-- indum unique 설정이 잘 되었는지 확인하는 코드
insert into student(studno, name, idnum)
    values(30102,'강감찬','8012301036613')
;
-- idnum --> unique로만 걸어주면 null값 가능
insert into student(studno, name)
    values(30103,'강민첨')
;

-- student table 의 name을 not null으로 선언
alter table student
modify (name constraint stud_name_nn NOT NULL)
;
--  name은 not null이므로 값을 입력하지 않으면 오류
-- 오류 : cannot insert NULL into ("SCOTT"."STUDENT"."NAME")
INSERT INTO student(studno, idnum)
        VALUES (30103, '8012301036614')
;

-- CONSTRAINT 조회
-- 데이터 딕셔너리에 대문자로 들어가야해서 대문자로 적어야함
SELECT constraint_name, constraint_type
FROM user_constraints
WHERE table_name in('SUBJECT','STUDENT')
;--- r 외래키

-- fk(외래키)***

delete emp
where empno = 1000;

delete dept
where deptno = 50;

-- 조건1. Restrict : 자식 존재 삭제 안됨  (연관 관계 때문)
--    1) 선언   Emp Table에서  REFERENCES DEPT (DEPTNO) 
--    2) 예시   integrity constraint (SCOTT.FK_DEPTNO) violated - child record found
delete dept
where deptno = 50;
-- 조건2. Cascading Delete : 같이 죽자
--    1)종속삭제 선언 : Emp Table에서 REFERENCES DEPT (DEPTNO) ON DELETE CASCADE
-- 부모, 자식 둘 다 삭제
delete dept
where deptno = 50;
-- 조건3.  SET NULL   
--    1) 종속 NULL 선언 : Emp Table에서 REFERENCES DEPT (DEPTNO)  ON DELETE SET NULL
-- 부모는 없어지고 자식은 null이된다
delete dept
where deptno = 50;

rollback;
---------------------------------------------------------------
-----      INDEX      ***
--  인덱스는 SQL 명령문의 처리 속도를 향상(*) 시키기 위해 칼럼에 대해 생성하는 객체
--  인덱스는 포인트를 이용하여 테이블에 저장된 데이터를 랜덤 액세스하기 위한 목적으로 사용
--  [1]인덱스의 종류
--   1)고유 인덱스 : 유일한 값을 가지는 칼럼에 대해 생성하는 인덱스로 모든 인덱스 키는
--           테이블의 하나의 행과 연결
-- 인덱스와 프라이머리키의 차이 NULL값이 되느냐 안되느냐
CREATE UNIQUE INDEX idx_dept_name
ON department(dname);

INSERT INTO department
            values (300,'이과대학',10,'kk');
            
--  unique constraint  --> 오류 인덱스도 걸리는데, 유니크제약조건이 같이 걸림
INSERT INTO department (deptno,dname, college, loc) 
            values (301,'이과대학',10,'kkk2')
;

-- 비고유 인덱스 birthdate --> constraint X , 성능에만 영향을 미친다
--   2)비고유 인덱스
-- 문) 학생 테이블의 birthdate 칼럼을 비고유 인덱스로 생성하여라
CREATE INDEX idx_stud_birthdate
ON student(birthdate)
;
-- 데이터베이스 추가
INSERT INTO student(studno, name, idnum,birthdate)
        values(30102,'김유신','8012301036614', '84/09/16')
;
-- 두명이 같은 생일을 가지고 있음 제약조건에 걸리지 않음
SELECT * 
FROM student
WHERE birthdate = '84/09/16'
;
--   3)단일 인덱스
--   4)결합 인덱스 :  두 개 이상의 칼럼을 결합하여 생성하는 인덱스
--     문) 학생 테이블의 deptno, grade 칼럼을 결합 인덱스로 생성
--          결합 인덱스의 이름은 idx_stud_dno_grade 로 정의
CREATE INDEX  idx_stud_dno_grade
ON student(deptno, grade)
;

-- 인덱스 걸린 순서대로 sql을 태우는것이 성능면에서 더 낫다
-- 느림
SELECT *
FROM student
WHERE grade = 2
AND deptno = 101
;
-- 빠름
SELECT *
FROM student
where deptno = 101
and grade = 2
;

--- Optimizer
--- 1) RBO  2) CBO
-- RBO 변경
ALTER SESSION SET OPTIMIZER_MODE=RULE
;

-- 옵티마이저가 실행계획을 자동으로 선택
ALTER SESSION set OPTiMIZER_MODE = choose

-- CBO 변경
-- 눈에 보일 수 있는 라인만 가져오면 화면을 보여줌 위 코드에 비해서 빠름
ALTER SESSION SET OPTiMIZER_MODE = first_rows
-- 전체라인을 다 가져왔을때 화면을 보여줌 위 코드에 비해서 느림
ALTER SESSION set OPTiMIZER_MODE = ALL_rows

-- SQL Optimize
select /* + first_rows*/ ename from emp;
select /* + rule*/ ename from emp;

-- Optimizer 모드 확인
select name, value, isdefault, ismodified, description
from V$SYSTEM_PARAMETER
where name LIKE '%optimizer_mode%'
;

-- [2]인덱스가 효율적인 경우 
--   1) WHERE 절이나 조인 조건절에서 자주 사용되는 칼럼
--   2) 전체 데이터중에서 10~15%이내의 데이터를 검색하는 경우
--   3) 두 개 이상의 칼럼이 WHERE절이나 조인 조건에서 자주 사용되는 경우
--   4) 테이블에 저장된 데이터의 변경이 드문 경우
--   5) 열에 널 값이 많이 포함된 경우, 열에 광범위한 값이 포함된경우
---------------------------------------------------------------------------------------------------

-- 만약 pk가 깨지면 deptno -> 인덱스를 재구성하면 된다
-- pk가 깨졌다 --> 기본 키 제약 조건이 위배되었음을 의미
-- 학생 테이블에 생성된 PK_DEPTNO 인덱스를 재구성
-- 재구성  : 기존의 인덱스를 삭제하고 새로운 인덱스를 생성하는 과정
ALTER INDEX PK_DEPTNO REBUILD;

-- 1. index 조회
select index_name, table_name, column_name
from user_ind_columns;

-- 2. index 생성 emp(job)
CREATE index idx_emp_job ON emp(job);

-- 3. 조회
ALTER SESSION SET OPTIMIZER_MODE=RULE;
-- 인덱스를 타는 경우
select * from emp where job = 'MANAGER'; -- = index OK
-- 인덱스를 타지 않는 경우
--부정형으로 가져왓을때 인덱스를 타지 않는
select * from emp where job <> 'MANAGER'; -- <> index NO
select * from emp where job like '%NA%'; -- like '%NA%' index NO
select * from emp where job like 'MA%'; -- like 'MA%' index OK
select * from emp where upper(job) = 'MANAGER'; -- =함수(컬럼) index NO


--   5)함수 기반 인덱스(FBI) function based index
--      오라클 8i 버전부터 지원하는 새로운 형태의 인덱스로 칼럼에 대한 연산이나 함수의 계산 결과를 
--      인덱스로 생성 가능
--      UPPER(column_name) 또는 LOWER(column_name) 키워드로 정의된
--      함수 기반 인덱스를 사용하면 대소문자 구분 없이 검색
CREATE INDEX uppercase_idx ON emp (upper(job));

SELECT * FROM emp where upper(job) ='SALESMAN';

 ---------------------------------------------------------------------------------
-- 트랜잭션 개요  ***
-- x
-- COMMIT : 트랜잭션의 정상적인 종료
--               트랜잭션내의 모든 SQL 명령문에 의해 변경된 작업 내용을 디스크에 영구적으로 저장하고 
--               트랜잭션을 종료
--               해당 트랜잭션에 할당된 CPU, 메모리 같은 자원이 해제
--               서로 다른 트랜잭션을 구분하는 기준
--               COMMIT 명령문 실행하기 전에 하나의 트랜잭션 변경한 결과를
--               다른 트랜잭션에서 접근할 수 없도록 방지하여 일관성 유지
 
-- ROLLBACK : 트랜잭션의 전체 취소
--                   트랜잭션내의 모든 SQL 명령문에 의해 변경된 작업 내용을 전부 취소하고 트랜잭션을 종료
--                   CPU,메모리 같은 해당 트랜잭션에 할당된 자원을 해제, 트랜잭션을 강제 종료
---------------------------------------------------------------------------------
----------------------------------
-- SEQUENCE ***
-- 유일한 식별자
-- 기본 키 값을 자동으로 생성하기 위하여 일련번호 생성 객체
-- 예를 들면, 웹 게시판에서 글이 등록되는 순서대로 번호를 하나씩 할당하여 기본키로 지정하고자 할때 
-- 시퀀스를 편리하게 이용
-- 여러 테이블에서 공유 가능  -- > 일반적으로는 개별적 사용 
----------------------------------
-- 1) SEQUENCE 형식
--CREATE SEQUENCE sequence
--[INCREMENT BY n]
--[START WITH n]
--[MAXVALUE n | NOMAXVALUE]
--[MINVALUE n | NOMINVALUE]
--[CYCLE | NOCYCLE]
--[CACHE n | NOCACHE];
--INCREMENT BY n : 시퀀스 번호의 증가치로 기본은 1,  일반적으로 ?1 사용
--START WITH n : 시퀀스 시작번호, 기본값은 1
--MAXVALUE n : 생성 가능한 시퀀스의 최대값
--MAXVALUE n : 시퀀스 번호를 순환적으로 사용하는 cycle로 지정한 경우, MAXVALUE에 도달한 후 새로 시작하는 시퀀스값
--CYCLE | NOCYCLE : MAXVALUE 또는 MINVALUE에 도달한 후 시퀀스의 순환적인 시퀀스 번호의 생성 여부 지정
--CACHE n | NOCACHE : 시퀀스 생성 속도 개선을 위해 메모리에 캐쉬하는 시퀀스 개수, 기본값은 20


-- 2) SEQUENCE sample 예시
create sequence sample_seq
-- 옵션
increment by 1 -- 하나 씩 증가 
start with 10000; -- 10000부터 시작

-- 니가 가지고올 수 있는 다음번호 가져와
select sample_seq.nextval from dual;
-- 증가 시키지말고 현재 값을 보여줘
select sample_seq.CURRVAL from dual;

-- 3) SEQUENCE sample예시 2 --> 실사용예씨
Create sequence dept_dno_seq 
INCREMENT by 1
start with 76;

-- 4) SEQUENCE dept_dno_seq를 이용 dept_second 입력 --> 실 사용 예시
insert into dept_second
values(dept_dno_seq.NEXTVAL, 'Accounting', 'NEW YORK');

SELECT dept_dno_seq.CURRVAL from dual;

-- 77, '회계', '이대'
insert into dept_second
values(dept_dno_seq.NEXTVAL,'회계','이대');
SELECT dept_dno_seq.CURRVAL from dual;

-- 79, '인사팀' ,'당산'
insert into dept_second
values(dept_dno_seq.NEXTVAL,'인사팀','당산');
SELECT dept_dno_seq.CURRVAL from dual;


-- MAX 전환
insert into dept_second
values((select max(deptno)+1 from dept_second)
                    ,'경영팀'
                    ,'대림'
);


-- 기본키 이므로 들어가지 않음
insert into dept_second
values(dept_dno_seq.NEXTVAL,'인사팀88','당산8');
SELECT dept_dno_seq.CURRVAL from dual;
-- 프라이머리를 맥스랑 시퀀스랑 섞어쓰면 오류가 난다

-- 4) sequence 삭제
drop sequence sample_seq;
--5)  Data 사전에서 정보 조회
select sequence_name, min_value, max_value,increment_by
from user_sequences;


------------------------------------------------------
----               Table 조작                     ----
------------------------------------------------------
-- 1.Table 생성
create table address
(
    id number(3),
    Name varchar(50),
    addr varchar(100),
    phone varchar(30),
    email varchar(100)
);

insert into address
values (1,'HGDONG','SEOUL','123-4567','gbhong@gmail.com');

---    Homework
-- 문1) address스키마/Data 유지하며     addr_second Table 생성
CREATE table addr_second
as select * from address;

-- 강사님 코드                     -- 안적어도 된다
CREATE table addr_second(id, name, addr, phone, email)
as select * from address;
-- 문2) address스키마 유지하며  Data 복제 하지 않고   addr_seven Table 생성
CREATE table addr_seven
as select *
from address
where 0 = 1
;
-- 문3) address(주소록) 테이블에서 id, name 칼럼만 복사하여 addr_third 테이블을 생성하여라
CREATE table addr_third
as select id, name 
from address;
-- 문4) addr_second 테이블 을 addr_tmp로 이름을 변경 하시요
alter table addr_second rename to addr_tmp;
-- 강사님 코드
RENAME addr_second to addr_tmp;

------------------------------------------------------------------
-----     데이터 사전
-- 1. 사용자와 데이터베이스 자원을 효율적으로 관리하기 위한 다양한 정보를 저장하는 시스템 테이블의 집합
-- 2. 사전 내용의 수정은 오라클 서버만 가능
-- 3. 오라클 서버는 데이타베이스의 구조, 감사, 사용자 권한, 데이터 등의 변경 사항을 반영하기 위해
--    지속적 수정 및 관리
-- 4. 데이타베이스 관리자나 일반 사용자는 읽기 전용 뷰에 의해 데이터 사전의 내용을 조회만 가능
-- 5. 실무에서는 테이블, 칼럼, 뷰 등과 같은 정보를 조회하기 위해 사용

------------------------------------------------------------------

------------------------------------------------------------------
-----     데이터 사전 관리 정보
-- 1.데이터베이스의 물리적 구조와 객체의 논리적 구조
-- 2. 오라클 사용자 이름과 스키마 객체 이름
-- 3. 사용자에게 부여된 접근 권한과 롤
-- 4. 무결성 제약조건에 대한 정보
-- 5. 칼럼별로 지정된 기본값
-- 6. 스키마 객체에 할당된 공간의 크기와 사용 중인 공간의 크기 정보
-- 7. 객체 접근 및 갱신에 대한 감사 정보
-- 8.데이터베이스 이름, 버전, 생성날짜, 시작모드, 인스턴스 이름


------------------------------------------------------------------
-------     데이터 사전 종류
-- 1. USER_ : 객체의 소유자만 접근 가능한 데이터 사전 뷰
-- user_tables는 사용자가 소유한 테이블에 대한 정보를 조회할 수 있는 데이터 사전 뷰.

select table_name
from user_tables;

select *
from user_catalog;

-- 2. ALL_    : 자기 소유 또는 권한을 부여 받은 객체만 접근 가능한 데이터 사전 뷰
select owner, table_name
from all_tables;
-- 시스템에 있는 테이블까지 다 보인다

-- 3. DBA_   : 데이터베이스 관리자만 접근 가능한 데이터 사전 뷰
select owner, table_name
from dba_tables;
-- 처음에 스캇을 만들었을때 dba권한을 줬기때문에 볼 수 있다 
