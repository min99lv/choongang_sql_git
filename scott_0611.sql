-- CRUD
-- �� �߰� 
INSERT INTO DEPT 
        VALUES(50,'����1��','�̴�');
  Commit;     
-- �� ����  dname = null ���� �ȴ�.
UPDATE DEPT
SET dname = '',LOC = 'ȫ��'
WHERE DEPTNO = 50
;


-- ��� �÷� ���
SELECT *
-- select dname, loc �ۼ��� �÷��� ���
FROM DEPT
;

-- �� ����
DELETE DEPT
WHERE DEPTNO = 50
;
Select dname,loc From Dept Where deptno =51;

commit;

Select * From emp
;
-- OR�� ������ ��ü�� �����ְ� �ٽ� ������??
CREATE OR REPLACE Procedure Dept_Insert
(   p_deptno in dept.deptno%type,
    p_dname in dept.dname% type,
    p_loc in dept.loc%Type
)
is
begin
    INSERT INTO DEPT VALUES(p_deptno, p_dname,p_loc);
End;