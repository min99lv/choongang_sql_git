-- ���̺� ����
create table sampleTBL(
    memo varchar2(50)
);
-- �� �߰�
insert into sampletbl values ('7�� ����');
insert into sampletbl values  ('��� ��������');

COMMIT;

select * from sampleTbl;


-- X
-- ������ ����
select * from scott.emp;
zzzzzzzzzzdndhk~~~~~~WGFEJ

-- x --> ok (usertest04�� ���� �Ҵ�)
-- usertest04���� ������ �ο����༭ ��ȸ ������ ����
select * from scott.emp;

-- ok --> x (usertest04�� ������ ȸ��)
select * from scott.emp;

---------------------------------------------------------------
-- X
select * from scott.job3;
-- X --> ok (usertest04�� ���� �Ҵ�)
select * from scott.job3;
grant select on scott.job3 to usertest03;

-- scott ���� ���� ȸ��
select * from scott.job3;
