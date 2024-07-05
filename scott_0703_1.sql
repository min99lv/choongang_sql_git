-- 1.scott에 있는 student TBL에 Read 권한 usertest04 주세요
grant select on scott.student to usertest04;

GRANT SELECT on scott.emp TO usertest02 WITH GRANT OPTION;
-- 강사님 코드 --- GRANT SELECT on scott.emp TO usertest02


-- .현SELECT 권한 부여 개발자 권한 부여 , WITH GRANT OPTION  --> 니가 해라 권한 부여
--with grant option을 주지 않으면 보기만 가능 권한 재부여 불가능 
GRANT SELECT on scott.stud_101 TO usertest02;

-- scott -> usertest02 권한 부여
GRANT SELECT on job3 TO usertest02 WITH GRANT OPTION;

-- 권한 회수 --> 최초로 권한을 준 02사용자에 권한을 회수한다
revoke select on scott.job3 from usertest02;


--- usertable04에서 했는데 되지 않앗음 .. 권한이 없기때문에 스캇에서는 DBA권한이 있기때문에 가능

-- 전용 동의어 사용 전
select * from system.privateTBL;

-- 전용 동의어 사용하기 위해 선언 
create SYNONYM privateTBL for SYSTEM.privatetbl;
-- 전용 동의어 사용 후 
select * from privateTbL;


-- 공용 동의어 시스템에서 만들고 시스템에서 만든 동의어
-- 전용 동의어 시스템에서 만들었지만 스캇에서만 사용가능한 동의어


------------------------------------------------------------------------------------------------------------------
----------------------------------------------PL/SQL------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------
---    PL/SQL의 개념
---   1. Oracle에서 지원하는 프로그래밍 언어의 특성을 수용한 SQL의 확장
---   2. PL/SQL Block내에서 SQL의 DML(데이터 조작어)문과 Query(검색어)문, 
---      그리고 절차형 언어(IF, LOOP) 등을 사용하여 절차적으로 프로그래밍을 가능하게 
---      한 강력한  트랜잭션 언어
---
---   1) 장점 
---      프로그램 개발의 모듈화 : 복잡한 프로그램을 의미있고 잘 정의된 작은 Block 분해
---      변수선언  : 테이블과 칼럼의 데이터 타입을 기반으로 하는 유동적인 변수를 선언
---      에러처리  : Exception 처리 루틴을 사용하여 Oracle 서버 에러를 처리
---      이식성    : Oracle과 PL/SQL을 지원하는어떤 호스트로도 프로그램 이동 가능
---      성능 향상 : 응용 프로그램의 성능을 향상
 
------------------------------------------------------------------------
--- 현장 01
--[예제1] 특정한 수에 세금을 7%로 계산하는 Function: tax을 작성

create or replace Function tax
    (p_num in number) -- 파라메터를 받음
return number  -- 반드시 리턴 변수
IS -- 함수 본체 시작
    v_tax  number; -- 지역변수
begin
    v_tax := p_num*0.07; -- := pl/sql 대입 연산자
    return (v_tax);
end;

select tax(100)
from dual; -- 함수 종료

-- 현장 work02
-- 1) procefure insert_emp 
-- 2) parameter(in) ->  p_empno, p_ename, p_job,p_mgr,p_sal,p_deptno
-- 3) 변수명 v_comm
-- 4) 로직 
--      1) p_job MANAGER -> v_comm(1000)
--      2) p_job else -> v_comm(150)
--      3) emp TBL insert(hiredate) -> 현재일자
create or replace PROCEDURE insert_emp
    (p_empno in emp.empno%type,
    p_ename in emp.ename%type,
    p_job in emp.job%type,
    p_mgr in emp.mgr%type,
    p_sal in emp.sal%type,
    p_deptno in emp.deptno%type)
is
     v_comm emp.comm%type;
begin
    if p_job = 'MANAGER' then v_comm :=1000;
    elsif p_job= 'ELSE' then v_comm := 150;
    end if;
    insert into emp (empno,ename,job,mgr,hiredate,sal,comm,deptno) 
    values (p_empno,p_ename,p_job,p_mgr,sysdate,p_sal,v_comm,p_deptno);
    commit;
end;

-- 함수 반환되는 값 한개,간단한 계산식 처리 / 프로시저 반환 값 여러개, 복잡한 dml문 처리, 무결성 유지를 위해
-- 트랜잭션의 특징 원자성, 일관성, 고립성, 지속성 == 원일고지 






