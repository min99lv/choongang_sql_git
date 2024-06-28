-- ��1) 101�� �а� �����߿��� ���������� �޴� ������ ���� ����Ͽ���
-- count(*) = 101���а��� row�� �� 
select count(*), count(comm)
from professor
where deptno = 101
;
--102�� �а� �л����� ������ ��հ� �հ踦 ����Ͽ���
select avg(weight), sum(weight)
from student
where deptno = 102
;
-- ���� ���̺��� �޿��� ǥ�������� �л��� ���
select STDDEV(sal), VARIANCE(sal)
from professor
;
-- �а���  �л����� �ο���, ������ ��հ� �հ踦 ����Ͽ���
select deptno , count(*), avg(weight), sum(weight)
from student
group by deptno
;
-- ���� ���̺��� �а����� ���� ���� ���������� �޴� ���� ���� ����Ͽ���
-- ����Լ��� �Ϲ��Լ��� ���� ��� �Ұ��� group by�� ���־�� �Ѵ� == deptno
select count(*), count(comm)
from professor 
group by deptno
;
-- ���� ���̺��� �а����� ���� ���� ���������� �޴� ���� ���� ����Ͽ���
-- �� �а����� ���� ���� 2�� �̻��� �а��� ���
select deptno, count(*), count(comm) 
from professor
group by deptno
having count(*)>1
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
select deptno, max(hiredate), min(hiredate)
from emp
group by deptno
;
-- �μ���, ������ count & sum[�޿�]    (emp)
select deptno, job, count(*), sum(sal)
from emp
group by deptno, job
;
-- �μ��� �޿��Ѿ� 3000�̻� �μ���ȣ,�μ��� �޿��ִ�    (emp)
select deptno, max(sal)
from emp
group by deptno
having sum(sal)>=3000
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
select deptno, sum(sal)
from professor
group by rollup(deptno)
;
-- ex2) ROLLUP �����ڸ� �̿��Ͽ� �а� 
--      �� ���޺� ���� ��, �а��� ���� ��, ��ü ���� ���� ����Ͽ���
select deptno, position, count(*)
from professor
group by rollup(deptno, position)
;
-- CUBE ������
-- ROLLUP�� ���� �׷� ����� GROUP BY ���� ����� ���ǿ� ���� 
-- �׷� ������ ����� ������
-- ex1) CUBE �����ڸ� �̿��Ͽ� �а� �� ���޺� ���� ��, �а��� ���� ��, ��ü ���� ���� ����Ͽ���.
select deptno, position, count(*)
from professor
group by cube(deptno, position)
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
-- �����԰� 80kg�̻��� �л��� �й�, �̸�, ü��, �а� �̸�, �а���ġ�� ���
select studno, name, weight, deptno, loc
-- īƼ�� �� : �� �� �̻��� ���̺� ���� ���� ������ ���� ��� ����
-- 1) ������ �Ǽ�
-- 2) �����ʱ⿡ ���� Data ����

-- NATURAL JOIN�� �̿��Ͽ� ���� ��ȣ, �̸�, �а� ��ȣ, �а� �̸��� ����Ͽ���

-- NATURAL JOIN�� �̿��Ͽ� 4�г� �л��� �̸�, �а� ��ȣ, �а��̸��� ����Ͽ���

-- ��1) JOIN ~ USING ���� �̿��Ͽ� �й�, �̸�, �а���ȣ, �а��̸�, �а���ġ��
--       ����Ͽ���
 

