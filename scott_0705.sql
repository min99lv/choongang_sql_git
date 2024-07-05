--------------------------------------------------------------
--  20240705 ����Work01
-- 1.  PROCEDURE update_empno
-- 2.  parameter -> p_empno, p_job
-- 3.  �ش� empno�� ���õǴ� �������(Like) job�� ����� ������ p_job���� ������Ʈ
-- 4. Update -> emp ����
-- 5.              �Ի����� ��������
-- 6.  �⺻��  EXCEPTION  ó�� 
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
    dbms_output.put_line('��� : ' || emp_row.empno);

    update emp
    set job = 'SALESMAN' , hiredate = sysdate
    where empno = emp_row.empno;
    end loop;
    
    dbms_output.put_line('��������');
    exception
    when others then
    dbms_output.put_line('�����߻�');
end;

---------------------------------------------------------------------------------------
-----    Package
--  ���� ����ϴ� ���α׷��� ������ ���ȭ
--  ���� ���α׷��� ���� ���� �� �� ����
--  ���α׷��� ó�� �帧�� �������� �ʾ� ���� ����� ����
--  ���α׷��� ���� �������� �۾��� ��
--  ���� �̸��� ���ν����� �Լ��� ���� �� ����

----------------------------------------------------------------------------------------
--- 1.Header -->  ���� : ���� (Interface ����)
--     ���� PROCEDURE ���� ����
Create or replace package emp_info as
    PROCEDURE all_emp_info; --- ��� ����� ��� ����
    PROCEDURE all_sal_info;
    -- Ư�� �μ��� ��� ����
    PROCEDURE dept_emp_info (p_deptno in number);
end emp_info;

-- 2. body ���� : ���� ����
create or replace package body emp_info as
-----------------------------------------------------------------
    -- ��� ����� ��� ����(���, �̸�, �Ի���)
    -- 1. CURSOR  : emp_cursor 
    -- 2. FOR  IN
    -- 3. DBMS  -> ���� �� �ٲپ� ���,�̸�,�Ի��� 
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
            dbms_output.put_line('��� :' || emp.empno );
            dbms_output.put_line('�̸�:' || emp.ename );
            dbms_output.put_line('�Ի���:' || emp.hiredate );
        end loop;
        
    exception
    when others then
        DBMS_OUTPUT.PUT_LINE(SQLERRM||'���� �߻� ');
     end all_emp_info;
-----------------------------------------------------------------------
    -- ��� ����� �μ��� �޿� ����
    -- 1. CURSOR  : empdept_cursor 
    -- 2. FOR  IN
    -- 3. DBMS  -> ���� �� �ٲپ� �μ��� ,��ü�޿���� , �ִ�޿��ݾ� , �ּұ޿��ݾ�
   -----------------------------------------------------------------------
    PROCEDURE all_sal_info
    is
        cursor empdept_cursor
        is
        select dname, round(avg(sal),3) ���, max(sal) �ִ�, min(sal) �ּ� 
        from emp e, dept d
        where e.deptno = d.deptno
        group by dname;
        
    begin
    DBMS_OUTPUT.ENABLE;
    for empsal in empdept_cursor
    loop
        dbms_output.put_line('�μ��� :' || empsal.dname );
        dbms_output.put_line('��ü�޿����:' || empsal.��� );
        dbms_output.put_line('�ִ�޿����:' || empsal.�ִ� );
        dbms_output.put_line('�ּұ޿����:' || empsal.�ּ� );
    end loop;
        exception
        when others then
             DBMS_OUTPUT.PUT_LINE(SQLERRM||'���� �߻� ');
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
        dbms_output.put_line('���:' || emp.empno );
        dbms_output.put_line('�̸�:' || emp.ename);
        dbms_output.put_line('�� �� ��:' || emp.hiredate );
    end loop;
    
    exception
    when others then
        DBMS_OUTPUT.PUT_LINE(SQLERRM||'���� �߻� ');
    end dept_emp_info;

end emp_info;


