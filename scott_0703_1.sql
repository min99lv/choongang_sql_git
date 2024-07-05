-- 1.scott�� �ִ� student TBL�� Read ���� usertest04 �ּ���
grant select on scott.student to usertest04;

GRANT SELECT on scott.emp TO usertest02 WITH GRANT OPTION;
-- ����� �ڵ� --- GRANT SELECT on scott.emp TO usertest02


-- .��SELECT ���� �ο� ������ ���� �ο� , WITH GRANT OPTION  --> �ϰ� �ض� ���� �ο�
--with grant option�� ���� ������ ���⸸ ���� ���� ��ο� �Ұ��� 
GRANT SELECT on scott.stud_101 TO usertest02;

-- scott -> usertest02 ���� �ο�
GRANT SELECT on job3 TO usertest02 WITH GRANT OPTION;

-- ���� ȸ�� --> ���ʷ� ������ �� 02����ڿ� ������ ȸ���Ѵ�
revoke select on scott.job3 from usertest02;


--- usertable04���� �ߴµ� ���� �ʾ��� .. ������ ���⶧���� ��ı������ DBA������ �ֱ⶧���� ����

-- ���� ���Ǿ� ��� ��
select * from system.privateTBL;

-- ���� ���Ǿ� ����ϱ� ���� ���� 
create SYNONYM privateTBL for SYSTEM.privatetbl;
-- ���� ���Ǿ� ��� �� 
select * from privateTbL;


-- ���� ���Ǿ� �ý��ۿ��� ����� �ý��ۿ��� ���� ���Ǿ�
-- ���� ���Ǿ� �ý��ۿ��� ��������� ��ı������ ��밡���� ���Ǿ�


------------------------------------------------------------------------------------------------------------------
----------------------------------------------PL/SQL------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------
---    PL/SQL�� ����
---   1. Oracle���� �����ϴ� ���α׷��� ����� Ư���� ������ SQL�� Ȯ��
---   2. PL/SQL Block������ SQL�� DML(������ ���۾�)���� Query(�˻���)��, 
---      �׸��� ������ ���(IF, LOOP) ���� ����Ͽ� ���������� ���α׷����� �����ϰ� 
---      �� ������  Ʈ����� ���
---
---   1) ���� 
---      ���α׷� ������ ���ȭ : ������ ���α׷��� �ǹ��ְ� �� ���ǵ� ���� Block ����
---      ��������  : ���̺�� Į���� ������ Ÿ���� ������� �ϴ� �������� ������ ����
---      ����ó��  : Exception ó�� ��ƾ�� ����Ͽ� Oracle ���� ������ ó��
---      �̽ļ�    : Oracle�� PL/SQL�� �����ϴ¾ ȣ��Ʈ�ε� ���α׷� �̵� ����
---      ���� ��� : ���� ���α׷��� ������ ���
 
------------------------------------------------------------------------
--- ���� 01
--[����1] Ư���� ���� ������ 7%�� ����ϴ� Function: tax�� �ۼ�

create or replace Function tax
    (p_num in number) -- �Ķ���͸� ����
return number  -- �ݵ�� ���� ����
IS -- �Լ� ��ü ����
    v_tax  number; -- ��������
begin
    v_tax := p_num*0.07; -- := pl/sql ���� ������
    return (v_tax);
end;

select tax(100)
from dual; -- �Լ� ����

-- ���� work02
-- 1) procefure insert_emp 
-- 2) parameter(in) ->  p_empno, p_ename, p_job,p_mgr,p_sal,p_deptno
-- 3) ������ v_comm
-- 4) ���� 
--      1) p_job MANAGER -> v_comm(1000)
--      2) p_job else -> v_comm(150)
--      3) emp TBL insert(hiredate) -> ��������
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

-- �Լ� ��ȯ�Ǵ� �� �Ѱ�,������ ���� ó�� / ���ν��� ��ȯ �� ������, ������ dml�� ó��, ���Ἲ ������ ����
-- Ʈ������� Ư¡ ���ڼ�, �ϰ���, ����, ���Ӽ� == ���ϰ��� 






