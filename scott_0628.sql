-----------------------------------------------------------------
----- SUB Query   ***
-- �ϳ��� SQL ��ɹ��� ����� �ٸ� SQL ��ɹ��� �����ϱ� ���� 
-- �� �� �̻��� SQL ��ɹ��� �ϳ��� SQL��ɹ����� �����Ͽ�
-- ó���ϴ� ���
-- ���� 
-- 1) ������ ��������
-- 2) ������ ��������
-------------------------------------------------------------------
--  1. ��ǥ : ���� ���̺��� ���������� ������ ������ ������ ��� ������ �̸� �˻�
--    1-1 ���� ���̺��� ���������� ������ ���� �˻� SQL ��ɹ� ����

--   1-2 ���� ���̺��� ���� Į������ 1 ���� ���� ��� ���� ������ 
--       ������ ���� ���� �˻� ��ɹ� ����
SELECT name, position
FROM professor
WHERE position = '���Ӱ���'
;
-- 1.��ǥ : ���� ���̺��� ���������� ������ ������ 
--  ������ ��� ������ �̸� �˻�--> SUB Query
SELECT name, position
FROM professor
WHERE position = (
                    SELECT position 
                    FROM professor
                    WHERE name = '������' 
                 )
;
-- ( ) ��ȣ ���� 1������ ����ȴ� = �ѹ�ó�� ��ȣ���� �������� 

-- ���� 
-- 1) ������ ��������
--  ������������ �� �ϳ��� �ุ�� �˻��Ͽ� ���������� ��ȯ�ϴ� ���ǹ�
--  ���������� WHERE ������ ���������� ����� ���� ��쿡�� �ݵ�� ������ �� 
--  ������ �� �ϳ��� ����ؾ���

--  ��1) ����� ���̵� ��jun123���� �л��� ���� �г��� �л��� �й�, �̸�, �г��� ����Ͽ���
SELECT studno, name, grade
FROM student
WHERE grade = (
                select grade
                from student
                where userid = 'jun123'
              )
;
--  ��2)  101�� �а� �л����� ��� �����Ժ��� �����԰� ���� �л��� �̸�, �г� ,
--          �а���ȣ, �����Ը�  ���
--  ���� : �а��� �������� ���
select name, grade, deptno, weight
FROM student
where weight < (
                    select avg(weight)
                    from student
                    where deptno = 101
                )
order by deptno
;
--  ��3) 20101�� �л��� �г��� ����, Ű�� 20101�� �л����� ū �л��� 
-- �̸�, �г�, Ű, �а��� �� ����Ͽ���
--  ���� : �а��� �������� ���
select s.name, s.grade, s.height, d.dname
FROM student s, department d
where s.deptno = d.deptno
and   s.grade = (
                        select grade
                        from student
                        where studno = 20101  
)
and s.height > (
-- 172
                        select height
                        from student
                        where studno = 20101  
)
order by d.dname desc
;
---------------------------------------------------------------------------------
-- 2) ������ ��������
-- ������������ ��ȯ�Ǵ� ��� ���� �ϳ� �̻��� �� ����ϴ� ��������
-- ���������� WHERE ������ ���������� ����� ���� ��쿡�� ���� �� �� ������ 
--  �� ����Ͽ� ��
-- ���� �� �� ������ : IN, ANY, SOME, ALL, EXISTS
-- 1) IN         : ���� ������ �� ������ ���������� ����߿��� �ϳ��� ��ġ�ϸ� ��, 
--                    ��=���񱳸� ����
-- 2) ANY, SOME  : ���� ������ �� ������ ���������� ����߿��� �ϳ��� ��ġ�ϸ� ��
-- 3) ALL             : ���� ������ �� ������ ���������� ����߿��� ��簪�� ��ġ�ϸ� ��, 
-- 4) EXISTS        : ���� ������ �� ������ ���������� ����߿��� �����ϴ� ���� �ϳ��� �����ϸ� ��
--------------------------------------------------------------------------------
-- 1. IN�����ڸ� �̿��� ���� �� ��������
SELECT name, grade, deptno
FROM student
WHERE deptno = (
                select deptno
                from department
                where college = 100
                )
;-- --  single-row subquery returns more than one row
-- �ϳ� �̻��� ���ϰ��� ���������� �����⶧���� �������� ������ ���� 
-- college= 100 �̸� deptno = 101, 102 �̱⶧���� ���ϰ��� �ΰ� = �� ǥ�� �Ұ���
-- 1. IN�����ڸ� �̿��� ���� �� ��������
SELECT name, grade, deptno
FROM student
WHERE deptno in (
                select deptno
                from department
                where college = 100
                )
;
-- ���� ���� �ǹ�
SELECT name, grade, deptno
FROM student
WHERE deptno in (
                    101,102
                )
;
--  2. ANY �����ڸ� �̿��� ���� �� ��������
--      :���� ������ �� ������ ���������� ����߿��� �ϳ��� ��ġ�ϸ� ��
-- ��)��� �л� �߿��� 4�г� �л� �߿��� Ű�� ���� ���� �л����� 
--      Ű�� ū �л��� �й�, �̸�, Ű�� ����Ͽ���
SELECT studno, name, height
FROM student
WHERE height > any (
-- any : ��ͺ��� ū �� 175, 176, 177 --> min ���� 
            SELECT height
            FROM student
            WHERE grade = '4'
            )
;
--  3. ALL �����ڸ� �̿��� ���� �� ��������
SELECT studno, name, height
FROM student
WHERE height > ALL (
-- all : ���ͺ��� ū �� 175, 176, 177 --> max ���� 
            SELECT height
            FROM student
            WHERE grade = '4'
            )
;
-- 4. EXISTS �����ڸ� �̿��� ���� �� ��������
-- :���� ������ �� ������ ���������� ����߿��� �����ϴ� ���� �ϳ��� �����ϸ� ��
-- ������ : ���ɶ����� ���
SELECT profno, name, sal, comm, position
FROM professor
WHERE EXISTS(
-- : ���簡 1row�� �ִٸ� ������Ѷ�
                SELECT position
                FROM professor
                WHERE comm is not null
            )
;
SELECT profno, name, sal, comm, position
FROM professor
WHERE EXISTS(
-- : �������� ���簡 1row�� �ִٸ� �������� ���� 
                SELECT position
                FROM professor
               -- WHERE deptno = 202
                WHERE deptno = 203 -- 1row�� �������� �ʱ⶧���� �������� ���� X
            )
;
-- ��1)  ���������� �޴� ������ �� ���̶� ������ 
--       ��� ������ ���� ��ȣ, �̸�, �������� �׸��� �޿��� ���������� ��(NULLó��)�� ���
SELECT profno, name,sal, comm,sal+NVL(comm,0) sal_comm
FROM professor
WHERE EXISTS (
                select profno
                FROM professor
                WHERE comm is not null
             )
;
-- ��2) �л� �߿��� ��goodstudent���̶�� ����� ���̵� ������ 1�� ����Ͽ���
SELECT 1 userid_exist
FROM dual
WHERE NOT EXISTS ( 
                    SELECT userid
                    FROM student
                    WHERE userid = 'goodstudent'
                )
;

-- ���� �÷� ��������
-- ������������ ���� ���� Į�� ���� �˻��Ͽ� ���������� �������� ���ϴ� ��������
-- ���������� ������������ ���������� Į�� ����ŭ ����
-- ����
-- 1) PAIRWISE : Į���� ������ ��� ���ÿ� ���ϴ� ���
-- 2) UNPAIRWISE : Į������ ����� ���� ��, AND ������ �ϴ� ���
-- �����÷� ��������
-- 1) PAIRWISE :Į���� ������ ��� ���ÿ� ���ϴ� ���
-- ��1)    PAIRWISE �� ����� ���� �г⺰�� �����԰� �ּ��� 
--          �л��� �̸�, �г�, �����Ը� ����Ͽ���
SELECT name, grade, weight
FROM student
WHERE (grade,weight) IN (
                        SELECT grade,min(weight)
                        FROM student
                        GROUP BY grade
                        )
;
--  2) UNPAIRWISE : Į������ ����� ���� ��, AND ������ �ϴ� ���
-- UNPAIRWISE �� ����� ���� �г⺰�� �����԰� �ּ��� �л��� �̸�, �г�, �����Ը� ���
SELECT name, grade, weight
FROM student
-- 1,2,3,4 AND 52,42,70,72 = ������ ���´� 1�г⿡ 52,70,72......
WHERE grade IN (
                        SELECT grade
                        FROM student
                        GROUP BY grade
                      
                )
AND weight IN (                 --52, 42, 70, 72
                        SELECT min(weight)
                        FROM student
                        GROUP BY grade
               )
                    
;
-- ��ȣ���� ��������     ***
-- ������������ ������������ �˻� ����� ��ȯ�ϴ� ��������
-- ��1)  �� �а� �л��� ��� Ű���� Ű�� ū �л��� �̸�, �а� ��ȣ, Ű�� ����Ͽ���
--                ������� 1
----              ������� 3
select deptno, name, grade, height --���� 1 /������ refresh ���� 3
from student s1
WHERE height > (
                select avg(height)
                from student s2
                -- where s2.deptno = 101
                --                  ������� 2
                WHERE s2.deptno = s1.deptno -- ���� 2
                ) -- �������� �ȿ� �������� ���̺��� ����
order by deptno
;

-------------  HW  -----------------------
-- 1. Blake�� ���� �μ��� �ִ� ��� ����� ���ؼ� ��� �̸��� �Ի����� ���÷����϶�
-- 2
SELECT ename, hiredate, deptno
from emp 
where deptno = (
                select deptno
                from emp
                where ename = 'BLAKE'
                -- ����� �ڵ�
                -- where inicap(ename) = 'Blake' 
)
;
-- 2. ��� �޿� �̻��� �޴� ��� ����� ���ؼ� ��� ��ȣ�� �̸��� ���÷����ϴ� ���ǹ��� ����. 
--    �� ����� �޿� �������� �����϶�
select empno,ename
from emp
where sal>= (  
        select avg(sal)
        from emp
        )
order by sal desc
;
-- 3. ���ʽ��� �޴� ����� �μ� ��ȣ�� 
--    �޿��� ��ġ�ϴ� ����� �̸�, �μ� ��ȣ �׸��� �޿��� ���÷����϶�.
select ename,deptno,sal,comm
from emp
where (deptno,sal) in (
                select deptno,sal
                from emp
                where comm is not null 
                ) 
;


SELECT e1.ename ���, e1.deptno "�μ� ��ȣ",e1.sal �޿�
FROM emp e1
JOIN emp e2 ON e1.sal = e2.sal
WHERE e1.comm IS NOT NULL
AND e1.empno != e2.empno
ORDER BY �޿� DESC
;
-------------------------------------------------------------------------------
--  ������ ���۾� (DML:Data Manpulation Language)  **      ----------------------
-- 1.���� : ���̺� ���ο� �����͸� �Է��ϰų� ���� �����͸� ���� �Ǵ� �����ϱ� ���� ��ɾ�
-- 2. ���� 
--  1) INSERT : ���ο� ������ �Է� ��ɾ�
--  2) UPDATE : ���� ������ ���� ��ɾ�
--  3) DELETE : ���� ������ ���� ��ɾ�
--  4) MERGE : �ΰ��� ���̺��� �ϳ��� ���̺�� �����ϴ� ��ɾ�

-- 1) Insert
INSERT INTO dept values (73,'�λ�')
; -- not enough values
INSERT INTO dept values (73,'�λ�','�̴�')
;
INSERT INTO dept(deptno,dname,loc)values (74,'ȸ����','������')
;
INSERT INTO dept(deptno,loc,dname)values (75,'�Ŵ��','������') -- ��ġ�� �����־����
;
INSERT INTO DEPT (deptno,loc) values (76,'ȫ��') 
; --  ���� ���� �������� null�� ����

--9910	��̼�		���ӱ���		24/06/28		101
--9920	������		������		06/01/01		102
INSERT INTO professor(profno,name,position,hiredate,deptno) 
        values('9910','��̼�','���ӱ���',sysdate,101)
;
INSERT INTO professor(profno,name,position,hiredate,deptno) 
        values('9920','������','������',to_Date('06/01/01','yy/mm/dd'),102)
;
-- ���̺� ���� 
DROP TABLE JOB3
;
-- ���̺� ����
CREATE TABLE JOB3
(   jobno          NUMBER(2)      PRIMARY KEY,
	jobname       VARCHAR2(20)
) ;
insert into job3                values(10,'�б�')
;
insert into job3 (jobno,jobname)values(11,'������')
;
insert into job3 (jobname,jobno)values('�����',12)
;
insert into job3                values(13,'����')
;
insert into job3                values(14,'�߼ұ��')
;
-- hw
--10	�⵶��
--20	ī�縯��
--30	�ұ�
--40	����
CREATE TABLE Religion   
(   religion_no         NUMBER(2)     CONSTRAINT PK_ReligionNo3 PRIMARY KEY,
	 religion_name     VARCHAR2(20)
) ;

insert into religion values (10,'�⵶��');
insert into religion (religion_no,religion_name) values (20,'ī�縯��');
insert into religion (religion_name,religion_no) values ('�ұ�',30);
insert into religion values (40,'����');

--------------------------------------------------
-----   ���� �� �Է�                          ------
--------------------------------------------------
-- 1. ������ TBL�̿� �ű� TBL ���� --> ���̺� ���簳�䰰��
CREATE TABLE dept_second
as select * from dept
; 
-- 2. tbl ���� ���� 
-- ���ϴ� �������� ���̺� ���� / �μ���ȣ = 20�� ���
-- �����̸Ӹ�Ű�� �������� �ʴ´�.
CREATE TABLE emp20
as select empno, sal*12 annsal
    from emp
    where deptno = 20
    ;
-- 3. TBL ������
create table dept30
as select deptno, dname
    from dept
    where 0 = 1 -- -> ���� �ʴٴ� �ǹ� ��Ű���� �����Ǿ� ���� --�����⸸
    ; -- 1= 1 1=2;??????
-- 4. columm �߰�
Alter table dept30
add(birth date)
;
INSERT into dept30 values (10,'�߾��б�',sysdate)
;
-- 5. Column ����
ALTER table dept30
MODify dname Varchar(11)
;-- value is too big �߾��б�12byte�̹Ƿ� �Ұ��� 
ALTER table dept30
MODify dname Varchar(30)
; -- Ű��°��� ���������� ũ�⸦ ���϶��� ���ִµ������� �ƽø� �����ͺ��� Ŀ���Ѵ�
-- 6.Column ����
ALTER TABLE dept30
DROP COLUMN dname
;
-- 7. TBL �� ����
RENAME dept30 to dept35
;
-- 8. TBL ����
DROP TABLE dept35
;
-- 9. Truncate
TRUNCATE table dept_second
;
-- INSERT ALL(unconditional INSERT ALL) ��ɹ�
-- ���������� ��� ������ ���Ǿ��� ���� ���̺� ���ÿ� �Է�
-- ���������� �÷� �̸��� �����Ͱ� �ԷµǴ� ���̺��� Į���� �ݵ�� �����ؾ� ��
CREATE table height_info
(   studNO number(5),
    NAME    varchar2(20),
    height number(5,2)
)
;
    CREATE table weight_info
(   studNO number(5),
    NAME    varchar2(20),
    weight number(5,2)
)
;
insert all
into height_info values(studNo, name, height)
into weight_info values(studNo, name, weight)
select studno, name, height, weight, grade
from student
where grade >= '2'
;
delete height_info;
delete weight_info;

-- INSERT ALL 
-- [WHEN ������1 THEN
-- INTO [table1] VLAUES[(column1, column2,��)]
-- [WHEN ������2 THEN
-- INTO [table2] VLAUES[(column1, column2,��)]
-- [ELSE
-- INTO [table3] VLAUES[(column1, column2,��)]
-- subquery;

-- �л� ���̺��� 2�г� �̻��� �л��� �˻��Ͽ� 
-- height_info ���̺��� Ű�� 170���� ū �л��� �й�, �̸�, Ű�� �Է�
-- weight_info ���̺��� �����԰� 70���� ū �л��� �й�, �̸�, �����Ը� 
-- ���� �Է��Ͽ���
insert all
when height > 170 then 
    into height_info values(studNo, name, height)
when weight > 75 then
    into weight_info values(studNo,name, weight)
select studno, name, height, weight
from student
where grade >= '2'
; -- ���Ǻ��� �Է� ����...........................
-- ������ ���� ����
-- UPDATE ��ɹ��� ���̺� ����� ������ ������ ���� ���۾�
-- WHERE ���� �����ϸ� ���̺��� ��� ���� ����
--- Update 
-- ��1) ���� ��ȣ�� 9903�� ������ ���� ������ ���α������� �����Ͽ���
update professor
set position = '�α���', userid = 'kkk'
where profno = 9903
-- or 1 = 1  rollback
;
--  ��2) ���������� �̿��Ͽ� �й��� 10201�� �л��� �г�� �а� ��ȣ��
--        10103 �й� �л��� �г�� �а� ��ȣ�� �����ϰ� �����Ͽ���
update student 
set (grade,deptno) = ( -- ��������
        select grade,deptno -- 3�г� 101
        from student
        where studno = 10103 
        )
where studno = 10201
;
-- ������ ���� ���� - dml
-- DELETE ��ɹ��� ���̺� ����� ������ ������ ���� ���۾�
-- WHERE ���� �����ϸ� ���̺��� ��� �� ����

-- ��1) �л� ���̺��� �й��� 20103�� �л��� �����͸� ����
delete
from student
where studno = 20103
;

-- ��2) �л� ���̺��� ��ǻ�Ͱ��а��� �Ҽӵ� �л��� ��� �����Ͽ��� hw --> rollback 
-- commit xx
delete 
from student 
where deptno = (
                    select deptno
                    from department 
                    where dname = '��ǻ�Ͱ��а�'
              )
;
ROLLBACK;
----------------------------------------------------------------------------------
---- MERGE
--  1. MERGE ����
--     ������ ���� �ΰ��� ���̺��� ���Ͽ� �ϳ��� ���̺�� ��ġ�� ���� ������ ���۾�
--     WHEN ���� ���������� ��� ���̺� �ش� ���� �����ϸ� UPDATE ��ɹ��� ����
--     ���ο� ������ ����,�׷��� ������ INSERT ��ɹ����� ���ο� ���� ����
------------------------------------------------------------------------------------
-- 1] MERGE �����۾� 
--  ��Ȳ 
-- 1) ������ �������� 2�� Update
-- 2) �赵�� ���� �ű� Insert

Create table professor_temp
as select * from professor
    where position = '����'
;
update professor_temp
set position = '������'
where position = '����'
;
insert into professor_temp
values (9999,'�赵��','arom21','���Ӱ���',200,sysdate,10,101)
;

commit;
-- 2] professor MERGE ���� 
-- ��ǥ : professor_temp�� �ִ� ����   ������ ������ professor Table�� Update
--                         �赵�� ���� �ű� Insert ������ professor Table�� Insert
-- 1) ������ �������� 2�� Update
-- 2) �赵�� ���� �ű� Insert
merge into professor p
using professor_temp f
ON (p.profno = f.profno)
when matched then -- pk�� ������ ������ ������Ʈ
    update set p.position = f.position
when not matched then -- pk�� ������ �ű� insert
    insert values(f.profno,f.name,f.userid,f.position,f.sal,f.hiredate,f.comm,f.deptno)
;
-- ������ �μ�Ʈ ������ ������Ʈ



