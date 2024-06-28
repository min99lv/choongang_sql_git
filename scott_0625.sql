-- ��ı�� �ִ� ��� ���̺���� ������
SELECT * FROM tab;

-- dept ���̺� ���� ���� ��ȸ
DESC dept;

-- dept���̺� --> deptno, loc ���
SELECT DEPTNO, LOC 
FROM DEPT;

-- �μ� ���̺��� �μ��̸��� �μ� ��ȣ�� ����϶�
SELECT DNAME,DEPTNO 
FROM DEPT;
-- Ű����� �빮�� ������
-- ���̺�� �÷��̸��� �ҹ���

-- �л� ���̺��� �ߺ��Ǵ� �а� ��ȣ(deptno)�� �����ϰ� ����Ͽ��� --> distinct
SELECT DISTINCT deptno 
FROM student;

--  �÷� ���� �ο� ���
--  Į�� �̸��� ���� ���̿� ������ �߰��ϴ� ���
--  Į�� �̸��� ���� ���̿� AS Ű���带 �߰��ϴ� ���
--  ū����ǥ�� ����ϴ� ���
--  Į�� �̸��� ���� ���̿� ������ �߰��ϴ� ���
--  Ư�����ڸ� �߰��ϰų� ��ҹ��ڸ� �����ϴ� ���
-- ex) �μ� ���̺��� �μ� �̸� Į���� ������ dept_name, 
--     �μ� ��ȣ Į���� ������ DN���� �ο��Ͽ� ����Ͽ���// ���� ���̸�, As ���̸�
SELECT dname dept_name, deptno As dn
FROM department;

-- �ռ�(concatenation)������ --> ||
-- �ϳ��� Į���� �ٸ� Į��, ��� ǥ���� �Ǵ� ��� ���� �����Ͽ� �ϳ��� Į��ó�� ����� ��쿡 ���
-- ex)�л� ���̺��� �й��� �̸� Į���� �����Ͽ� ��StudentAli����� �������� �ϳ��� Į��ó�� �����Ͽ� ����Ͽ���
SELECT studno || ' ' || name "StudentAli"
FROM student;

-- hw1/�л��� �����Ը� pound�� ȯ���ϰ� Į�� �̸��� ��weight_pound�� ��� �������� ����Ͽ���. 1kg�� 2.2pound
-- ��� ������ �̸�, ������, weight_pound 
SELECT name, weight, weight*2.2 AS weigh_pound
FROM student;

-- Char �� VarChar �� ����
CREATE TABLE ex_type
(c char(10), 
 v VARCHAR2(10)
 );
 
INSERT INTO ex_type
VALUES('sql','sql');
commit;

SELECT * 
FROM ex_type
WHERE c = 'sql'
;

SELECT * 
FROM ex_type
WHERE v = 'sql'
;
-- c �� v�� ��ũ.. ���� �ٸ�
SELECT * 
FROM ex_type
WHERE v = c
;
-- ��ũ�� ������ ������ ���� �ϴ� ����� trim
SELECT * 
FROM ex_type
WHERE v = trim(c)
;

 

-- ������ �˻� --> where�� �� condition 
-- WHERE��
-- ���̺� ����� �������߿��� ���ϴ� �����͸� ���������� �˻��ϴ� ���
-- WHERE ���� ���ǹ��� Į�� �̸�, ������, ���, ��� ǥ������ �����Ͽ� �پ��� ���·� ǥ�� ����
-- WHERE ������ ����ϴ� ������ Ÿ���� ����, ����, ��¥ Ÿ�� ��� ����
-- ���ڿ� ��¥ Ÿ���� ��� ���� ���� ����ǥ(����)�� ��� ǥ���ϰ� ���ڴ� �״�� ���
-- ��� ������ �����ڴ� ��ҹ��ڸ� ����

-- �л� ���̺��� 1�г� �л��� �˻��Ͽ� �й�, �̸�, �а� ��ȣ�� ����Ͽ���
SELECT studno, name, deptno 
FROM student
Where grade = '1' -- �ֽŹ��� ������Ÿ�� '1' �� ǥ�� ����
;

SELECT studno, name, deptno 
FROM student
Where grade = to_number('1')
;
-- ������ ������
-- �л� ���̺��� �����԰� 70kg ������ �л��� �˻��Ͽ� �й�, �̸�, �г�, �а���ȣ, �����Ը� ����Ͽ���.
SELECT studno, name, grade, deptno, weight
FROM student
Where weight <= 70
;
-- �� ������ 
-- �л� ���̺��� 1�г� �̸鼭 �����԰� 70kg �̻��� �л��� �˻��Ͽ� �̸�, �г�, ������, �а���ȣ�� ����Ͽ���
SELECT studno, name, grade, deptno, weight
FROM student
Where weight >= 70
And grade = 1
;

-- ?�л� ���̺��� 1�г��̰ų� �����԰� 70kg �̻��� �л��� �˻��Ͽ� �̸�, �г�, ������, �а���ȣ�� ����Ͽ���.
SELECT studno, name, grade, deptno, weight
FROM student
Where weight >= 70
OR grade = 1
;
-- BETWEEN** �����ڸ� ����Ͽ� �����԰� 50kg���� 70kg ������ �л��� �й�, �̸�, �����Ը� ����Ͽ���
SELECT studno, name, weight
FROM student
Where weight BETWEEN 50 and 70
;
-- �л����̺��� 81�⿡�� 83�⵵�� �¾ �л��� �̸��� ��������� ����ض�
SELECT name, birthdate
FROM student
where birthdate BETWEEN '81/01/01' and '83/12/31'
-- where birthdate between to_date('810101') and to_date('831231')
;

-- IN* �����ڸ� ����Ͽ� 102�� �а��� 201�� �а� �л��� �̸�, �г�, �а���ȣ�� ����Ͽ���
SELECT name, grade, deptno
FROM student
where deptno in(102,201)
-- where deptno = 102 or deptno = 201
;
-- LIKE ������
-- Į���� ����� ���ڿ��߿��� LIKE �����ڿ��� ������ ���� ���ϰ� 
-- �κ������� ��ġ�ϸ� ���� �Ǵ� ������
-- ex)�л� ���̺��� ���� ���衯���� �л��� �̸�, �г�, �а� ��ȣ�� ����Ͽ���'_%'
SELECT name, grade, deptno
FROM student
where name Like '��%'
;
-- �̸��� '��' �յڴ� ������� 
SELECT name, grade, deptno
FROM student
where name Like '%��%'
;
-- �̸��� ���� '��'
SELECT name, grade, deptno
FROM student
where name Like '%��'
;
-- �л� ���̺��� �̸��� 3����, ���� ���衯���� ������ ���ڰ�
-- ���������� ������ �л��� �̸�, �г�, �а� ��ȣ�� ����Ͽ���
SELECT name, grade, deptno
FROM student
where name Like '��%��'
;

SELECT name, grade, deptno
FROM student 
where name Like '��_��' -- / _ ->��� �ѱ��� ������
;

-- NULL ����
-- NULL �� ��Ȯ�� ���̳� ���� ������� ���� ���� �ǹ�
SELECT empno, sal, comm 
FROM emp;

SELECT empno, sal, sal+comm
FROM emp;
-- nvl comm = null�̸� 0���� ����Ұ�
SELECT empno, sal, sal+NVL(comm,0)
FROM emp;

-- ?���� ���̺��� �̸�, ����, ���������� ����Ͽ���
SELECT name, position, comm
FROM professor
;
-- ���� ���̺��� ���������� ���� ������ �̸�, ����, ���������� ����Ͽ���
Select name, position, comm
FROM professor
-- WHERE comm = null Ʋ����� null �϶��� �Ʒ�������� �Ѵ�.
WHERE comm IS null
;
-- ���� ���̺��� �޿��� ���������� ���� ���� 
-- sal_com�̶�� �������� ����Ͽ��� 
-- ������ �̸�, ����, sal , ��������, sal_com �� ���
SELECT name, position,sal,comm, sal+comm as sal_com
FROM professor
;
-- ���� : sal_com �׸��� comm�� NULL�̸� 0�� ���
SELECT name, position,sal,comm, sal+NVL(comm,0) as sal_com
FROM professor
;
-- 102�� �а��� �л� �߿��� 1�г� �Ǵ� 4�г� �л��� �̸�, �г�, �а� ��ȣ�� ����Ͽ���
SELECT name, grade, deptno
FROM student
Where deptno = 102 
AND (grade = 1 OR grade = 4)
;
-- ���� ������
-- ���̺��� �����ϴ� �����տ� ���� ���̺��� �κ� ������ ����� ��ȯ�ϴ� ������
--�պ� ���� : ���� ������ ����� �Ǵ� �� ���̺��� Į������ ����, 
-- �����Ǵ� Į������ ������ Ÿ���� ����

--���� ������
--�ǹ�
--UNION
--�� ���տ� ���� �ߺ��Ǵ� ���� ������ ������
--UNION ALL
--�� ���տ� ���� �ߺ��Ǵ� ���� ������ ������
--MINUS
--�� ���հ��� ������
--INTERSECT
--�� ���հ��� ������

-- 1�г� �̸鼭 �����԰� 70kg �̻��� �л��� ���� --> Table  stud_heavy
CREATE Table stud_heave -- �������� �������� ���̺��� �������
AS -- ����Ʈ�� ���� ���̺��� ������ּ���
SELECT *
FROM student
where grade = 1 and weight >= 70
;
-- 1�г� �̸鼭 101�� �а��� �Ҽӵ� �л�(stud_101)
CREATE Table stud_101
AS
SElECT *
FROM student
where grade = 1 and deptno = 101
;
-- union �ߺ� ���� --> ���� : ���� �÷��� ���� �ƴϴ�
-- Union  �ߺ� ����   (�ڵ��� , ������) + (�ڹ̰� , ������)
SELECT studno , name ,userid
FROM stud_heave
UNION 
SELECT studno, name
FROM stud_101
;
SELECT studno , name
FROM stud_heave
UNION 
SELECT studno, name 
FROM stud_101
;
-- union all �ߺ��Ȱ� ���������� ��� ���Ͷ�
SELECT studno , name
FROM stud_heave
UNION ALL
SELECT studno, name 
FROM stud_101
;
-- Intersect --> ����
SELECT studno , name
FROM stud_heave
INTERSECT
SELECT studno, name 
FROM stud_101
;
-- minus (�ڵ���, ������)-(�ڹ̰�, ������) ���� ��ü ���� ���� ������
SELECT studno , name
FROM stud_heave
MINUS
SELECT studno, name 
FROM stud_101
;

-- ����(sorting)
-- SQL ��ɹ����� �˻��� ����� ���̺� �����Ͱ� �Էµ� ������� ���
-- ������, �������� ��� ������ Ư�� �÷��� �������� �������� �Ǵ� ������������ �����ϴ� ��찡 ���� �߻�
-- ���� ���� Į���� ���� ���� ������ ���ϴ� ��쵵 �߻�
-- ORDER BY : Į���̳� ǥ������ �������� ��� ����� ������ �� ���
-- 1) ASC : ������������ ����, �⺻ ��
-- 2) DESC : ������������ �����ϴ� ��쿡 ���, ���� �Ұ���

-- �л� ���̺��� �̸��� �����ټ����� �����Ͽ� �̸�, �г�, ��ȭ��ȣ�� ����Ͽ���
SELECT name, grade, tel
FROM student
ORDER BY name 
-- ORDER BY name asc ��������, �⺻��
-- ORDER BY name desc ��������
;
-- �л� ���̺��� �г��� ������������ �����Ͽ� �̸�, �г�, ��ȭ��ȣ�� ����Ͽ���
SELECT name, grade, tel
FROM student
ORDER BY grade desc
;
-- ��� ����� �̸��� �޿� �� �μ���ȣ�� ����ϴµ�, 
-- �μ� ��ȣ�� ����� ������ ���� �޿��� ���ؼ��� ������������ �����϶�.
SELECT ename, job, deptno, sal
from emp
ORDER  By deptno, sal DESC
;
-- ���忡�� ���ϸ� hw 
-- ��1)�μ� 10�� 30�� ���ϴ� ��� ����� �̸��� �μ���ȣ�� 
-- �̸��� ���ĺ� ������ ���ĵǵ��� ���ǹ��� �����϶�.
SELECT ename, deptno
FROM emp
where deptno IN (10,30)
ORDER By ename
;
-- ��2) 1982�⿡ �Ի��� ��� ����� �̸��� �Ի����� ���ϴ� ���ǹ�
SELECT ename,hiredate
FROM emp
WHERE hiredate between '82/01/01' and '82/12/31'
-- where to_char(hiredate,'yymmdd')like '82%'
;
-- ��3) ���ʽ��� �޴� ��� ����� ���ؼ� �̸�, �޿� �׸��� ���ʽ��� ����ϴ� ���ǹ��� �����϶�.
--       �� �޿��� ���ʽ��� ���ؼ� �������� ����
SELECT ename, sal, COMM
FROM emp
where comm is not null
ORDER BY sal desc,comm desc
;
-- ��4) ���ʽ��� �޿��� 20% �̻��̰� �μ���ȣ�� 30�� ��� ����� ���ؼ� 
--       �̸�, �޿� �׸��� ���ʽ��� ����ϴ� ���ǹ��� �����϶�
SELECT ename, sal, comm
FROM emp
WHERE deptno = 30 and sal*0.2 <= comm 
;








