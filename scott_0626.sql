--SQL �Լ��� ����
-- 1) ���� �� �Լ� : ���̺� ����Ǿ� �ִ� ���� ���� ������� �Լ��� �����Ͽ� �ϳ��� ����� ��ȯ�ϴ� �Լ�
--  ������ ���� �����ϴµ� �ַ� ���    
--  �ະ�� �Լ��� �����Ͽ� �ϳ��� ����� ��ȯ�ϴ� �Լ�

-- ���� �� �Լ�: ���ǿ� ���� ���� ���� �׷�ȭ�Ͽ� �׷캰�� ����� �ϳ��� ��ȯ�ϴ� �Լ�

----------------------------------------------------------
-- 1. ���� �Լ�
-- ���� �����͸� �Է��Ͽ� ���ڳ� ���ڸ� ����� ��ȯ�ϴ� �Լ�

--����
--�ǹ�
--��� ��
--INITCAP
--���ڿ��� ö ��° ���ڸ� �빮�ڷ� ��ȯ
--INITCAP(��student��) �� Student
-- ���ù�)
-- �л� ���̺��� ���迵�ա� �л��� �̸�, ����� ���̵� ����Ͽ���. 
-- �׸��� ����� ���̵��� ù ���ڸ� �빮�ڷ� ��ȯ�Ͽ� ����Ͽ���
SELECT name, userid, INITCAP(userid)
FROM student
where name = '�迵��'
;
-- LOWER
-- ���ڿ� ��ü�� �ҹ��ڷ� ��ȯ
-- LOWER(��STUDENT��) ��student
-- UPPER
-- ���ڿ� ��ü�� �빮�ڷ� ��ȯ
-- UPPER(��student��)��STUDENT
-- ���ù�)
-- �л� ���̺��� �й��� ��20101���� �л��� ����� ���̵� 
-- �ҹ��ڿ� �빮�ڷ� ��ȯ�Ͽ� ���

SELECT userid, LOWER(userid), upper(userid)
FROM student
where studno = '20101'
;

-- ���ڿ� ���� ��ȯ �Լ�
-- 1)LENGTH �Լ��� �μ��� �ԷµǴ� Į���̳� ǥ������ ���ڿ��� ���̸� ��ȯ�ϴ� �Լ��̰�,
-- 2)LENGTHB �Լ��� ���ڿ��� ����Ʈ ���� ��ȯ�ϴ� �Լ��̴�.
-- ���ù�
-- �μ� ���̺��� �μ� �̸��� ���̸� ���� ���� ����Ʈ ���� ���� ����Ͽ���
SELECT dname,LENGTH(dname), LENGTHB(dname)
from dept
;
-- utf-8 �ѱ� 3��Ʈ/ utf-16 �ѱ� 2��Ʈ
-- �ѱ� ���ڿ� ����  Test
INSERT INTO dept VALUES(59,'�濵������','������');
-- ���� dname�� ũ�⸦ �Ѿ�� ������

-- ���� ���� �Լ��� ����
-- CONCAT : �� ���ڿ��� ����, ��||���� ����
SELECT name ||'�� ��å�� ' 
from professor
;
SELECT name ||'�� ��å�� '|| position
from professor
;
SELECT concat(name,'�� ��å�� ')
from professor
;
SELECT concat(concat(name,'�� ��å�� '),position)
from professor
;
-- SUBSTR : Ư�� ���� �Ǵ� ���ڿ� �Ϻθ� ����
-- ���ù�)
-- �л� ���̺��� 1�г� �л��� �ֹε�� ��ȣ���� ������ϰ� �¾ ���� �����Ͽ� 
-- �̸�, �ֹι�ȣ, �������, �¾ ���� ����Ͽ���
-- 1���� 6����Ʈ , 3���� 2����Ʈ
SELECT name, idnum, SUBSTR(idnum,1,6) birth_date,substr(idnum,3,2) birth_mon,substr(idnum,7,1) gender
FROM student
where grade = 1
;
-- INSTR : Ư�� ���ڰ� �����ϴ� ù ��° ��ġ�� ��ȯ
-- ���ù�) 
-- ���ڿ��߿��� ����ڰ� ������ Ư�� ���ڰ� ���Ե� ��ġ�� ��ȯ�ϴ� �Լ�
-- �а�  ���̺��� �μ� �̸� Į������ ������ ������ ��ġ�� ����Ͽ���
select dname, instr(dname,'��')
from department
;
-- LPAD : ������ ������ �������� �������ڸ� ����
-- RPAD :���� ������ ���������� ���� ���ڸ� ����
--LPAD�� RPAD �Լ��� ���ڿ��� ������ ũ�Ⱑ �ǵ��� ���� �Ǵ� �����ʿ� ������ ���ڸ� �����ϴ� �Լ�
-- �������̺��� ���� Į���� ���ʿ� ��*�� ���ڸ� �����Ͽ� 10����Ʈ�� ����ϰ� 
-- ���� ���̵� Į���� �����ʿ� ��+�����ڸ� �����Ͽ� 12����Ʈ�� ���
--               ���ڼ��� �����ؼ� 10����Ʈ�� ä���
SELECT position, LPAD(position, 10, '*') as lpad_position,
       userid, RPAD(userid, 12, '+') as rpad_position
FROM professor;
-- LTRIM : ���� ���� ���ڸ� ����
-- RTRIM : ������ ���� ���ڸ� ����
-- LTRIM�� RTRIM �Լ��� ���ڿ����� Ư�� ���ڸ� �����ϱ� ���� ���
-- �Լ��� �μ����� ������ ���ڸ� �������� ������ ���ڿ��� �յ� �κп� �ִ� ���� ���ڸ� ����
SELECT ' abcdefg ',LTRIM(' abcdefg ',' '),RTRIM(' abcdefg ',' ')
FROM dual -- �ǹ̾��� �ѹ���Ʈ�� �������ִ� ���̺�
;
--  �а� ���̺��� �μ� �̸��� ������ ������ �������� �����Ͽ� ����Ͽ���
SELECT dname,RTRIM(dname,'��')
FROM department
;
------------------------------------------------------------------------------
-- ���� �Լ�(**)
-- ���� �����͸� ó���ϱ� ���� �Լ�
-- 1)ROUND : ������ �Ҽ��� �ڸ��� ���� �ݿø�
-- ������ �ڸ� ���Ͽ��� �ݿø��� ��� ���� ��ȯ�ϴ� �Լ�
-- ���ù�)
-- ���� ���̺��� 101�а� ������ �ϱ��� ���(�� �ٹ����� 22��)�Ͽ� �Ҽ��� ù° �ڸ��� 
-- ��° �ڸ����� �ݿø� �� ���� �Ҽ��� ���� ù° �ڸ����� �ݿø��� ���� ����Ͽ���
--                        �Ҽ��� ù°�ڸ� �ݿø�/ ���ڸ��������� �ݿø�/ �������� �ݿø�
SELECT name, sal, sal/22, ROUND(sal/22),ROUND(sal/22,2),ROUND(sal/22,-1)
FROM professor
WHERE deptno = 101;
-- 2)TRUNC : ������ �Ҽ��� �ڸ����� ����� ���� ����
-- ���ù�)
-- ���� ���̺��� 101�а� ������ �ϱ��� ���(�� �ٹ����� 22��)�Ͽ�
-- �Ҽ��� ù° �ڸ��� ��° �ڸ����� ���� �� ���� 
-- �Ҽ��� ���� ù° �ڸ����� ������ ���� ���
SELECT name, sal, sal/22,TRUNC(sal/22), TRUNC(sal/22,2),TRUNC(sal/22,-1)
FROM professor
WHERE deptno = 101
;
-- 3)MOD : m��n���� ���� ������
-- MOD �Լ��� ������ �����Ŀ� �������� ����ϴ� �Լ� 
-- ���ù�)
-- ���� ���̺��� 101�� �а� ������ �޿��� ������������ ���� �������� ����Ͽ� ����Ͽ���
SELECT name, sal,comm, MOD(sal,comm)
FROM professor
WHERE deptno = 101
;
-- 4)CEIL : ������ ������ ū�� �߿��� ���� ���� ���� = �ø�
-- 5)FLOOR : ������ ������ ������ �߿��� ���� ū ���� = ����
-- CEIL �Լ��� ������ ���ں��� ũ�ų� ���� ���� �߿��� �ּ� ���� ����ϴ� �Լ�
-- FLOOR�Լ��� ������ ���ں��� �۰ų� ���� ���� �߿��� �ִ� ���� ����ϴ� �Լ�
-- ���ù�)
-- 19.7���� ū ���� �߿��� ���� ���� ������ 12.345���� ���� ���� �߿��� ���� ū ������ ����Ͽ���
SELECT CEIL(19.7),FLOOR(12.345)
FROM dual
;

--------------------------------------------------------------------------------
---------------------------------- ��¥ �Լ� *** --------------------------------
--------------------------------------------------------------------------------
-- 1) ��¥ + ���� = ��¥ (��¥�� �ϼ��� ����)
-- ���� ��ȣ�� 9908�� ������ �Ի����� �������� �Ի� 30�� �Ŀ� 60�� ���� ��¥�� ���
--                      ��¥+���� = ��¥�� ������
SELECT name, hiredate, hiredate+30, hiredate+60
FROM professor
WHERE profno = 9908
;
-- 2)SYSDATE �Լ�
-- SYSDATE �Լ��� �ý��ۿ� ����� ���� ��¥�� ��ȯ�ϴ� �Լ��μ�, �� �������� ��ȯ
SELECT sysdate
FROM dual
;
-- 3) ��¥ - ���� = ��¥ (��¥�� �ϼ��� ����)
SELECT name, hiredate, hiredate-30, hiredate-60
FROM professor
WHERE profno = 9908
;
-- 4) ��¥ - ��¥=  �ϼ� (��¥�� ��¥�� ����)
SELECT name, hiredate,sysdate-hiredate
FROM professor
WHERE profno = 9908
;
-- 5) MONTHS_BETWEEN : date1�� date2 "������" ���� ���� ���
--     ADD_MONTHS        : date�� ���� ���� ���� ��¥ ���
--     MONTHS_BETWEEN�� ADD_MONTHS �Լ��� �� ������ ��¥ ������ �ϴ� �Լ� 
--     �Ի����� 120���� �̸��� ������ ������ȣ, �Ի���, �Ի��Ϸ� ���� �����ϱ����� ���� ��,
--     �Ի��Ͽ��� 6���� ���� ��¥�� ����Ͽ���
SELECT profno, hiredate,
       MONTHS_BETWEEN(SYSDATE, hiredate) as working_day,
        --                  6������ ���Ѵ�
       ADD_MONTHS(hiredate, 6)           as hire_6after
FROM professor
WHERE MONTHS_BETWEEN(SYSDATE, hiredate) < 120;


-- 6) TO_CHAR �Լ�
-- TO_CHAR �Լ��� ��¥�� ���ڸ� ���ڷ� ��ȯ�ϱ� ���� ���
-- �л� ���̺��� ������ �л��� �й��� ������� �߿��� ����� ����Ͽ���
-- MM/MONTH/MON/YYYY/YY/DD/DY/DAY
SELECT studno
--                      ���ϴ� ���·� ��� ����
     , TO_CHAR(birthdate, 'YY/MM') as birthdate1
     , TO_CHAR(birthdate, 'YY-MM') as birthdate2
     , TO_CHAR(birthdate, 'YYMM') as birthdate3
     , TO_CHAR(birthdate, 'YYMMdd') as birthdate4
     , TO_CHAR(birthdate, 'YYYY/MM*dd') as birthdate5
     
FROM student
WHERE name = '������';
--2006-10-10, MONTH
SELECT TO_CHAR(sysdate, 'MONTH') as monthDate
FROM dual;


-- 7) 2024-06-26
-- LAST_DAY, NEXT_DAY
-- LAST_DAY �Լ��� "�ش� ��¥�� ���� ���� ������ ��¥�� ��ȯ"�ϴ� �Լ�
-- NEXT_DAY �Լ��� "�ش� ���� �������� ��õ� ������ ���� ��¥�� ��ȯ"�ϴ� �Լ�
-- ������ ���� ���� ������ ��¥�� �ٰ����� �Ͽ����� ��¥�� ����Ͽ���
SELECT sysdate, LAST_DAY(sysdate), NEXT_DAY(sysdate, '��')
FROM dual;


-- 8) ROUND, TRUNC�Լ�
-- LAST_DAY, NEXT_DAY
-- LAST_DAY �Լ��� �ش� ��¥�� ���� ���� ������ ��¥�� ��ȯ�ϴ� �Լ�
-- NEXT_DAY �Լ��� �ش� ���� �������� ��õ� ������ ���� ��¥�� ��ȯ�ϴ� �Լ�
-- ���ù�
-- ������ ���� ���� ������ ��¥�� �ٰ����� �Ͽ����� ��¥�� ����Ͽ���
SELECT sysdate, LAST_DAY(sysdate,'��')
FROM dual
;
-- ROUND, TRUNC �Լ�
SELECT TO_CHAR(sysdate, 'YY/mm/dd HH24:Mi:SS')NORMAL,
       TO_CHAR(sysdate, 'YY/mm/dd HH24:Mi:SS')trunc,
       TO_CHAR(sysdate, 'YY/mm/dd HH24:Mi:SS')round
FROM dual
;
SELECT  name, TO_CHAR(hiredate, 'YY/mm/dd HH24:MI:SS')hiredate,
        TO_CHAR(round(hiredate,'dd'), 'YY/mm/dd')round_dd,
        TO_CHAR(round(hiredate,'mm'), 'YY/mm/dd')round_mm,
        TO_CHAR(round(hiredate,'yy'), 'YY/mm/dd')round_yy       
FROM professor
;
-- cw :TO_CHAR �Լ��� ��¥�� ���ڸ� ���ڷ� ��ȯ�ϱ� ���� ���   ***
-- �л� ���̺��� ������ �л��� �й��� ������� �߿��� ����� ���ڷ� ����Ͽ���
SELECT studno, to_char(birthdate,'yy/mm') birthdate2
FROM student
where name = '������'
;
-- TO_CHAR �Լ��� �̿��� ���� ��� ���� ��ȯ --> 9
-- ����] (1234, ��99999��) --> 1234
-- ���ù�
-- ���ڸ� ���� �������� ��ȯ
-- �� cw02)���������� �޴� �������� �̸�, �޿�, ��������, 
-- �׸��� �޿��� ���������� ���� ���� 12�� ���� ����� ����(anual_sal)���� ���
SELECT name, sal, comm,to_char((comm+sal)*12,'9,999') as anual_sal
FROM professor
Where comm is not null
;
-- ���ڸ� ���ڷ� �ٲ��ִ� ���� ��ȯ
SELECT to_number('123')
From dual
;
-- cw03) student Table���� �ֹε�Ϲ�ȣ���� ��������� �����Ͽ� ���ڡ�YY/MM/DD�� ����
-- ���� BirthDate�� ����Ͽ���
SELECT to_char(to_date(substr(idnum,1,6),'yymmdd'),'yy/mm/dd') BirthDate
FROM student
;
-- cw04) NVL �Լ��� NULL�� 0 �Ǵ� �ٸ� ������ ��ȯ�ϱ� ���� �Լ�
-- 101�� �а� ������ �̸�, ����, �޿�, ��������, �޿��� ���������� �հ踦 ����Ͽ���. 
-- ��, ���������� NULL�� ��쿡�� ���������� 0���� ����Ѵ�
SELECT name, position, sal, comm,sal+NVL(comm,0) s1
        ,NVL(sal+comm,sal) s2
FROM professor
where deptno = 101
;

-------------------------------------------------------------------------------
------------------------------------ Question----------------------------------
-------------------------------------------------------------------------------
-- 1. salgrade ������ ��ü ����
select *
FROM salgrade
;
-- 2. scott ���� ��밡���� ���̺� ����
select *
From tab
;
-- 3. emp Table���� ��� , �̸�, �޿�, ����, �Ի���
select empno, ename, sal, job, hiredate
FROM emp
;
-- 4. emp Table���� �޿��� 2000�̸��� ��� �� ���� ���, �̸�, �޿� �׸� ��ȸ
select empno,ename, sal
FROM emp
WHERE sal< 2000
;
-- 5. emp Table���� 80/02���Ŀ� �Ի��� ����� ����  ���,�̸�,����,�Ի��� 
select empno, ename, job, hiredate
FROM emp
WHERE hiredate > '80/02/01'
;
-- 6. emp Table���� �޿��� 1500�̻��̰� 3000���� ���, �̸�, �޿�  ��ȸ(2����)
select empno,ename,sal
FROM emp
where sal between 1500 and 3000
;
select empno,ename,sal
FROM emp
where sal>= 1500 and  sal <=3000
;
-- 7. emp Table���� ���, �̸�, ����, �޿� ��� [ �޿��� 2500�̻��̰�  ������ MANAGER�� ���]
select empno, ename, job, sal
FROM emp
where job = 'MANAGER' and sal>= 2500
;
-- 8. emp Table���� �̸�, �޿�, ���� ��ȸ 
--    [�� ������  ���� = (�޿�+��) * 12  , null�� 0���� ����]
select ename, sal, (sal+nvl(comm,0))*12 anual_sal
FROM emp
;
--9. emp Table����  81/02 ���Ŀ� �Ի��ڵ��� xxx�� �Ի����� xxX
--  [ ��ü Row ��� ] --> 2���� ��� ��
select ename || ' �� �Ի����� ' || hiredate ||' �̴� '
FROM emp
WHERE hiredate > '81/02/01'
;
select concat(concat(ename,'�� �Ի����� '),hiredate)
FROM emp
WHERE hiredate > '81/02/01'
;
--10.emp Table���� �̸��ӿ� T�� �ִ� ���,�̸� ���
select empno, ename
FROM emp
where ename like '%T%'
;
-- NVL2 �Լ�
-- NVL2 �Լ��� ù ��° �μ� ���� NULL�� �ƴϸ� �� ��° �μ� ���� ����ϰ�, 
--            ù ��° �μ� ���� NULL�̸� �� ��° �μ� ���� ����ϴ� �Լ�
-- ���ù�)
-- 102�� �а� �����߿��� ���������� �޴� ����� �޿��� ���������� 
-- ���� ���� �޿� �Ѿ����� ����Ͽ���. 
-- ��, ���������� ���� �ʴ� ������ �޿��� �޿� �Ѿ����� ����Ͽ���.
SELECT name, position, sal, comm,
        -- null => if    else
        NVL2(comm,sal+comm,sal) total
FROM professor
WHERE deptno = 102
;
-- NULLIF �Լ�
-- NULLIF �Լ��� �� ���� ǥ������ ���Ͽ� ���� �����ϸ� NULL�� ��ȯ�ϰ�,
--              ��ġ���� ������ ù ��° ǥ������ ���� ��ȯ
-- ���ù�)
-- ���� ���̺��� �̸��� ����Ʈ ���� ����� ���̵��� ����Ʈ ���� ���ؼ�
--      ������ NULL�� ��ȯ�ϰ� 
--      ���� ������ �̸��� ����Ʈ ���� ��ȯ
SELECT name, userid, lengthb(name), lengthb(userid),
        NULLIF(lengthb(name),lengthb(userid)) nullif_result
From professor
;
-- DECODE �Լ�
-- DECODE �Լ��� ���� ���α׷��� ���� IF���̳� CASE ������ ǥ���Ǵ� 
-- ������ �˰����� �ϳ��� SQL ��ɹ����� �����ϰ� ǥ���� �� �ִ� ������ ���
-- DECODE �Լ����� �� �����ڴ� ��=���� ����
-- ���ù�)
-- ���� ���̺��� ������ �Ҽ� �а� ��ȣ�� �а� �̸����� ��ȯ�Ͽ� ����Ͽ���. 
-- �а� ��ȣ�� 101�̸� ����ǻ�Ͱ��а���, 102�̸� ����Ƽ�̵���а���, 201�̸� �����ڰ��а���, 
-- ������ �а� ��ȣ�� �������а���(default)�� ��ȯ
-- java ==> if elseif else
SELECT name, deptno, DECODE(deptno, 101, '��ǻ�Ͱ��а�'
                                   ,102,'��Ƽ�̵���а�'
                                   ,201,'���ڰ��а�'
                                        ,'�����а�')
fROM professor
;
-- CASE �Լ�
-- CASE �Լ��� DECODE �Լ��� ����� Ȯ���� �Լ� 
-- DECODE �Լ��� ǥ���� �Ǵ� Į�� ���� ��=�� �񱳸� ���� ���ǰ� ��ġ�ϴ� ��쿡�� �ٸ� ������ ��ġ�� �� ������
-- , CASE �Լ������� ��� ����, ���� ����, �� ����� ���� �پ��� �񱳰� ����
-- ���� WHEN ������ ǥ������ �پ��ϰ� ����
-- 8.1.7�������� �����Ǿ�����, 9i���� SQL, PL/SQL���� �Ϻ��� ���� 
-- DECODE �Լ��� ���� �������� ����ü��� �پ��� �� ǥ���� ���
-- �ε�� ��� ���� 
SELECT name, deptno, case when deptno = 101 then '��ǻ�Ͱ��а�'
                          when deptno = 102 then '��Ƽ�̵���а�'
                          when deptno = 201 then '���ڰ��а�'
                          Else                   '�����а�'
                          END deptname
fROM professor
;
-- decode/case
-- ���� ���̺��� �Ҽ� �а��� ���� ���ʽ��� �ٸ��� ����Ͽ� ����Ͽ���. (���� --> bonus)
-- �а� ��ȣ���� ���ʽ��� ������ ���� ����Ѵ�.
-- �а� ��ȣ�� 101�̸� ���ʽ��� �޿��� 10%, 102�̸� 20%, 201�̸� 30%, ������ �а��� 0%
SELECT name, deptno,decode(deptno, 101, sal*0.1 
                    ,102 , sal*0.2 
                    ,201 , sal*0.3 
                    ,      sal*0) bouns
From professor
;

SELECT name,deptno, case when deptno = 101 then sal*0.1 
                  when deptno = 102 then sal*0.2 
                  when deptno = 201 then sal*0.3 
                  else 0
end bonus
From professor
;
---------------         Home Work           --------------------
-- 1. emp Table �� �̸��� �빮��, �ҹ���, ù���ڸ� �빮�ڷ� ���
select ename, upper(ename)
FROM emp
;
select ename, lower(ename)
FROM emp
;
select ename,initcap(ename)
FROM emp
;
-- 2. emp Table ��  �̸�, ����, ������ 2-5���� ���� ���
select ename, job,substr(job,2,4)
FROM emp
;
-- 3. emp Table �� �̸�, �̸��� 10�ڸ��� �ϰ� ���ʿ� #���� ä���
select ename, Lpad(ename, '10', '#')
FROM emp
;
-- 4. emp Table ��  �̸�, ����, ������ MANAGER�� �����ڷ� ���
Select ename, job, replace(job,'MANAGER','������')
fROM emp
;
-- 5. emp Table ��  �̸�, �޿�/7�� ���� ����, �Ҽ��� 1�ڸ�. 10������   �ݿø��Ͽ� ���
select ename, sal, sal/7, round(sal/7), round(sal/7,1), round(sal/7,-1)
FROM emp
;
--6.  emp Table ��  �̸�, �޿�/7�� ���� �����Ͽ� ���
select ename, trunc(sal/7)
FROM emp
;
--7. emp Table ��  �̸�, �޿�/7�� ����� �ݿø�,����,ceil,floor
select ename, round(sal/7), trunc(sal/7),ceil(sal/7),floor(sal/7)
FROM emp
;
--8. emp Table ��  �̸�, �޿�, �޿�/7�� ������
select ename, sal, mod(sal,7)
FROM emp
;
--9. emp Table �� �̸�, �޿�, �Ի���, �Ի�Ⱓ(���� ����,��)���,  �Ҽ��� ���ϴ� �ݿø�
select ename, sal, hiredate, round(MONTHS_BETWEEN(SYSDATE,hiredate))
                            ,round(sysdate-hiredate)
FROM emp
;
--10.emp Table ��  job �� 'CLERK' �϶� 10% ,'ANALYSY' �϶� 20% 
--                                 'MANAGER' �϶� 30% ,'PRESIDENT' �϶� 40%
--                                 'SALESMAN' �϶� 50% 
--                                 �׿��϶� 60% �λ� �Ͽ� 
--   empno, ename, job, sal, �� �� �λ� �޿��� ����ϼ���(Decode�� ���)
select empno, ename, job, sal, decode(job,'CLERK'       ,sal*1.1
                                         ,'ANALYSY'     ,sal*1.2
                                         ,'MANAGER'     ,sal*1.3
                                         ,'PRESIDENT'   ,sal*1.4
                                         ,'SALESMAN'    ,sal*1.5
                                                        ,sal*1.6
                                                    ) �޿��λ�
FROM emp
;
--   empno, ename, job, sal, �� �� �λ� �޿��� ����ϼ���(CASE�� ���)
select empno, ename, job, sal, case when job = 'CLERK'      then sal*1.1
                                    when job = 'ANALYSY'    then sal*1.2
                                    when job = 'MANAGER'    then sal*1.3
                                    when job = 'PRESIDENT'  then sal*1.4
                                    when job = 'SALESMAN'   then sal*1.5
                                    else                         sal*0.6
                                end �޿��λ�
FROM emp
;
