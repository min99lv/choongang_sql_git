--------------------------------------------------------------------------------
---   8��. �׷��Լ� **
---   ���̺��� ��ü ���� �ϳ� �̻��� �÷��� �������� �׷�ȭ�Ͽ�
---   �׷캰�� ����� ����ϴ� �Լ�
--      �׷��Լ��� ������� ����� ����ϴµ� ���� ���
--------------------------------------------------------------------------------
-- SELECT  column, group_function(column)
-- FROM  table
-- [WHERE  condition]
-- [GROUP BY  group_by_expression]
-- [HAVING  group_condition]
-- ? GROUP BY : ��ü ���� group_by_expression�� �������� �׷�ȭ
-- ? HAVING : GROUP BY ���� ���� ������ �׷캰�� ���� �ο�

--  ���� �ǹ�
--  COUNT : ���� ���� ���
--  MAX : NULL�� ������ ��� �࿡�� �ִ� ��
--  MIN : NULL�� ������ ��� �࿡�� �ּ� ��
--  SUM : NULL�� ������ ��� ���� ��
--  AVG : NULL�� ������ ��� ���� ��� ��
--------------�� �ʼ� ------------�Ʒ� ���۸�-------------------------------------
--  STDDEV : NULL�� ������ ��� ���� ǥ������
--  VARIANCE : NULL�� ������ ��� ���� �л� ��
--  GROUPING : �ش� Į���� �׷쿡 ���Ǿ����� ���θ� 1 �Ǵ� 0���� ��ȯ
--  GROUPING SETS : �� ���� ���Ƿ� ���� ���� �׷�ȭ ���
-- 1) COUNT �Լ�
-- ���̺��� ������ �����ϴ� ���� ������ ��ȯ�ϴ� �Լ�
-- ��1) 101�� �а� �����߿��� ���������� �޴� ������ ���� ����Ͽ���
-- count(*) = 101���а��� row�� �� 
select count(*),count(comm)
from professor
where deptno = 101
;
--102�� �а� �л����� ������ ��հ� �հ踦 ����Ͽ���
select avg(weight),sum(weight)
from student
where deptno = 102
;
-- ���� ���̺��� �޿��� ǥ�������� �л��� ���
select stddev(sal),variance(sal)
from professor
;
-- �а���  �л����� �ο���, ������ ��հ� �հ踦 ����Ͽ���
select deptno, count(*), avg(weight), sum(weight)
from student
group by deptno
;
-- ���� ���̺��� �а����� ���� ���� ���������� �޴� ���� ���� ����Ͽ���
-- ����Լ��� �Ϲ��Լ��� ���� ��� �Ұ��� group by�� ���־�� �Ѵ� == deptno
select deptno, count(*),count(comm)
from professor
group by deptno
;
-- ���� ���̺��� �а����� ���� ���� ���������� �޴� ���� ���� ����Ͽ���
-- �� �а����� ���� ���� 2�� �̻��� �а��� ���
select deptno, count(*), count(comm)
from professor
group by deptno
having COUNT(*)> 1  -- group by ���ǹ��� having ����ؾ��Ѵ�.
;
-- �л� ���� 4���̻��̰� ���Ű�� 168�̻���  �г⿡ ���ؼ� �г�, �л� ��, ��� Ű, ��� �����Ը� ���
-- ��, ��� Ű�� ��� �����Դ� �Ҽ��� �� ��° �ڸ����� �ݿø� �ϰ�, 
-- ��¼����� ��� Ű�� ���� ������ ������������ ����ϰ� 
-- �� �ȿ��� ��� �����԰� ���� ������ ������������ ���
select grade, count(*), round(avg(height),1) ���Ű, round(avg(weight),1) ��ո�����
from student
group by grade
having count(*)>=4 and round(avg(height))>= 168
order by ���Ű desc, ��ո����� desc
;
--  �ֱ� �Ի� ����� ���� ������ ����� �Ի��� ��� (emp)
select max(hiredate), min(hiredate)
from emp
;
--  �μ��� �ֱ� �Ի� ����� ���� ������ ����� �Ի��� ��� (emp)
select deptno,min(hiredate), max(hiredate)
from emp
group by deptno
;
-- �μ���, ������ count & sum[�޿�]   (emp)
select deptno, job,count(*),sum(sal)
from emp
group by deptno, job
order by deptno, job
;
-- �μ��� �޿��Ѿ� 3000�̻� �μ���ȣ,�μ��� �޿��ִ�    (emp)
select deptno, max(sal)
from emp
GROUP by deptno
having sum(sal)>= 3000
order by deptno
;
-- ��ü �л��� �Ҽ� �а����� ������, ���� �а� �л��� �ٽ� �г⺰�� �׷����Ͽ�, 
--   �а��� �г⺰ �ο���, ��� �����Ը� ���, 
-- (��, ��� �����Դ� �Ҽ��� ���� ù��° �ڸ����� �ݿø� )  STUDENT
select deptno,grade, count(*), round(avg(weight))
from student
group by deptno, grade
order by deptno, grade
;
-- ROLLUP ������
-- GROUP BY ���� �׷� ���ǿ� ���� ��ü ���� �׷�ȭ�ϰ�
--          �� �׷쿡 ���� �κ����� ���ϴ� ������
-- ex1) �Ҽ� �а����� ���� �޿� �հ�� ��� �а� �������� �޿� �հ踦 ����Ͽ���
select deptno,sum(sal)
FROM professor
group by rollup(deptno)
;
-- ex2) ROLLUP �����ڸ� �̿��Ͽ� �а� 
--      �� ���޺� ���� ��, �а��� ���� ��, ��ü ���� ���� ����Ͽ���
select deptno, position, count(*)
from professor
GROUP by rollup(deptno, position)
;
-- CUBE ������
-- ROLLUP�� ���� �׷� ����� GROUP BY ���� ����� ���ǿ� ���� 
-- �׷� ������ ����� ������
-- ex1) CUBE �����ڸ� �̿��Ͽ� �а� �� ���޺� ���� ��, �а��� ���� ��, ��ü ���� ���� ����Ͽ���.
select deptno, position,count(*)
from professor
GROUP by cube(deptno, position)
;
--------------------------------------------------------------------------------
----    9-0.    DeadLock     ---------
--------------------------------------------------------------------------------
-- Transaction A --> developer
-- Ʈ����� db���� : ���ÿ� Ŀ�Եǰų� �ѹ� �Ǳ����� ��� / 
-- 1) Smith  - 1 ����Ŭ ����
Update emp  -- �ڿ� 1
SET sal = sal * 1.1
WHERE empno = 7369
;
-- 2) KING -- A�� �ڿ� 2�䱸
Update emp
SET sal = sal * 1.1
WHERE empno = 7839
;
-- Transation B
-- 2. sqlplus ����
Update emp
SET comm = 500 -- �ڿ�2
WHERE empno = 7839
;
Update emp -- �ڿ�1 �䱸
SET comm = 300
WHERE empno = 7369
;

insert into dept Values(72,'kk','kk')
;
commit;
----------------------------------------------------------------------
----                    9-1.     JOIN       ***                                           ---------
----------------------------------------------------------------------
-- 1) ������ ����
--  �ϳ��� SQL ��ɹ��� ���� ���� ���̺� ����� �����͸� �ѹ��� ��ȸ�Ҽ� �ִ� ���
-- ex1-1) �й��� 10101�� �л��� �̸��� �Ҽ� �а� �̸��� ����Ͽ���
select studno, name, deptno
from student
where studno = 10101
;
-- ex1-2)�а��� ������ �а��̸�
select dname
from department
where deptno = 101
;
-- ex1-3) [ex1-1]+[ex1-2]�ѹ� ��ȸ --> join
select studno, name, student.deptno, department.dname
from student, department
where student.deptno = department.deptno
;
-- �ָŸ�ȣ�� (ambiguously) --> ���� ���
SELECT studno, name,deptno, dname
FROM student s, department d
WHERE s.deptno = d.deptno
;   
-- �ָŸ�ȣ�� (ambiguously) --> �ذ�: ����(alias)
-- ���� alias�� ��ü �ɾ��ִ� �� 
SELECT s.studno, s.name,d.deptno, d.dname
FROM student s, department d
WHERE s.deptno = d.deptno
;   
-- ������ �л��� �й�, �̸�, �а� �̸� �׸��� �а� ��ġ�� ���
select s.studno, s.name, d.dname, d.loc
FROM student s, department d
WHERE s.deptno = d.deptno 
and s.name = '������'
;
-- �����԰� 80kg�̻��� �л��� �й�, �̸�, ü��, �а� �̸�, �а���ġ�� ���
select s.studno, s.name, s.weight, d.dname, d.loc
FROM student s, department d
WHERE s.deptno = d.deptno and s.weight>= 80
;
-- īƼ�� �� : �� �� �̻��� ���̺� ���� ���� ������ ���� ��� ����
-- 1) ������ �Ǽ�
-- 2) �����ʱ⿡ ���� Data ����
SELECT s.studno, s.name,d.dname, d.loc,s.weight,d.deptno
FROM student s, department d
-- where ������ ���� �ܼ��� ȣ���� ��...
-- 7 * 17 = 119
;
SELECT s.studno, s.name,d.dname, d.loc,s.weight,d.deptno
FROM student s
CROSS JOIN department d
;
-- *** equi join
-- ���� ��� ���̺��� ���� Į���� ��=��(equal) �񱳸� ���� ���� ���� 
-- ������ ���� �����Ͽ� ����� �����ϴ� ���� ���
--  SQL ��ɹ����� ���� ���� ����ϴ� ���� ���
-- �ڿ������� �̿��� EQUI JOIN
-- ����Ŭ 9i �������� EQUI JOIN�� �ڿ������̶� ���
-- WHERE ���� ������� �ʰ�  NATURAL JOIN Ű���� ���
-- ����Ŭ���� �ڵ������� ���̺��� ��� Į���� ������� ���� Į���� ���� ��, 
-- ���������� ���ι� ����
-- Ű���带 ������� ���� join

-- ����Ŭ JOIN ǥ���
SELECT s.studno, s.name,d.deptno,d.dname
FROM student s, department d
WHERE s.deptno = d.deptno
;
-- ANSI ǥ���
-- Natural Join Convert Error �ذ� 
-- NATURAL JOIN�� ���� ��Ʈ����Ʈ�� ���̺� ������ ����ϸ� ������ �߻�
SELECT s.studno, s.name, s.weight, d.dname, d.loc, d.deptno
FROM student s 
     NATURAL JOIN department d
;                                        --join�� �÷��� ���� ���� �÷� ���� ����
SELECT s.studno, s.name, s.weight, d.dname, d.loc, deptno
FROM student s 
     NATURAL JOIN department d
;
-- NATURAL JOIN�� �̿��Ͽ� ���� ��ȣ, �̸�, �а� ��ȣ, �а� �̸��� ����Ͽ���
SELECT p.profno,p.name, deptno, d.dname
FROM professor p
natural join department d
;
-- NATURAL JOIN�� �̿��Ͽ� 4�г� �л��� �̸�, �а� ��ȣ, �а��̸��� ����Ͽ���
SELECT s.name, s.grade, deptno, d.dname
FROM student s
    natural join department d
where s.grade = '4'
;
-- JOIN ~ USING ���� �̿��� EQUI JOIN
-- USING���� ���� ��� Į���� ����
-- Į�� �̸��� ���� ��� ���̺��� ������ �̸����� ���ǵǾ� �־����
-- ��1) JOIN ~ USING ���� �̿��Ͽ� �й�, �̸�, �а���ȣ, �а��̸�, �а���ġ��
--       ����Ͽ���
select s.studno, s.name, deptno, dname
FROM student s JOIN department
    using(deptno)
;
-- EQUI JOIN�� 4���� ����� �̿��Ͽ� ���� ���衯���� �л����� �̸�, �а���ȣ,�а��̸��� ���
-- 1) ����Ŭ ���� ��� where ��
select s.studno,s.name, d.deptno, d.dname
FROM student s, department d
where s.deptno = d.deptno 
and s.name like '��%'
;
-- 2) natural ���� ���
select s.studno, s.name,deptno, dname
FROM student s NATURAL join department d
where s.name like '��%'
;
-- 3) join using ���
select s.studno,s.name, deptno, d.dname
FROM student s join department d
        using(deptno)
where s.name like '��%'
;
-- 4)ANSI JOIN(INNER JOIN ~ ON)
select s.studno,s.name, d.deptno,dname
FROM student s inner join department d
on s.deptno = d.deptno
where s.name like '��%'
;    
-- NON-EQUI JOIN ** == ���� ����
-- ��<��,BETWEEN a AND b �� ���� ��=�� ������ �ƴ� ������ ���
-- ���� ���̺�� �޿� ��� ���̺��� NON-EQUI JOIN�Ͽ� 
-- �������� �޿� ����� ����Ͽ���
CREATE TABLE "SCOTT"."SALGRADE2" 
   (	
        "GRADE" NUMBER(2,0), 
     	"LOSAL" NUMBER(5,0), 
    	"HISAL" NUMBER(5,0)
  )
;
-- ���� ����
SELECT p.profno, p.name, p.sal, s.grade
FROM professor p, salgrade2 s
WHERE p.sal BETWEEN s.losal AND s.hisal
;
-- OUTER JOIN  ***
-- EQUI JOIN���� ���� Į�� ������ �ϳ��� NULL ������ ���� ����� ����� �ʿ䰡 �ִ� ���
-- equi join ���
select s.name, s.grade, p.name, p.position
from student s, professor p
where s.profno = p.profno
;
-- �л� ���̺�� ���� ���̺��� �����Ͽ� �̸�, �г�, ���������� �̸�, ������ ���
-- ��, ���������� �������� ���� �л��̸��� �Բ� ����Ͽ���.
-- orcle left outer join ���
select s.name, s.grade, p.name, p.position
from student s, professor p
where s.profno = p.profno(+) -- �����ʿ� �ɾ��ִ°� left outer join
-- ��Ʃ��Ʈ ���̺� �������� profno = null�� �ɸ� ���̺� �� ����
;
-- ansi outer join
-- 1. ansi left outer join
select s.studno, s.name, s.profno, p.name
from student s
    left outer join professor p
    on s.profno = p.profno
;

--�л� ���̺�� ���� ���̺��� �����Ͽ� �̸�, �г�, �������� �̸�, ������ ���
-- ��, �����л��� �������� ���� ���� �̸��� �Բ� ����Ͽ���
-- oracle right outer join
select s.name,s.grade, p.name,p.position
from student s, professor p
where s.profno(+) = p.profno
order by p.profno
; -- ���������߿��� �л��� �Ҵ� ���� ���� ������ ���
-- professor �������� student�� �ŷе��� ���� �������� +�ؼ� ��µ�
--- ANSI OUTER JOIN
-- 1. ANSI RIGHT  OUTER JOIN
SELECT s.studno, s.name, s.profno, p.name
FROM student s
    RIGHT OUTER JOIN professor p
    ON s.profno = p.profno
;
---- <<<   FULL OUTER JOIN  >>> -------------------------------
--�л� ���̺�� ���� ���̺��� �����Ͽ� �̸�, �г�, �������� �̸�, ������ ���
-- ��, �����л��� �������� ���� ���� �̸� �� 
--  ���������� �������� ���� �л��̸�  �Բ� ����Ͽ���
-- ORCLE JOIN 
--  Oracle ���� �� ��.......
SELECT s.name, s.grade, p.name,p.position
FROM student s, professor p
WHERE s.profno(+) = p.profno(+)
ORDER BY p.profno
;

-- FULL OUTER ��� --> UNION
select s.name, s.grade, p.name,p.position
FROM student s, professor p
where s.profno = p.profno(+)
union
select s.name, s.grade, p.name, p.position
FROM student s, professor p
WHERE s.profno(+) = p.profno
;
-- 3. ANSI FULL OUTER JOIN
SELECT s.studno, s.name, s.profno,p.name
FROM student s
    FULL outer JOIN professor p
    ON s.profno = p.profno
;
-------                    SELF JOIN   **           ----------------       
-- �ϳ��� ���̺��� �ִ� Į������ �����ϴ� ������ �ʿ��� ��� ���
-- ���� ��� ���̺��� �ڽ� �ϳ���� �� �ܿ��� EQUI JOIN�� ����
SELECT c.deptno, c.dname,c.college, d.dname college_name
    -- �а�             �к�
FROM department c, department d
WHERE c.college = d.deptno
;

-- SELF JOIN --> �μ� ��ȣ�� 201 �̻��� �μ� �̸��� ���� �μ��� �̸��� ���
-- ��� : xxx�Ҽ��� xxx�к�
select concat(dept.dname, ' �Ҽ��� ')|| concat(org.dname, '�̴�')
--select dept.dname || '�� �Ҽ���' || org.dname || '�̴�'
FROM department dept, department org
where dept.college = org.deptno 
and dept.deptno >= 201
;
-- hw (inner)
-- 1. �̸�, �����ڸ�(�������̸�)(emp TBL) self - join
select e1.ename, e2.ename �����ڸ�
from emp e1, emp e2
where e1.empno = e2.mgr
;
-- 2. �̸�,�޿�,�μ��ڵ�,�μ���,�ٹ���, ������ ��, ��ü����(emp ,dept TBL)
select e.ename �̸�, e.sal, e.deptno, d.dname, d.loc, e2.ename �����ڸ�
        , (SELECT COUNT (*) FROM emp) ��ü������
from emp e, dept d, emp e2
where e.deptno = d.deptno and e.empno = e2.empno
;
-- 3. �̸�,�޿�,���,�μ���,�����ڸ�, �޿��� 2000�̻��� ���
--    (emp, dept,salgrade TBL)
select e.ename, e.sal,s.grade,d.dname, e2.ename �����ڸ� 
from emp e, dept d, salgrade s ,emp e2
where e.deptno = d.deptno and e.sal > 2000
    and e.empno = e2.empno 
;
-- 4. ���ʽ��� �޴� ����� ���Ͽ� �̸�,�μ���,��ġ�� ����ϴ� SELECT ������ �ۼ�emp ,dept TBL)
select e.ename, d.dname, d.loc
from emp e, dept d
where e.deptno = d.deptno and e.comm is not null
;
-- 5. ���, �����, �μ��ڵ�, �μ����� �˻��϶�. ������������ ������������(emp ,dept TBL)
select e.empno, e.ename, e.deptno, d.dname
from emp e, dept d
where e.deptno = d.deptno 
order by e.ename
;