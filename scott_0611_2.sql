CREATE OR REPLACE Procedure Dept_Insert
(   p_deptno in dept.deptno%type,
    p_dname in dept.dname% type,
    p_loc in dept.loc%Type
)
is
begin
    INSERT INTO DEPT VALUES(p_deptno, p_dname,p_loc);
End;

CREATE OR REPLACE PROCEDURE Emp_info2
(   p_empno IN emp.empno%TYPE,  -- p 파라미터
    p_ename OUT emp.ename%TYPE, 
    p_sal OUT emp.sal%TYPE)
IS
-- %type 데이터형 변수선언
    v_empno emp.empno%TYPE;
BEGIN
 --   DBMS_OUTPUT.ENABLE;
    dbms_output.enable;
    -- %type 데이터형 변수실행
    SELECT empno, ename, sal
    -- 버퍼에 저장해놓는 용도
    INTO v_empno, P_ename, p_sal
    FROM emp
    WHERE empno = p_empno;
    DBMS_OUTPUT.PUT_LINE('사원번호:'||v_empno || CHR(10)|| CHR(13)|| '줄바뀜');
    DBMS_OUTPUT.PUT_LINE('이름:' || p_ename);
    DBMS_OUTPUT.PUT_LINE('급여:' || P_sal);

END;