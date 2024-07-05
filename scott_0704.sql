create or replace FUNCTION emp_tax3
-------------------------------------------------------------------------------------------------
--  EMP 테이블에서 사번을 입력받아 해당 사원의 급여에 따른 세금을 구함.
-- 급여가 2000 미만이면 급여의 6%, 
-- 급여가 3000 미만이면 8%, 
-- 5000 미만이면 10%, 
-- 그 이상은 15%로 세금
--- FUNCTION  emp_tax3
-- 1) Parameter : 사번 p_empno
--      변수     :   v_sal(급여)
--                     v_pct(세율)
-- 2) 사번을 가지고 급여를 구함
-- 3) 급여를 가지고 세율 계산 
-- 4) 계산 된 값 Return   number
------------------------------------------------------------------------------------------------
    (p_empno in emp.empno%type)
return number
is
    v_sal emp.sal%type;
    v_pct  number(5,2); -- 최대 소수점이하 2자리까지 총 5자리 숫자를 저장할 수 있는 데이터 타입
begin                       -- 정수부분이 세자리, 소수부분 2자리
-- 사번을 가지고 급여를 구함
select sal

into v_sal
from emp
where empno = p_empno;
    if v_sal < 2000 then 
        v_pct := v_sal * 0.06;
    elsif v_sal < 3000 then
        v_pct := v_sal * 0.08;
    elsif v_sal <5000 then 
        v_pct := v_sal * 0.10;
    else 
        v_pct := v_sal * 0.15;
    end if;
    return (v_pct);

end emp_tax3;
/

-- 함수가 로우별로 실행된다
select ename, sal, emp_tax3(empno) emp_rate
from emp;


-----------------------------------------------------
--  Procedure up_emp 실행 결과
-- SQL> EXECUTE up_emp(1200);  -- 사번 
-- 결과       : 급여 인상 저장
--               시작문자
--   변수     :   v_job(업무)
--                  v_up세율)

-- 조건 1) job = SALE포함         v_up : 10
--           IF              v_job LIKE 'SALE%' THEN
--     2)            MAN              v_up : 7  
--     3)                                v_up : 5
--   job에 따른 급여 인상을 수행  sal = sal+sal*v_up/100
-- 확인 : DB -> TBL
-----------------------------------------------------
create or replace PROCEDURE up_emp
(p_empno in emp.empno%type)
is
    v_job emp.job%type;
    v_up number(3);
begin
    select job
    into v_job
    from emp
    where empno = p_empno;
    
    if v_job like 'SALE%' then  
        v_up := 10;
    elsif v_job like 'MAN%' then
        v_up := 7;
    else 
        v_up := 5;
    end if;
    
    update emp 
    set sal = (sal+(sal*(v_up/100)))
    where empno = p_empno;
end up_emp;
/
EXECUTE up_emp(3000);
----------------------------------------------------------
-- hw01
-- PROCEDURE Delete_emp
-- SQL> EXECUTE Delete_emp(5555);
-- 사원번호 : 5555
-- 사원이름 : 55
-- 입 사 일 : 81/12/03
-- 데이터 삭제 성공
--  1. Parameter : 사번 입력
--  2. 사번 이용해 사원번호 ,사원이름 , 입 사 일 출력
--  3. 사번 해당하는 데이터 삭제 
----------------------------------------------------------
create or replace PROCEDURE Delete_emp
(p_empno emp.empno%type)
is
    v_emp emp%rowtype;
begin
    dbms_output.enable;
    select *
    into v_emp
    from emp
    where empno = p_empno;
    DBMS_OUTPUT.PUT_LINE('사원번호 :' || p_empno);
    DBMS_OUTPUT.PUT_LINE('사원이름 :' || v_emp.ename);
    DBMS_OUTPUT.PUT_LINE('입 사 일 :' || v_emp.hiredate);
    delete 
    from emp
    where empno = p_empno;
    DBMS_OUTPUT.PUT_LINE('데이터 삭제 성공');
end;
------------------------------------------------------------------
-- 현장 워크 01
-- 행동강령 : 부서번호 입력 해당 emp 정보  PROCEDURE 
-- SQL> EXECUTE DeptEmpSearch(40);
--  조회화면 :    사번    : 5555
--              이름    : 홍길동
------------------------------------------------------------------
create or replace PROCEDURE DeptEmpSearch1
(p_deptno in emp.deptno%type)
is
    v_ename emp.ename%type;
    v_empno emp.empno%type;
begin
    DBMS_OUTPUT.ENABLE;
    select ename, empno
    into v_ename, v_empno 
    from emp
    where deptno = p_deptno; -- 유니크 이거나 pk일때만 이렇게 사용 
    DBMS_OUTPUT.PUT_LINE('사번 : ' || V_EMPNO);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || V_ename);
end DeptEmpSearch1;




--2번 %rowtype을 이용하는 방법
create or replace PROCEDURE DeptEmpSearch2
(p_deptno in emp.deptno%type)
is
--    v_ename emp.ename%type;
--    v_empno emp.empno%type;
    v_emp emp%rowtype; -- 차이점
begin
    DBMS_OUTPUT.ENABLE;
    select *
    into v_emp --차이점
    from emp
    where deptno = p_deptno;
    DBMS_OUTPUT.PUT_LINE('사번 : ' || V_EMP.empno); -- 차이점
    DBMS_OUTPUT.PUT_LINE('이름 : ' || V_emp.ename); -- 차이점
end DeptEmpSearch2;


-- 3번 예외처리 

create or replace PROCEDURE DeptEmpSearch3
(p_deptno in emp.deptno%type)
is
--    v_ename emp.ename%type;
--    v_empno emp.empno%type;
    v_emp emp%rowtype;
begin
    DBMS_OUTPUT.ENABLE;
    select *
    into v_emp
    from emp
    where deptno = p_deptno;
    DBMS_OUTPUT.PUT_LINE('사번 : ' || V_EMP.empno);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || V_emp.ename);
    -- Multi Row Error --> 실제 인출은 요구된 것보다 많은 수의 행을 추출
    EXCEPTION
    when others then -- 퉁친다
    DBMS_OUTPUT.PUT_LINE('에러코드 1 : ' || to_char(sqlcode));
    DBMS_OUTPUT.PUT_LINE('에러코드 2 : ' || sqlcode);
    DBMS_OUTPUT.PUT_LINE('에러 메시지 : ' || sqlerrm);
end DeptEmpSearch3;


--------------------------------------------------------------------------------
----  ***    cursor    ***
--- 1.정의 : Oracle Server는 SQL문을 실행하고 처리한 정보를 저장하기 위해 
--        "Private SQL Area" 이라고 하는 작업영역을 이용
--       이 영역에 이름을 부여하고 저장된 정보를 처리할 수 있게 해주는데 이를 CURSOR
-- 2. 종류  :    Implicit(묵시적인) CURSOR -> DML문과 SELECT문에 의해 내부적으로 선언 
--                 Explicit(명시적인) CURSOR -> 사용자가 선언하고 이름을 정의해서 사용 
-- 3.attribute
--   1) SQL%ROWCOUNT : 가장 최근의 SQL문에 의해 처리된 Row 수
--   2) SQL%FOUND    : 가장 최근의 SQL문에 의해 처리된 Row의 개수가 한 개이상이면 True
--   3) SQL%NOTFOUND : 가장 최근의 SQL문에 의해 처리된 Row의 개수가 없으면True
-- 4. 4단계 ** 
--     1) DECLARE 단계 : 커서에 이름을 부여하고 커서내에서 수행할 SELECT문을 정의함으로써 CURSOR를 선언
--     2) OPEN 단계 : OPEN문은 참조되는 변수를 연결하고, SELECT문을 실행
--     3) FETCH 단계 : CURSOR로부터 Pointer가 존재하는 Record의 값을 변수에 전달
--     4) CLOSE 단계 : Record의 Active Set을 닫아 주고, 다시 새로운 Active Set을만들어 OPEN할 수 있게 해줌
--------------------------------------------------------------------------------
---------------------------------------------------------
-- EXECUTE 문을 이용해 함수를 실행합니다.
-- SQL>EXECUTE show_emp3(7900);
---------------------------------------------------------
create or replace PROCEDURE show_emp3
(p_empno in emp.empno%type)
is  
-- is와 비긴 사이에 정의 커서문도 변수 객체로 보기때문에 이 사이에 선언
    -- 1) DECLARE 단계
    cursor emp_cursor 
    is
    select ename, job, sal
    from emp
    where empno like p_empno ||'%'; -- 유니크나 프라이머리키가 아니면 커서문으로 잡아라

    v_ename emp.ename%type;
    v_sal emp.sal%type;
    v_job emp.job%type;

BEGIN
   DBMS_OUTPUT.ENABLE;
    -- 2) OPEN 단계
    OPEN emp_cursor;
        DBMS_OUTPUT.PUT_LINE('이름 '||'업무'||'급여');
        DBMS_OUTPUT.PUT_LINE('------------------------');
    LOOP
        -- 3) FETCH 단계 --> 하나씩 꺼냄
        FETCH emp_cursor into v_ename, v_job, v_sal;
        EXIT WHEN emp_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_ename || ' ' || v_job ||' ' || v_sal);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(emp_cursor%rowcount||'개의 행 선택');
    -- 4) CLOSE 단계
    CLOSE emp_cursor;
END;
-----커서문만 실행해봄
    select ename, job, sal
    from emp
    where empno like 3||'%';

-------------------------------------------------------------------------------------
-----------------------------------------------------
-- Fetch 문    ***
-- SQL> EXECUTE  Cur_sal_Hap (deptno);
-- CURSOR 문 이용 구현 
-- 부서만큼 반복 
-- 	부서명 : 인사팀
-- 	인원수 : 5
-- 	급여합 : 5000
-- 커서명 : dept_sum 
-----------------------------------------------------
create or replace PROCEDURE Cur_sal_Hap
    (p_deptno in emp.deptno%type)
IS
    Cursor dept_sum 
    is
        -- 부서별로 카운터가 합계를 가져온다.
        select dname, count(*) cnt, sum(sal) sumSal 
        from dept d, emp e
        where e.deptno =  d.deptno
        and  e.deptno LIKE p_deptno||'%'
        -- and e.deptno LIKE p_deptno||'%'는 
        -- 입력 파라미터 p_deptno로 시작하는 모든 부서를 선택합니다.
        group by dname;
        
    vdname dept.dname%type;
    vcnt number;
    vsumSal number;
begin
    dbms_output.enable;
    open dept_sum;
LOOP 
    fetch dept_sum into vdname, vcnt, vsumSal;
    exit when dept_sum%notfound;
        DBMS_OUTPUT.PUT_LINE('부서명:'|| vdname );
        DBMS_OUTPUT.PUT_LINE('인원수:'|| vcnt );
        DBMS_OUTPUT.PUT_LINE('급여합:'|| vsumSal );
END LOOP;
    CLOSE dept_sum;
END;

--------------------------------------------------------------------------------------------------------
-- FOR문을 사용하면 커서의 OPEN, FETCH, CLOSE가 자동 발생하므로 
-- 따로 기술할 필요가 없고, 레코드 이름도 자동
-- 선언되므로 따로 선언할 필요가 없다. for emp_list -> fetch
--------------------------------------------------------------------------------------------------------
create or replace PROCEDURE ForCursor_sal_Hap
is
-- 1. 커서 선언
    Cursor dept_sum 
    is
        select b.dname, Count(a.empno) cnt, sum(a.sal) salary
        From emp a, dept b
        where a.deptno = b.deptno
        group by b.dname;
begin
    DBMS_OUTPUT.enable;
    -- 커서를 for문에서 실행 --> open, fetch,close가 자동 발생
    -- emp_list를 사용하면 fetch를 실행시킴 한로우씩....!!!!!! 가져오는 것임
    for emp_list in dept_sum loop
        DBMS_OUTPUT.PUT_LINE('부서명:'|| emp_list.dname );
        DBMS_OUTPUT.PUT_LINE('인원수:'|| emp_list.cnt );
        DBMS_OUTPUT.PUT_LINE('급여합:'|| emp_list.salary );
    end loop;
    Exception
    when others then
        DBMS_OUTPUT.PUT_LINE(sqlerrm || '에러발생' );
End;


----------------------------------------------------------------------------------
--오라클 PL/SQL은 자주 일어나는 몇가지 예외를 미리 정의해 놓았으며, 
--이러한 예외는 개발자가 따로 선언할 필요가 없다.
--미리 정의된 예외의 종류
-- NO_DATA_FOUND : SELECT문이 아무런 데이터 행을 반환하지 못할 때
-- DUP_VAL_ON_INDEX : UNIQUE 제약을 갖는 컬럼에 중복되는 데이터 INSERT 될 때
-- ZERO_DIVIDE : 0으로 나눌 때
-- INVALID_CURSOR : 잘못된 커서 연산
--------------------------------------------------------------------------------
create or replace  PROCEDURE preException
(v_deptno in emp.deptno%type)
is
    v_emp emp%rowtype;
begin
    dbms_output.enable;
    
    select empno, ename, deptno
    into v_emp.empno, v_emp.ename, v_emp.deptno
    from emp
    where deptno = v_deptno;
    
        DBMS_OUTPUT.PUT_LINE('사번:'|| v_emp.empno );
        DBMS_OUTPUT.PUT_LINE('이름:'||  v_emp.ename );
        DBMS_OUTPUT.PUT_LINE('부서번호:'|| v_emp.deptno );
        
    exception 
        when DUP_VAL_ON_INDEX then
            dbms_output.put_line('중복 데이터가 존재 합니다');
            dbms_output.put_line(' dup_val_on_index 에러 발생');
        when TOO_MANY_ROWS then
            dbms_output.put_line('too_many_rows에러 발생');
        when NO_DATA_FOUND then
            dbms_output.put_line('NO_DATA_FOUND 에러 발생');
        when others then -- 퉁친것
            dbms_output.put_line('기타 에러 발생');
end;
/
-----------------------------------------------------------
----   Procedure :  in_emp
----   Action    : emp Insert
----   1. Error 유형
---      1) DUP_VAL_ON_INDEX  :  PreDefined --> Oracle 선언 Error
---      2) User Defind Error :  lowsal_err (최저급여 ->1500)   : 개발자가 만든 에러 
-----------------------------------------------------------
create or REPLACE PROCEDURE in_emp
    ( 
    p_name in emp.ename%type,         --1) DUP_VAL_ON_INDEX
      p_sal in emp.sal%type,                 -- 2) User Defind Error :  lowsal_err (최저급여 ->1500)  
      p_job in emp.job%type,
      p_deptno in emp.deptno%type)
is
    v_empno emp.empno%type;
    lowsal_err EXCEPTION;
begin
    dbms_output.enable;
    select max(empno)+1
    into v_empno
    from emp;
    
    if p_sal >= 1500 then -- sal이 1500보다 크면 if문 실행
        insert  into emp(empno, ename, sal, job, deptno, hiredate)
        values(v_empno,p_name,p_sal,p_job,p_deptno,sysdate);
    else -- 작으면 에러를 발생시킨다
        RAISE lowsal_err; 
    end if;
    
    exception
        when DUP_VAL_ON_INDEX then -- 중복 데이터 존재 오류
            dbms_output.put_line('중복 데이터 ename 존재합니다');
            dbms_output.put_line('DUP_VAL_ON_INDEX 에러 발생');
        when lowsal_err then -- sal <1500 일 때 발생하는 오류
            dbms_output.put_line('Error!!! 지정한 급여가 너무 적습니다 1500이상으로 다시 입력해주세요');
end in_emp;
/
-----------------------------------------------------------
----   Procedure :  in_emp3
----   Action    : emp Insert
----   1. Error 유형
---      1) DUP_VAL_ON_INDEX  :  PreDefined --> Oracle 선언 Error
---      2) User Defind Error :  highsal_err (최고급여 ->9000 이상 오류 발생)  
---   2. 기타조건
---      1) emp.ename은 Unique 제약조건이 걸려 있다고 가정 
---      2) parameter : p_name, p_sal, p_job
---      3) PK(empno) : Max 번호 입력 
---      3) hiredate     : 시스템 날짜 입력 
---      4) emp(empno,ename,sal,job,hiredate)  --> 5 Column입력한다 가정 
---      5) DUP_VAL_ON_INDEX --> 중복 데이터 ename 존재 합니다 / DUP_VAL_ON_INDEX 에러 발생
 --          highsal_err  -->ERROR!!!-지정한 급여가 너무 많습니다. 9000이하으로 다시 입력하세요

-----------------------------------------------------------
Create OR Replace PROCEDURE in_emp3
 (p_name    IN    emp.ename%TYPE ,   -- 1) DUP_VAL_ON_INDEX
  p_sal       IN    emp.sal%TYPE ,        -- 2) 개발자 Defind Error :  highsal_err (최저급여 ->9000)  
  p_job       IN    emp.job%TYPE
  )
IS
  v_empno       emp.empno%TYPE ;
  -- 개발자 Defind Error
  highsal_err    EXCEPTION;
BEGIN
   DBMS_OUTPUT.ENABLE;
   SELECT MAX(empno)+1
   INTO   v_empno 
   FROM   emp ;
    
   IF  p_sal  <=  9000 THEN
      INSERT INTO  emp(empno,ename,sal,job,hiredate)
      VALUES(v_empno,p_name, p_sal,p_job,SYSDATE) ;
  ELSE
      RAISE  highsal_err ;
  END IF ;
    
    EXCEPTION
       WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('중복 데이터 ename 존재 합니다.');
            DBMS_OUTPUT.PUT_LINE('DUP_VAL_ON_INDEX 에러 발생');
        when highsal_err then -- sal <1500 일 때 발생하는 오류
            DBMS_OUTPUT.PUT_LINE ('ERROR!!!-지정한 급여가 너무 많습니다. 9000이하으로 다시 입력하세요.') ;
end in_emp3;

/


    