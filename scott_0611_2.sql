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
(   p_empno IN emp.empno%TYPE,  -- p �Ķ����
    p_ename OUT emp.ename%TYPE, 
    p_sal OUT emp.sal%TYPE)
IS
-- %type �������� ��������
    v_empno emp.empno%TYPE;
BEGIN
 --   DBMS_OUTPUT.ENABLE;
    dbms_output.enable;
    -- %type �������� ��������
    SELECT empno, ename, sal
    -- ���ۿ� �����س��� �뵵
    INTO v_empno, P_ename, p_sal
    FROM emp
    WHERE empno = p_empno;
    DBMS_OUTPUT.PUT_LINE('�����ȣ:'||v_empno || CHR(10)|| CHR(13)|| '�ٹٲ�');
    DBMS_OUTPUT.PUT_LINE('�̸�:' || p_ename);
    DBMS_OUTPUT.PUT_LINE('�޿�:' || P_sal);

END;