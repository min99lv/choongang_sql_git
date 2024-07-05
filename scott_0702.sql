-----------------------------------------------------------------------------------------
--   11. View 
------------------------------------------------------------------------------
-- View : �ϳ� �̻��� �⺻ ���̺��̳� �ٸ� �並 �̿��Ͽ� �����Ǵ� ���� ���̺�
--        ��� �����͵�ųʸ� ���̺� �信 ���� ���Ǹ� ����
--       ���� :   1)���� 
                    2) ��ޱ���ڰ� �ʱޱ������ sql�ɷ��� Ŀ������
--       ���� :   Performance(����)�� �� ����

-- �� ����
CREATE or REPLACE view view_professor 
AS
SELECT profno, name, userid, position, hiredate, deptno -- ����������� �÷�(�޿����� ����)
FROM professor; 

-- ��ȸ�ϴ� ���� professor�� �޾Ƽ� ��ü������ ���� --> �ι� �̵��ϱ⶧���� ��������
SELECT * FROM view_professor;

-- �信�� ������ �߰�
-- �信 �Էµ� ���� professor���̺��� �Է��� �ȴ� --> ���� ���� ���� null�� ��
--�������ǿ� �ɸ��� �ʴ´ٸ� �並 ���� �Է� ����
INSERT INTO view_professor VALUES(2000,'view','userid','position',sysdate,101);

--name�� �������� not null�� �ִµ� name�� �Է����� �ʾƼ� ����!
-- ORA-01400: cannot insert NULL into ("SCOTT"."PROFESSOR"."NAME")
insert into view_professor (profno,userid, position, hiredate, deptno)
        values(2001,'userid2','position2',sysdate,101);
        
-- ����work01 --> VIEW �̸� v_emp_sample  : emp(empno , ename , job, mgr,deptno)
create or replace view v_emp_samle
as
select empno, ename, job, mgr, deptno
from emp;
-- �������� pk: empno  fk : deptno
insert into v_emp_samle (empno, ename, job, mgr, deptno)
        values(2001,'userid2','position2',7839,10);
        
-- ���� work02 --> ���� view / ��� ��  v_emp_complex(emp, dept)
-- join�� ����Ͽ� �����
create or replace view v_emp_complex
as 
select *
from emp natural join dept;
-- ����Ŭ ���� --> ����Ű�� �Է��� �ȴ�
create or replace view v_emp_complex3
as 
select e.empno, e.ename, e.job, e.deptno, d.dname, d.loc
from emp e,dept d
where e.deptno = d.deptno 
;
-- ���� �� ������ �߰� --> �⺻������ �Ұ���
-- �������� Ȯ�� pk empno, deptno 
-- ���� �޼��� : cannot modify more than one base table through a join view
insert into v_emp_complex (empno, ename,deptno)
    values(1500,'ȫ�浿',20);
-- �־���ϴ� �÷��� �� �ְ� �������߰��� �⺻������ �Ұ����ϴ�
-- ���� �޼��� : cannot modify more than one base table through a join view
insert into  v_emp_complex (empno, ename, deptno, dname, loc)
    values(1500,'ȫ�浿',77,'������','������');

-- orcle join insert OK
insert into v_emp_complex3 (empno, ename)
    values(1501,'ȫ�浿1');
insert into v_emp_complex3 (empno, ename,deptno)
    values(1502,'ȫ�浿3',20);
insert into v_emp_complex3 (empno, ename, deptno, dname, loc)
    values(1503,'ȫ�浿4',77,'������','������');
    
create or replace view v_emp_complex4
as 
select  d.deptno, d.dname, d.loc, e.empno, e.ename, e.job
from dept d,emp e
where d.deptno = e.deptno 
;
insert into v_emp_complex4 (empno, ename)
    values(1600,'ȫ�浿1');
-- ����
insert into v_emp_complex4 (empno, ename,deptno)
    values(1601,'ȫ�浿3',20);
insert into v_emp_complex4 (empno, ename, deptno, dname, loc)
    values(1603,'ȫ�浿4',77,'������','������');
insert into v_emp_complex4 (deptno, ename,deptno)
    values(78,'������','������');
    
-- natural join --> � ���̺� ���ԵǾ��ִ� �÷����� ��Ȯ���� �ʾƼ� ���� 
-- oracle join --> �ߺ��Ǵ� �÷��� �����ϰ� ����

------------     View  HomeWork     ----------------------------------------------------

---��1)  �л� ���̺��� 101�� �а� �л����� �й�, �̸�, �а� ��ȣ�� ���ǵǴ� �ܼ� �並 ����
---     �� �� :  v_stud_dept101
create or replace view v_stud_dept101
as select studno, name, deptno
from student
where deptno = 101;
--��2) �л� ���̺�� �μ� ���̺��� �����Ͽ� 102�� �а� �л����� �й�, �̸�, �г�, �а� �̸����� ���ǵǴ� ���� �並 ����
--      �� �� :   v_stud_dept102
create or replace view v_stud_dept101
as select s.studno, s.name, d.deptno
from student s, department d
where s.deptno = d.deptno 
and d.deptno = 102;
--��3)  ���� ���̺��� �а��� ��� �޿���     �Ѱ�� ���ǵǴ� �並 ����
--  �� �� :  v_prof_avg_sal       Column �� :   avg_sal      sum_sal
create or replace view v_prof_avg_sal
as 
select deptno, avg(sal) avg_sal, sum(sal) sum_sal
from professor
group by deptno;

-- 2. group �Լ� column ��� �ȵ�
insert into v_prof_avg_sal
values(203,,600,300);

-- view ����
drop view v_stud_dept102;

select view_name, text
from user_views;
---------------------------------------------------------------------------------------------------
---- ������ ���ǹ�
---------------------------------------------------------------------------------------------------
-- 1. ������ ������ ���̽� ���� ������� 2���� ���̺� ����
-- 2. ������ ������ ���̽����� �����Ͱ��� �θ� ���踦 ǥ���� �� �ִ� Į���� �����Ͽ� 
--    �������� ���踦 ǥ��
-- 3. �ϳ��� ���̺��� �������� ������ ǥ���ϴ� ���踦 ��ȯ����(recursive relationship)
-- 4. �������� �����͸� ������ Į�����κ��� �����͸� �˻��Ͽ� ���������� ��� ��� ����

-- ����
-- SELECT ��ɹ����� START WITH�� CONNECT BY ���� �̿�
-- ������ ���ǹ������� �������� ��� ���İ� ���� ��ġ ����
-- ��� ������  top-down �Ǵ� bottom-up
-- ����) CONNECT BY PRIOR �� START WITH���� ANSI SQL ǥ���� �ƴ�


-- top - down ����
-- ��1) ������ ���ǹ��� ����Ͽ� �μ� ���̺��� �а�,�к�,�ܰ������� �˻��Ͽ� �ܴ�,�к�
-- �а������� top-down ������ ���� ������ ����Ͽ���. ��, ���� �����ʹ� 10�� �μ�
select level,deptno, dname, college
from department
start with deptno = 10 -- ���ۺ� �� ���� ������
connect by prior deptno = college; -- �ڽĺ��� ������

-- bottom - up ����
-- ��2)������ ���ǹ��� ����Ͽ� �μ� ���̺��� �а�,�к�,�ܰ������� �˻��Ͽ� �а�,�к�
-- �ܴ� ������ bottom-up ������ ���� ������ ����Ͽ���. ��, ���� �����ʹ� 102�� �μ��̴�
select deptno, dname, college
from department
start with deptno = 102 -- ���ۺ� �� ���� ������
connect by prior college = deptno ; -- �θ���� ������

--- ��3) ������ ���ǹ��� ����Ͽ� �μ� ���̺��� �μ� �̸��� �˻��Ͽ� �ܴ�, �к�, �а�����
---         top-down �������� ����Ͽ���. ��, ���� �����ʹ� ���������С��̰�,
---        �� LEVEL(����)���� �������� 2ĭ �̵��Ͽ� ���
select  lpad(' ',(level-1)*2) || dname  as ������
from department
start with deptno = 10
connect by prior deptno = college;


------------------------------------------------------
---      TableSpace  
---  ����  :�����ͺ��̽� ������Ʈ �� ���� �����͸� �����ϴ� ����
--           �̰��� �����ͺ��̽��� �������� �κ��̸�, ���׸�Ʈ�� �����Ǵ� ��� DBMS�� ���� 
--           �����(���׸�Ʈ)�� �Ҵ�
-- ���̺��� ����Ǵ� ��,,,, �̶�� �� ���� 
------------------------------------------------------
-- 1. TableSpace ����
create tableSpace user1 Datafile 'C:\BACKUP\tableSpace\user1.ora' SIZE 100M;
create tableSpace user2 Datafile 'C:\BACKUP\tableSpace\user2.ora' SIZE 100M;
create tableSpace user3 Datafile 'C:\BACKUP\tableSpace\user3.ora' SIZE 100M;
create tableSpace user4 Datafile 'C:\BACKUP\tableSpace\user4.ora' SIZE 100M;

-- ���̺����̽� ����
-- DROP TABLESPACE user4 INCLUDING CONTENTS AND DATAFILES;

-- 2. ���̺��� ���̺� �����̽� ����
--    1) ���̺��� NDEX�� Table��  ���̺� �����̽� ��ȸ
select index_name, table_name, tablespace_name
from user_indexes;
-- �ε����� ���̺� �����̽��� ����
alter index PK_RELIGIONNO3 REBUILD tablespace user1;

select table_name, tablespace_name
from user_tables;
alter table job3 move tablespace user2;

-- 3. ���̺� �����̽� size ����
alter Database DATAFILE 'C:\BACKUP\tableSpace\user4.ora' resize 200M;

------------------���

-- cmdâ
-- Oracle ��ü Backup  (scott) --> system1_0702.sqlȮ�� --> cmdâ���� ���� & �������������� ����
EXPDP scott/tiger Directory=mdBackup2 DUMPFILE=scott.dmp;

-- Oracle ��ü Restore  (scott)
IMPDP scott/tiger Directory=mdBackup2 DUMPFILE=scott.dmp;

-- Oracle �κ� Backup��  �κ� Restore
exp scott/tiger file=dept_second.dmp tables=dept_second
-- ���̺��� �������Ϸ� �����ְٴ�
exp scott/tiger file=address.dmp tables=address
-- �κ� ����
imp scott/tiger file=dept_second.dmp tables=dept_second
imp scott/tiger file=address.dmp tables=address

----------------------------------------------------------------------------------------
-------                     Trigger 
--  1. ���� : � ����� �߻����� �� ���������� ����ǵ��� �����ͺ� �̽��� ����� ���ν���
--              Ʈ���Ű� ����Ǿ�� �� �̺�Ʈ �߻��� �ڵ����� ����Ǵ� ���ν��� 
--              Ʈ���Ÿ� ���(Triggering Event), �� ����Ŭ DML ���� INSERT, DELETE, UPDATE�� 
--              ����Ǹ� �ڵ����� ����
--  2. ����Ŭ Ʈ���� ��� ����
--    1) �����ͺ��̽� ���̺� �����ϴ� �������� ���� ���Ἲ�� ������ ���Ἲ ���� ������ ���� ���� �����ϴ� ��� 
--    2) �����ͺ��̽� ���̺��� �����Ϳ� ����� �۾��� ����, ���� 
--    3) �����ͺ��̽� ���̺� ����� ��ȭ�� ���� �ʿ��� �ٸ� ���α׷��� �����ϴ� ��� 
--    4) ���ʿ��� Ʈ������� �����ϱ� ���� 
--    5) �÷��� ���� �ڵ����� �����ǵ��� �ϴ� ��� 
-------------------------------------------------------------------------------------------
-- Ʈ���� ����
Create or replace trigger triger_test 
before --  ������ �̺�Ʈ�� �߻��ϱ��� ����
update on dept 
for each row -- old, new ��� ���ؼ�
begin -- ���۰� ���� ���
    DBMS_OUTPUT.enable;                             -- triger�� �տ� :�� �Ѵ� ���� X
    DBMS_OUTPUT.PUT_LINE('���� �� �÷� ��: ' || :old.dname); -- ���� �̸�
    DBMS_OUTPUT.PUT_LINE('���� �� �÷� ��: ' || :new.dname); -- ���� �� �̸�
END; 

update dept
set dname ='ȸ��3��' -- ���� �� �̸� 
where deptno = 71;

commit;

rollback;

----------------------------------------------------------
-- ���� ��ũ ) emp Table�� �޿��� ��ȭ��
--       ȭ�鿡 ����ϴ� Trigger �ۼ�( emp_sal_change)
--       emp Table ������
--      ���� : �Է½ô� empno�� 0���� Ŀ����

--��°�� ����
--     �����޿�  : 10000
--     ��  �޿�  : 15000
 --    �޿� ���� :  5000
----------------------------------------------------------
Create or replace trigger emp_sal_change
before DELETE OR INSERT OR update on emp
for each row
    when (new.empno > 0)
    declare -- ����
        sal_diff number;
begin   -- := ����
    sal_diff := :new.sal - :old.sal;
    DBMS_OUTPUT.PUT_LINE('���� �޿�: ' || :old.sal); -- ���� �̸�
    DBMS_OUTPUT.PUT_LINE('�� �޿�: ' || :new.sal); -- ���� �� �̸�
    --DBMS_OUTPUT.PUT_LINE('�޿� ����: ' || :new.sal-old.sal); -- ���� �̸�
    DBMS_OUTPUT.PUT_LINE('�޿� ����: ' || sal_diff); 
END;

update emp
set sal = 1000
where empno = 7369;


--------------------------------------------------------------------------------------------------
--  EMP ���̺� INSERT,UPDATE,DELETE������ �Ϸ翡 �� ���� ROW�� �߻��Ǵ��� ����
--  ���� ������ EMP_ROW_AUDIT�� 
--  ID ,����� �̸�, �۾� ����,�۾� ���ڽð��� �����ϴ� 
--  Ʈ���Ÿ� �ۼ�
-------------------------------------------------------------------------------------------------
-- 1. SEQUENCE
--DROP  SEQUENCE  emp_row_seq;
create sequence emp_row_seq;
-- 2. Audit Table
--DROP  TABLE  emp_row_audit;
create table emp_row_audit(
     e_id number(6) constraint emp_row_pk primary key,
     e_name varchar2(30),
     e_gubun varchar2(10),
     e_date date
 );
 
 -- 3. trigger
 create or replace trigger emp_row_aud
    after insert or update or delete on emp
    for each row
    begin
        if inserting then
            insert into emp_row_audit
                values(emp_row_seq.nextVAL,:new.ename,'inserting',sysdate);
        elsif updating then
            insert into emp_row_audit
                values(emp_row_seq.nextVAL,:old.ename,'updating',sysdate);
        elsif deleting then
            insert into emp_row_audit
                values(emp_row_seq.nextVAL,:old.ename,'deleting',sysdate);
        end if;
End;

insert into emp(empno,ename, sal,deptno)
    values(3000,'������',3500,50);
    
insert into emp(empno,ename, sal,deptno)
    values(3100,'Ȳ����',3500,51);

update emp
set ename = 'Ȳ����'
where empno = 1600;

delete emp
where empno = 1502;

rollback;

            