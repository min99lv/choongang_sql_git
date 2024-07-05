create or replace FUNCTION emp_tax3
-------------------------------------------------------------------------------------------------
--  EMP ���̺��� ����� �Է¹޾� �ش� ����� �޿��� ���� ������ ����.
-- �޿��� 2000 �̸��̸� �޿��� 6%, 
-- �޿��� 3000 �̸��̸� 8%, 
-- 5000 �̸��̸� 10%, 
-- �� �̻��� 15%�� ����
--- FUNCTION  emp_tax3
-- 1) Parameter : ��� p_empno
--      ����     :   v_sal(�޿�)
--                     v_pct(����)
-- 2) ����� ������ �޿��� ����
-- 3) �޿��� ������ ���� ��� 
-- 4) ��� �� �� Return   number
------------------------------------------------------------------------------------------------
    (p_empno in emp.empno%type)
return number
is
    v_sal emp.sal%type;
    v_pct  number(5,2); -- �ִ� �Ҽ������� 2�ڸ����� �� 5�ڸ� ���ڸ� ������ �� �ִ� ������ Ÿ��
begin                       -- �����κ��� ���ڸ�, �Ҽ��κ� 2�ڸ�
-- ����� ������ �޿��� ����
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

-- �Լ��� �ο캰�� ����ȴ�
select ename, sal, emp_tax3(empno) emp_rate
from emp;


-----------------------------------------------------
--  Procedure up_emp ���� ���
-- SQL> EXECUTE up_emp(1200);  -- ��� 
-- ���       : �޿� �λ� ����
--               ���۹���
--   ����     :   v_job(����)
--                  v_up����)

-- ���� 1) job = SALE����         v_up : 10
--           IF              v_job LIKE 'SALE%' THEN
--     2)            MAN              v_up : 7  
--     3)                                v_up : 5
--   job�� ���� �޿� �λ��� ����  sal = sal+sal*v_up/100
-- Ȯ�� : DB -> TBL
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
-- �����ȣ : 5555
-- ����̸� : 55
-- �� �� �� : 81/12/03
-- ������ ���� ����
--  1. Parameter : ��� �Է�
--  2. ��� �̿��� �����ȣ ,����̸� , �� �� �� ���
--  3. ��� �ش��ϴ� ������ ���� 
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
    DBMS_OUTPUT.PUT_LINE('�����ȣ :' || p_empno);
    DBMS_OUTPUT.PUT_LINE('����̸� :' || v_emp.ename);
    DBMS_OUTPUT.PUT_LINE('�� �� �� :' || v_emp.hiredate);
    delete 
    from emp
    where empno = p_empno;
    DBMS_OUTPUT.PUT_LINE('������ ���� ����');
end;
------------------------------------------------------------------
-- ���� ��ũ 01
-- �ൿ���� : �μ���ȣ �Է� �ش� emp ����  PROCEDURE 
-- SQL> EXECUTE DeptEmpSearch(40);
--  ��ȸȭ�� :    ���    : 5555
--              �̸�    : ȫ�浿
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
    where deptno = p_deptno; -- ����ũ �̰ų� pk�϶��� �̷��� ��� 
    DBMS_OUTPUT.PUT_LINE('��� : ' || V_EMPNO);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || V_ename);
end DeptEmpSearch1;




--2�� %rowtype�� �̿��ϴ� ���
create or replace PROCEDURE DeptEmpSearch2
(p_deptno in emp.deptno%type)
is
--    v_ename emp.ename%type;
--    v_empno emp.empno%type;
    v_emp emp%rowtype; -- ������
begin
    DBMS_OUTPUT.ENABLE;
    select *
    into v_emp --������
    from emp
    where deptno = p_deptno;
    DBMS_OUTPUT.PUT_LINE('��� : ' || V_EMP.empno); -- ������
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || V_emp.ename); -- ������
end DeptEmpSearch2;


-- 3�� ����ó�� 

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
    DBMS_OUTPUT.PUT_LINE('��� : ' || V_EMP.empno);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || V_emp.ename);
    -- Multi Row Error --> ���� ������ �䱸�� �ͺ��� ���� ���� ���� ����
    EXCEPTION
    when others then -- ��ģ��
    DBMS_OUTPUT.PUT_LINE('�����ڵ� 1 : ' || to_char(sqlcode));
    DBMS_OUTPUT.PUT_LINE('�����ڵ� 2 : ' || sqlcode);
    DBMS_OUTPUT.PUT_LINE('���� �޽��� : ' || sqlerrm);
end DeptEmpSearch3;


--------------------------------------------------------------------------------
----  ***    cursor    ***
--- 1.���� : Oracle Server�� SQL���� �����ϰ� ó���� ������ �����ϱ� ���� 
--        "Private SQL Area" �̶�� �ϴ� �۾������� �̿�
--       �� ������ �̸��� �ο��ϰ� ����� ������ ó���� �� �ְ� ���ִµ� �̸� CURSOR
-- 2. ����  :    Implicit(��������) CURSOR -> DML���� SELECT���� ���� ���������� ���� 
--                 Explicit(�������) CURSOR -> ����ڰ� �����ϰ� �̸��� �����ؼ� ��� 
-- 3.attribute
--   1) SQL%ROWCOUNT : ���� �ֱ��� SQL���� ���� ó���� Row ��
--   2) SQL%FOUND    : ���� �ֱ��� SQL���� ���� ó���� Row�� ������ �� ���̻��̸� True
--   3) SQL%NOTFOUND : ���� �ֱ��� SQL���� ���� ó���� Row�� ������ ������True
-- 4. 4�ܰ� ** 
--     1) DECLARE �ܰ� : Ŀ���� �̸��� �ο��ϰ� Ŀ�������� ������ SELECT���� ���������ν� CURSOR�� ����
--     2) OPEN �ܰ� : OPEN���� �����Ǵ� ������ �����ϰ�, SELECT���� ����
--     3) FETCH �ܰ� : CURSOR�κ��� Pointer�� �����ϴ� Record�� ���� ������ ����
--     4) CLOSE �ܰ� : Record�� Active Set�� �ݾ� �ְ�, �ٽ� ���ο� Active Set������� OPEN�� �� �ְ� ����
--------------------------------------------------------------------------------
---------------------------------------------------------
-- EXECUTE ���� �̿��� �Լ��� �����մϴ�.
-- SQL>EXECUTE show_emp3(7900);
---------------------------------------------------------
create or replace PROCEDURE show_emp3
(p_empno in emp.empno%type)
is  
-- is�� ��� ���̿� ���� Ŀ������ ���� ��ü�� ���⶧���� �� ���̿� ����
    -- 1) DECLARE �ܰ�
    cursor emp_cursor 
    is
    select ename, job, sal
    from emp
    where empno like p_empno ||'%'; -- ����ũ�� �����̸Ӹ�Ű�� �ƴϸ� Ŀ�������� ��ƶ�

    v_ename emp.ename%type;
    v_sal emp.sal%type;
    v_job emp.job%type;

BEGIN
   DBMS_OUTPUT.ENABLE;
    -- 2) OPEN �ܰ�
    OPEN emp_cursor;
        DBMS_OUTPUT.PUT_LINE('�̸� '||'����'||'�޿�');
        DBMS_OUTPUT.PUT_LINE('------------------------');
    LOOP
        -- 3) FETCH �ܰ� --> �ϳ��� ����
        FETCH emp_cursor into v_ename, v_job, v_sal;
        EXIT WHEN emp_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_ename || ' ' || v_job ||' ' || v_sal);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(emp_cursor%rowcount||'���� �� ����');
    -- 4) CLOSE �ܰ�
    CLOSE emp_cursor;
END;
-----Ŀ������ �����غ�
    select ename, job, sal
    from emp
    where empno like 3||'%';

-------------------------------------------------------------------------------------
-----------------------------------------------------
-- Fetch ��    ***
-- SQL> EXECUTE  Cur_sal_Hap (deptno);
-- CURSOR �� �̿� ���� 
-- �μ���ŭ �ݺ� 
-- 	�μ��� : �λ���
-- 	�ο��� : 5
-- 	�޿��� : 5000
-- Ŀ���� : dept_sum 
-----------------------------------------------------
create or replace PROCEDURE Cur_sal_Hap
    (p_deptno in emp.deptno%type)
IS
    Cursor dept_sum 
    is
        -- �μ����� ī���Ͱ� �հ踦 �����´�.
        select dname, count(*) cnt, sum(sal) sumSal 
        from dept d, emp e
        where e.deptno =  d.deptno
        and  e.deptno LIKE p_deptno||'%'
        -- and e.deptno LIKE p_deptno||'%'�� 
        -- �Է� �Ķ���� p_deptno�� �����ϴ� ��� �μ��� �����մϴ�.
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
        DBMS_OUTPUT.PUT_LINE('�μ���:'|| vdname );
        DBMS_OUTPUT.PUT_LINE('�ο���:'|| vcnt );
        DBMS_OUTPUT.PUT_LINE('�޿���:'|| vsumSal );
END LOOP;
    CLOSE dept_sum;
END;

--------------------------------------------------------------------------------------------------------
-- FOR���� ����ϸ� Ŀ���� OPEN, FETCH, CLOSE�� �ڵ� �߻��ϹǷ� 
-- ���� ����� �ʿ䰡 ����, ���ڵ� �̸��� �ڵ�
-- ����ǹǷ� ���� ������ �ʿ䰡 ����. for emp_list -> fetch
--------------------------------------------------------------------------------------------------------
create or replace PROCEDURE ForCursor_sal_Hap
is
-- 1. Ŀ�� ����
    Cursor dept_sum 
    is
        select b.dname, Count(a.empno) cnt, sum(a.sal) salary
        From emp a, dept b
        where a.deptno = b.deptno
        group by b.dname;
begin
    DBMS_OUTPUT.enable;
    -- Ŀ���� for������ ���� --> open, fetch,close�� �ڵ� �߻�
    -- emp_list�� ����ϸ� fetch�� �����Ŵ �ѷο쾿....!!!!!! �������� ����
    for emp_list in dept_sum loop
        DBMS_OUTPUT.PUT_LINE('�μ���:'|| emp_list.dname );
        DBMS_OUTPUT.PUT_LINE('�ο���:'|| emp_list.cnt );
        DBMS_OUTPUT.PUT_LINE('�޿���:'|| emp_list.salary );
    end loop;
    Exception
    when others then
        DBMS_OUTPUT.PUT_LINE(sqlerrm || '�����߻�' );
End;


----------------------------------------------------------------------------------
--����Ŭ PL/SQL�� ���� �Ͼ�� ��� ���ܸ� �̸� ������ ��������, 
--�̷��� ���ܴ� �����ڰ� ���� ������ �ʿ䰡 ����.
--�̸� ���ǵ� ������ ����
-- NO_DATA_FOUND : SELECT���� �ƹ��� ������ ���� ��ȯ���� ���� ��
-- DUP_VAL_ON_INDEX : UNIQUE ������ ���� �÷��� �ߺ��Ǵ� ������ INSERT �� ��
-- ZERO_DIVIDE : 0���� ���� ��
-- INVALID_CURSOR : �߸��� Ŀ�� ����
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
    
        DBMS_OUTPUT.PUT_LINE('���:'|| v_emp.empno );
        DBMS_OUTPUT.PUT_LINE('�̸�:'||  v_emp.ename );
        DBMS_OUTPUT.PUT_LINE('�μ���ȣ:'|| v_emp.deptno );
        
    exception 
        when DUP_VAL_ON_INDEX then
            dbms_output.put_line('�ߺ� �����Ͱ� ���� �մϴ�');
            dbms_output.put_line(' dup_val_on_index ���� �߻�');
        when TOO_MANY_ROWS then
            dbms_output.put_line('too_many_rows���� �߻�');
        when NO_DATA_FOUND then
            dbms_output.put_line('NO_DATA_FOUND ���� �߻�');
        when others then -- ��ģ��
            dbms_output.put_line('��Ÿ ���� �߻�');
end;
/
-----------------------------------------------------------
----   Procedure :  in_emp
----   Action    : emp Insert
----   1. Error ����
---      1) DUP_VAL_ON_INDEX  :  PreDefined --> Oracle ���� Error
---      2) User Defind Error :  lowsal_err (�����޿� ->1500)   : �����ڰ� ���� ���� 
-----------------------------------------------------------
create or REPLACE PROCEDURE in_emp
    ( 
    p_name in emp.ename%type,         --1) DUP_VAL_ON_INDEX
      p_sal in emp.sal%type,                 -- 2) User Defind Error :  lowsal_err (�����޿� ->1500)  
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
    
    if p_sal >= 1500 then -- sal�� 1500���� ũ�� if�� ����
        insert  into emp(empno, ename, sal, job, deptno, hiredate)
        values(v_empno,p_name,p_sal,p_job,p_deptno,sysdate);
    else -- ������ ������ �߻���Ų��
        RAISE lowsal_err; 
    end if;
    
    exception
        when DUP_VAL_ON_INDEX then -- �ߺ� ������ ���� ����
            dbms_output.put_line('�ߺ� ������ ename �����մϴ�');
            dbms_output.put_line('DUP_VAL_ON_INDEX ���� �߻�');
        when lowsal_err then -- sal <1500 �� �� �߻��ϴ� ����
            dbms_output.put_line('Error!!! ������ �޿��� �ʹ� �����ϴ� 1500�̻����� �ٽ� �Է����ּ���');
end in_emp;
/
-----------------------------------------------------------
----   Procedure :  in_emp3
----   Action    : emp Insert
----   1. Error ����
---      1) DUP_VAL_ON_INDEX  :  PreDefined --> Oracle ���� Error
---      2) User Defind Error :  highsal_err (�ְ�޿� ->9000 �̻� ���� �߻�)  
---   2. ��Ÿ����
---      1) emp.ename�� Unique ���������� �ɷ� �ִٰ� ���� 
---      2) parameter : p_name, p_sal, p_job
---      3) PK(empno) : Max ��ȣ �Է� 
---      3) hiredate     : �ý��� ��¥ �Է� 
---      4) emp(empno,ename,sal,job,hiredate)  --> 5 Column�Է��Ѵ� ���� 
---      5) DUP_VAL_ON_INDEX --> �ߺ� ������ ename ���� �մϴ� / DUP_VAL_ON_INDEX ���� �߻�
 --          highsal_err  -->ERROR!!!-������ �޿��� �ʹ� �����ϴ�. 9000�������� �ٽ� �Է��ϼ���

-----------------------------------------------------------
Create OR Replace PROCEDURE in_emp3
 (p_name    IN    emp.ename%TYPE ,   -- 1) DUP_VAL_ON_INDEX
  p_sal       IN    emp.sal%TYPE ,        -- 2) ������ Defind Error :  highsal_err (�����޿� ->9000)  
  p_job       IN    emp.job%TYPE
  )
IS
  v_empno       emp.empno%TYPE ;
  -- ������ Defind Error
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
            DBMS_OUTPUT.PUT_LINE('�ߺ� ������ ename ���� �մϴ�.');
            DBMS_OUTPUT.PUT_LINE('DUP_VAL_ON_INDEX ���� �߻�');
        when highsal_err then -- sal <1500 �� �� �߻��ϴ� ����
            DBMS_OUTPUT.PUT_LINE ('ERROR!!!-������ �޿��� �ʹ� �����ϴ�. 9000�������� �ٽ� �Է��ϼ���.') ;
end in_emp3;

/


    