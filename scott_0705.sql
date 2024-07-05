--------------------------------------------------------------
--  20240705 현장Work01
-- 1.  PROCEDURE update_empno
-- 2.  parameter -> p_empno, p_job
-- 3.  해당 empno에 관련되는 사원들을(Like) job을 사람의 직업을 p_job으로 업데이트
-- 4. Update -> emp 직업
-- 5.              입사일은 현재일자
-- 6.  기본적  EXCEPTION  처리 
-------------------------------------------------------------

create or replace PROCEDURE update_emp
    (p_empno emp.empno%type,
    p_job in emp.job%type)
is
    Cursor emp_list
    is
        select empno
        from emp
        where empno Like p_empno ||'%';

begin
    DBMS_OUTPUT.ENABLE;
    for emp_row in emp_list loop
    dbms_output.put_line('사원 : ' || emp_row.empno);

    update emp
    set job = 'SALESMAN' , hiredate = sysdate
    where empno = emp_row.empno;
    end loop;
    
    dbms_output.put_line('수정성공');
    exception
    when others then
    dbms_output.put_line('에러발생');
end;

---------------------------------------------------------------------------------------
-----    Package
--  자주 사용하는 프로그램과 로직을 모듈화
--  응용 프로그램을 쉽게 개발 할 수 있음
--  프로그램의 처리 흐름을 노출하지 않아 보안 기능이 좋음
--  프로그램에 대한 유지보수 작업이 편리
--  같은 이름의 프로시저와 함수를 여러 개 생성

----------------------------------------------------------------------------------------
--- 1.Header -->  역할 : 선언 (Interface 역할)
--     여러 PROCEDURE 선언 가능
Create or replace package emp_info as
    PROCEDURE all_emp_info; --- 모든 사원의 사원 정보
    PROCEDURE all_sal_info;
    -- 특정 부서의 사원 정보
    PROCEDURE dept_emp_info (p_deptno in number);
end emp_info;

-- 2. body 역할 : 실제 구현
create or replace package body emp_info as
-----------------------------------------------------------------
    -- 모든 사원의 사원 정보(사번, 이름, 입사일)
    -- 1. CURSOR  : emp_cursor 
    -- 2. FOR  IN
    -- 3. DBMS  -> 각각 줄 바꾸어 사번,이름,입사일 
    -----------------------------------------------------------------
     PROCEDURE all_emp_info
     is
        cursor emp_cursor
        is
            select empno, ename, to_char(hiredate, 'yyyy/mm/dd') hiredate
            from emp
            order by hiredate;
     begin
        DBMS_OUTPUT.ENABLE;
        for emp in emp_cursor
        loop
            dbms_output.put_line('사번 :' || emp.empno );
            dbms_output.put_line('이름:' || emp.ename );
            dbms_output.put_line('입사일:' || emp.hiredate );
        end loop;
        
    exception
    when others then
        DBMS_OUTPUT.PUT_LINE(SQLERRM||'에러 발생 ');
     end all_emp_info;
-----------------------------------------------------------------------
    -- 모든 사원의 부서별 급여 정보
    -- 1. CURSOR  : empdept_cursor 
    -- 2. FOR  IN
    -- 3. DBMS  -> 각각 줄 바꾸어 부서명 ,전체급여평균 , 최대급여금액 , 최소급여금액
   -----------------------------------------------------------------------
    PROCEDURE all_sal_info
    is
        cursor empdept_cursor
        is
        select dname, round(avg(sal),3) 평균, max(sal) 최대, min(sal) 최소 
        from emp e, dept d
        where e.deptno = d.deptno
        group by dname;
        
    begin
    DBMS_OUTPUT.ENABLE;
    for empsal in empdept_cursor
    loop
        dbms_output.put_line('부서명 :' || empsal.dname );
        dbms_output.put_line('전체급여평균:' || empsal.평균 );
        dbms_output.put_line('최대급여평균:' || empsal.최대 );
        dbms_output.put_line('최소급여평균:' || empsal.최소 );
    end loop;
        exception
        when others then
             DBMS_OUTPUT.PUT_LINE(SQLERRM||'에러 발생 ');
    end all_sal_info;
    
    PROCEDURE dept_emp_info
    (p_deptno in number)
    is
        cursor deptno_cursor
        is
            select empno, ename, hiredate
            from emp e, dept d
            where e.deptno = d.deptno;
        
    begin
    for emp in deptno_cursor 
    loop 
        dbms_output.put_line('사번:' || emp.empno );
        dbms_output.put_line('이름:' || emp.ename);
        dbms_output.put_line('입 사 일:' || emp.hiredate );
    end loop;
    
    exception
    when others then
        DBMS_OUTPUT.PUT_LINE(SQLERRM||'에러 발생 ');
    end dept_emp_info;

end emp_info;


