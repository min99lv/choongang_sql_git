-------------------------------------------------------------
------------            ��������(Constraint)        ***          ------------
--  ����  : �������� ��Ȯ���� �ϰ����� ����
-- 1. ���̺� ������ ���Ἲ ���������� ���� ����
-- 2. ���̺� ���� ����, ������ ��ųʸ��� ����ǹǷ� ���� ���α׷����� �Էµ� 
--     ��� �����Ϳ� ���� �����ϰ� ����
-- 3. ���������� Ȱ��ȭ, ��Ȱ��ȭ �� �� �ִ� ���뼺
-------------------------------------------------------------

-------------------------------------------------------------
------------            ��������(Constraint)   ����      ***  ------------
-- 1. NOT NULL  : ���� NULL�� ������ �� ����
-- 2. �⺻Ű(primary key) : UNIQUE +  NOT NULL + �ּҼ�  ���������� ������ ����
-- 3. ����Ű(foreign key) :  ���̺� ���� �ܷ� Ű ���踦 ���� ***
-- 4. CHECK : �ش� Į���� ���� ������ ������ ���� ������ ���� ����
-------------------------------------------------------------
-- 1.  ��������(Constraint) ���� ���� ����(subject) ���̺� �ν��Ͻ�
create table subject(
    -- �������Ǹ��� ���� ������ �ý��� �Ϸù�ȣ�� �� --> ������ ���� ����
    -- subno number(5) primary key,
    subno number(5) constraint subject_no_pk primary key,
    subname varchar2(20) constraint subject_name_nn not null,
    term varchar2(1) constraint subject_term_ck check(term in ('1','2')),
    typeGubun varchar2(1)
);

comment on COLUMN subject.subno is '������ȣ';
comment on COLUMN subject.subname is '��������';
comment on COLUMN subject.term is '�б�';

INSERT INTO subject(subno, subname, term, typegubun)
            values(10000,'��ǻ�Ͱ���','1','1');
INSERT INTO subject(subno, subname, term, typegubun)
            values(10001,'DB����','2','1');
INSERT INTO subject(subno, subname, term, typegubun)
            values(10002,'jsp����','1','1');

-- pk constraint --> unique           
-- ���� ��Ȯ�ϰ� �ִ� ��� pk�� �������ǿ� �ɸ��⶧���� ����
INSERT INTO subject(subno, subname, term, typegubun)
            values(10001,'Spring����','1','1');

-- pk constraint --> not null
-- subno�� notnull�̱� ������ �ۼ����� ������ ����             
INSERT INTO subject(subno, term, typegubun)
            values(10003,'1','1');  
            
-- subname NN            
-- subname�� not null �̱⶧���� �ȵȴ�
INSERT INTO subject(subno, term, typegubun)
            values(10003,'1','1'); 
            
-- check constraint --> term
-- term�� ������ ����⶧���� ����
INSERT INTO subject(subno, subname, term, typegubun)
            values(10003,'Spring����3','5','1');
            
-- Table ����� ���Ѱ��� ���� ���� ����
-- Student Table �� idnum�� unique�� ����
-- ���� �ߺ��� Ű�� ������ ���� 
Alter table student
add constraint stud_idnum_uk unique(idnum)
;
-- �� ����
insert into student(studno, name, idnum)
    values(30101,'������','8012301036613')
;
-- idnum --> unique constraint
-- indum unique ������ �� �Ǿ����� Ȯ���ϴ� �ڵ�
insert into student(studno, name, idnum)
    values(30102,'������','8012301036613')
;
-- idnum --> unique�θ� �ɾ��ָ� null�� ����
insert into student(studno, name)
    values(30103,'����÷')
;

-- student table �� name�� not null���� ����
alter table student
modify (name constraint stud_name_nn NOT NULL)
;
--  name�� not null�̹Ƿ� ���� �Է����� ������ ����
-- ���� : cannot insert NULL into ("SCOTT"."STUDENT"."NAME")
INSERT INTO student(studno, idnum)
        VALUES (30103, '8012301036614')
;

-- CONSTRAINT ��ȸ
-- ������ ��ųʸ��� �빮�ڷ� �����ؼ� �빮�ڷ� �������
SELECT constraint_name, constraint_type
FROM user_constraints
WHERE table_name in('SUBJECT','STUDENT')
;--- r �ܷ�Ű

-- fk(�ܷ�Ű)***

delete emp
where empno = 1000;

delete dept
where deptno = 50;

-- ����1. Restrict : �ڽ� ���� ���� �ȵ�  (���� ���� ����)
--    1) ����   Emp Table����  REFERENCES DEPT (DEPTNO) 
--    2) ����   integrity constraint (SCOTT.FK_DEPTNO) violated - child record found
delete dept
where deptno = 50;
-- ����2. Cascading Delete : ���� ����
--    1)���ӻ��� ���� : Emp Table���� REFERENCES DEPT (DEPTNO) ON DELETE CASCADE
-- �θ�, �ڽ� �� �� ����
delete dept
where deptno = 50;
-- ����3.  SET NULL   
--    1) ���� NULL ���� : Emp Table���� REFERENCES DEPT (DEPTNO)  ON DELETE SET NULL
-- �θ�� �������� �ڽ��� null�̵ȴ�
delete dept
where deptno = 50;

rollback;
---------------------------------------------------------------
-----      INDEX      ***
--  �ε����� SQL ��ɹ��� ó�� �ӵ��� ���(*) ��Ű�� ���� Į���� ���� �����ϴ� ��ü
--  �ε����� ����Ʈ�� �̿��Ͽ� ���̺� ����� �����͸� ���� �׼����ϱ� ���� �������� ���
--  [1]�ε����� ����
--   1)���� �ε��� : ������ ���� ������ Į���� ���� �����ϴ� �ε����� ��� �ε��� Ű��
--           ���̺��� �ϳ��� ��� ����
-- �ε����� �����̸Ӹ�Ű�� ���� NULL���� �Ǵ��� �ȵǴ���
CREATE UNIQUE INDEX idx_dept_name
ON department(dname);

INSERT INTO department
            values (300,'�̰�����',10,'kk');
            
--  unique constraint  --> ���� �ε����� �ɸ��µ�, ����ũ���������� ���� �ɸ�
INSERT INTO department (deptno,dname, college, loc) 
            values (301,'�̰�����',10,'kkk2')
;

-- ����� �ε��� birthdate --> constraint X , ���ɿ��� ������ ��ģ��
--   2)����� �ε���
-- ��) �л� ���̺��� birthdate Į���� ����� �ε����� �����Ͽ���
CREATE INDEX idx_stud_birthdate
ON student(birthdate)
;
-- �����ͺ��̽� �߰�
INSERT INTO student(studno, name, idnum,birthdate)
        values(30102,'������','8012301036614', '84/09/16')
;
-- �θ��� ���� ������ ������ ���� �������ǿ� �ɸ��� ����
SELECT * 
FROM student
WHERE birthdate = '84/09/16'
;
--   3)���� �ε���
--   4)���� �ε��� :  �� �� �̻��� Į���� �����Ͽ� �����ϴ� �ε���
--     ��) �л� ���̺��� deptno, grade Į���� ���� �ε����� ����
--          ���� �ε����� �̸��� idx_stud_dno_grade �� ����
CREATE INDEX  idx_stud_dno_grade
ON student(deptno, grade)
;

-- �ε��� �ɸ� ������� sql�� �¿�°��� ���ɸ鿡�� �� ����
-- ����
SELECT *
FROM student
WHERE grade = 2
AND deptno = 101
;
-- ����
SELECT *
FROM student
where deptno = 101
and grade = 2
;

--- Optimizer
--- 1) RBO  2) CBO
-- RBO ����
ALTER SESSION SET OPTIMIZER_MODE=RULE
;

-- ��Ƽ�������� �����ȹ�� �ڵ����� ����
ALTER SESSION set OPTiMIZER_MODE = choose

-- CBO ����
-- ���� ���� �� �ִ� ���θ� �������� ȭ���� ������ �� �ڵ忡 ���ؼ� ����
ALTER SESSION SET OPTiMIZER_MODE = first_rows
-- ��ü������ �� ���������� ȭ���� ������ �� �ڵ忡 ���ؼ� ����
ALTER SESSION set OPTiMIZER_MODE = ALL_rows

-- SQL Optimize
select /* + first_rows*/ ename from emp;
select /* + rule*/ ename from emp;

-- Optimizer ��� Ȯ��
select name, value, isdefault, ismodified, description
from V$SYSTEM_PARAMETER
where name LIKE '%optimizer_mode%'
;

-- [2]�ε����� ȿ������ ��� 
--   1) WHERE ���̳� ���� ���������� ���� ���Ǵ� Į��
--   2) ��ü �������߿��� 10~15%�̳��� �����͸� �˻��ϴ� ���
--   3) �� �� �̻��� Į���� WHERE���̳� ���� ���ǿ��� ���� ���Ǵ� ���
--   4) ���̺� ����� �������� ������ �幮 ���
--   5) ���� �� ���� ���� ���Ե� ���, ���� �������� ���� ���ԵȰ��
---------------------------------------------------------------------------------------------------

-- ���� pk�� ������ deptno -> �ε����� �籸���ϸ� �ȴ�
-- pk�� ������ --> �⺻ Ű ���� ������ ����Ǿ����� �ǹ�
-- �л� ���̺� ������ PK_DEPTNO �ε����� �籸��
-- �籸��  : ������ �ε����� �����ϰ� ���ο� �ε����� �����ϴ� ����
ALTER INDEX PK_DEPTNO REBUILD;

-- 1. index ��ȸ
select index_name, table_name, column_name
from user_ind_columns;

-- 2. index ���� emp(job)
CREATE index idx_emp_job ON emp(job);

-- 3. ��ȸ
ALTER SESSION SET OPTIMIZER_MODE=RULE;
-- �ε����� Ÿ�� ���
select * from emp where job = 'MANAGER'; -- = index OK
-- �ε����� Ÿ�� �ʴ� ���
--���������� ���������� �ε����� Ÿ�� �ʴ�
select * from emp where job <> 'MANAGER'; -- <> index NO
select * from emp where job like '%NA%'; -- like '%NA%' index NO
select * from emp where job like 'MA%'; -- like 'MA%' index OK
select * from emp where upper(job) = 'MANAGER'; -- =�Լ�(�÷�) index NO


--   5)�Լ� ��� �ε���(FBI) function based index
--      ����Ŭ 8i �������� �����ϴ� ���ο� ������ �ε����� Į���� ���� �����̳� �Լ��� ��� ����� 
--      �ε����� ���� ����
--      UPPER(column_name) �Ǵ� LOWER(column_name) Ű����� ���ǵ�
--      �Լ� ��� �ε����� ����ϸ� ��ҹ��� ���� ���� �˻�
CREATE INDEX uppercase_idx ON emp (upper(job));

SELECT * FROM emp where upper(job) ='SALESMAN';

 ---------------------------------------------------------------------------------
-- Ʈ����� ����  ***
-- x
-- COMMIT : Ʈ������� �������� ����
--               Ʈ����ǳ��� ��� SQL ��ɹ��� ���� ����� �۾� ������ ��ũ�� ���������� �����ϰ� 
--               Ʈ������� ����
--               �ش� Ʈ����ǿ� �Ҵ�� CPU, �޸� ���� �ڿ��� ����
--               ���� �ٸ� Ʈ������� �����ϴ� ����
--               COMMIT ��ɹ� �����ϱ� ���� �ϳ��� Ʈ����� ������ �����
--               �ٸ� Ʈ����ǿ��� ������ �� ������ �����Ͽ� �ϰ��� ����
 
-- ROLLBACK : Ʈ������� ��ü ���
--                   Ʈ����ǳ��� ��� SQL ��ɹ��� ���� ����� �۾� ������ ���� ����ϰ� Ʈ������� ����
--                   CPU,�޸� ���� �ش� Ʈ����ǿ� �Ҵ�� �ڿ��� ����, Ʈ������� ���� ����
---------------------------------------------------------------------------------
----------------------------------
-- SEQUENCE ***
-- ������ �ĺ���
-- �⺻ Ű ���� �ڵ����� �����ϱ� ���Ͽ� �Ϸù�ȣ ���� ��ü
-- ���� ���, �� �Խ��ǿ��� ���� ��ϵǴ� ������� ��ȣ�� �ϳ��� �Ҵ��Ͽ� �⺻Ű�� �����ϰ��� �Ҷ� 
-- �������� ���ϰ� �̿�
-- ���� ���̺��� ���� ����  -- > �Ϲ������δ� ������ ��� 
----------------------------------
-- 1) SEQUENCE ����
--CREATE SEQUENCE sequence
--[INCREMENT BY n]
--[START WITH n]
--[MAXVALUE n | NOMAXVALUE]
--[MINVALUE n | NOMINVALUE]
--[CYCLE | NOCYCLE]
--[CACHE n | NOCACHE];
--INCREMENT BY n : ������ ��ȣ�� ����ġ�� �⺻�� 1,  �Ϲ������� ?1 ���
--START WITH n : ������ ���۹�ȣ, �⺻���� 1
--MAXVALUE n : ���� ������ �������� �ִ밪
--MAXVALUE n : ������ ��ȣ�� ��ȯ������ ����ϴ� cycle�� ������ ���, MAXVALUE�� ������ �� ���� �����ϴ� ��������
--CYCLE | NOCYCLE : MAXVALUE �Ǵ� MINVALUE�� ������ �� �������� ��ȯ���� ������ ��ȣ�� ���� ���� ����
--CACHE n | NOCACHE : ������ ���� �ӵ� ������ ���� �޸𸮿� ĳ���ϴ� ������ ����, �⺻���� 20


-- 2) SEQUENCE sample ����
create sequence sample_seq
-- �ɼ�
increment by 1 -- �ϳ� �� ���� 
start with 10000; -- 10000���� ����

-- �ϰ� ������� �� �ִ� ������ȣ ������
select sample_seq.nextval from dual;
-- ���� ��Ű������ ���� ���� ������
select sample_seq.CURRVAL from dual;

-- 3) SEQUENCE sample���� 2 --> �ǻ�뿹��
Create sequence dept_dno_seq 
INCREMENT by 1
start with 76;

-- 4) SEQUENCE dept_dno_seq�� �̿� dept_second �Է� --> �� ��� ����
insert into dept_second
values(dept_dno_seq.NEXTVAL, 'Accounting', 'NEW YORK');

SELECT dept_dno_seq.CURRVAL from dual;

-- 77, 'ȸ��', '�̴�'
insert into dept_second
values(dept_dno_seq.NEXTVAL,'ȸ��','�̴�');
SELECT dept_dno_seq.CURRVAL from dual;

-- 79, '�λ���' ,'���'
insert into dept_second
values(dept_dno_seq.NEXTVAL,'�λ���','���');
SELECT dept_dno_seq.CURRVAL from dual;


-- MAX ��ȯ
insert into dept_second
values((select max(deptno)+1 from dept_second)
                    ,'�濵��'
                    ,'�븲'
);


-- �⺻Ű �̹Ƿ� ���� ����
insert into dept_second
values(dept_dno_seq.NEXTVAL,'�λ���88','���8');
SELECT dept_dno_seq.CURRVAL from dual;
-- �����̸Ӹ��� �ƽ��� �������� ����� ������ ����

-- 4) sequence ����
drop sequence sample_seq;
--5)  Data �������� ���� ��ȸ
select sequence_name, min_value, max_value,increment_by
from user_sequences;


------------------------------------------------------
----               Table ����                     ----
------------------------------------------------------
-- 1.Table ����
create table address
(
    id number(3),
    Name varchar(50),
    addr varchar(100),
    phone varchar(30),
    email varchar(100)
);

insert into address
values (1,'HGDONG','SEOUL','123-4567','gbhong@gmail.com');

---    Homework
-- ��1) address��Ű��/Data �����ϸ�     addr_second Table ����
CREATE table addr_second
as select * from address;

-- ����� �ڵ�                     -- ����� �ȴ�
CREATE table addr_second(id, name, addr, phone, email)
as select * from address;
-- ��2) address��Ű�� �����ϸ�  Data ���� ���� �ʰ�   addr_seven Table ����
CREATE table addr_seven
as select *
from address
where 0 = 1
;
-- ��3) address(�ּҷ�) ���̺��� id, name Į���� �����Ͽ� addr_third ���̺��� �����Ͽ���
CREATE table addr_third
as select id, name 
from address;
-- ��4) addr_second ���̺� �� addr_tmp�� �̸��� ���� �Ͻÿ�
alter table addr_second rename to addr_tmp;
-- ����� �ڵ�
RENAME addr_second to addr_tmp;

------------------------------------------------------------------
-----     ������ ����
-- 1. ����ڿ� �����ͺ��̽� �ڿ��� ȿ�������� �����ϱ� ���� �پ��� ������ �����ϴ� �ý��� ���̺��� ����
-- 2. ���� ������ ������ ����Ŭ ������ ����
-- 3. ����Ŭ ������ ����Ÿ���̽��� ����, ����, ����� ����, ������ ���� ���� ������ �ݿ��ϱ� ����
--    ������ ���� �� ����
-- 4. ����Ÿ���̽� �����ڳ� �Ϲ� ����ڴ� �б� ���� �信 ���� ������ ������ ������ ��ȸ�� ����
-- 5. �ǹ������� ���̺�, Į��, �� ��� ���� ������ ��ȸ�ϱ� ���� ���

------------------------------------------------------------------

------------------------------------------------------------------
-----     ������ ���� ���� ����
-- 1.�����ͺ��̽��� ������ ������ ��ü�� ���� ����
-- 2. ����Ŭ ����� �̸��� ��Ű�� ��ü �̸�
-- 3. ����ڿ��� �ο��� ���� ���Ѱ� ��
-- 4. ���Ἲ �������ǿ� ���� ����
-- 5. Į������ ������ �⺻��
-- 6. ��Ű�� ��ü�� �Ҵ�� ������ ũ��� ��� ���� ������ ũ�� ����
-- 7. ��ü ���� �� ���ſ� ���� ���� ����
-- 8.�����ͺ��̽� �̸�, ����, ������¥, ���۸��, �ν��Ͻ� �̸�


------------------------------------------------------------------
-------     ������ ���� ����
-- 1. USER_ : ��ü�� �����ڸ� ���� ������ ������ ���� ��
-- user_tables�� ����ڰ� ������ ���̺� ���� ������ ��ȸ�� �� �ִ� ������ ���� ��.

select table_name
from user_tables;

select *
from user_catalog;

-- 2. ALL_    : �ڱ� ���� �Ǵ� ������ �ο� ���� ��ü�� ���� ������ ������ ���� ��
select owner, table_name
from all_tables;
-- �ý��ۿ� �ִ� ���̺���� �� ���δ�

-- 3. DBA_   : �����ͺ��̽� �����ڸ� ���� ������ ������ ���� ��
select owner, table_name
from dba_tables;
-- ó���� ��ı�� ��������� dba������ ��⶧���� �� �� �ִ� 
