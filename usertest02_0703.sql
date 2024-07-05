create table sampleTBL(
    memo varchar2(50)
);

-- ���̺� �����̽� ������ ��� �Ұ���
-- "no privileges on tablespace '%s'"

-- X 
-- ���̺� �����̽� ������ ���� �Ұ���
select * from scott.emp;

-- ok
-- ��ı�� ����Ʈ ������ ��
select * from scott.emp;

-- �׷�Ʈ ������ with grant option ���Ѻο� ���Ҵ� ����
grant select on scott.emp to usertest04 with grant option;



-- OK ��ı���� ���Ѻο�
select * from scott.stud_101;


-- ��ı���� ���Ѻο��� �޾��� �� with grant option�� ������ �ʾұ� ������ ���� �ο� �Ұ���
-- ���� �����
-- ���� ORA-01031: insufficient privileges
-- .��SELECT ���� �ο� ������ ���� �ο� , WITH GRANT OPTION  --> �ϰ� �ض� ���� �ο�
grant select on scott.stud_101 to usertest04;
GRANT SELECT on scott.stud_101 TO usertest02;

-- .��SELECT ���� �ο� ������ ���� �ο� , WITH GRANT OPTION  --> �ϰ� �ض� ���� �ο�
select * from scott.job3;
grant select on scott.job3 to usertest04 with grant option;

--   X ���� ȸ�� ����
select * from scott.job3;