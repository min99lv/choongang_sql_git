04

-- ���̺� ����
create table sampleTBL4(
    memo varchar2(50)
);
-- �� �߰�
insert into sampletbl4 values ('7�� ����4');
insert into sampletbl4 values  ('��� ��������4');


select * from sampletbl4;
-- XXXXX ������ ȸ���ϰ� resource�� Ŀ��Ʈ ���Ѹ� �־����⶧���� �Ұ��� 
select * from scott.emp;

-- select
-- Ok  -> scott�� ������ �Ҵ�
-- ��ı(���ʽ�)�� student ���� ������ �ִϱ� ���� ���� 
select * from scott.student;

-- update
-- x -> insufficient privileges -> ��ȸ ���Ǹ� ��ı�� �־��⶧���� ������Ʈ �Ұ���
update scott.student
set name = '������'
where studno = '30102';

-- usertest02 ���� ������ �ο����־ ������
select * from scott.emp;

-- �Ҵ�
grant select on scott.emp to usertest03; 


-- ���� ȸ�� emp  usertest03�� ������ ȸ����
revoke select on scott.emp from usertest03; --> ����


-- .��SELECT ���� �ο� ������ ���� �ο� , WITH GRANT OPTION  --> �ϰ� �ض� ���� �ο�
select * from scott.job3;
grant select on scott.job3 to usertest03;


-------------------------
-- system -> usertest04 (systemtbl)
SELECT * FROM system.systemtbl;

-- ���뵿�Ǿ �� �� ���ϰ� ��� ����
SELECT * FROM pub_system;
-- ����� �ý��� ���뵿�Ǿ�
SELECT * FROM systemtbl;

-- scott���� ���� ���뵿�Ǿ� ��������� ��ı�� ��밡�� -> ���뵿�Ǿ�� !!!!! 
select * from privateTBL;


---------------�ý��ۿ��� �ٸ������ -> ���Ǿ� ������ ��
create SYNONYM privateTBL for SYSTEM.privatetbl;
-- ���� ���Ǿ� ��� ��.... 
select * from privateTbL;