update dept 
set dname='kk',loc='kk'
where deptno = 59 -- ����
;
--  function �ݵ�� ���ϰ�
-- or repalce �ϴ� ���� ��ü�� �̹� �����ϴ� ��� �ش� ��ü�� ��ü �Ѵٴ� �ǹ�
create or replace Function func_sal
(P_empno in number)
return number 
IS
        vsal emp .sal%type;-- emp table�� sal�� ���� Ÿ��
Begin
 -- ȣ���� ������ ���ư� into
 -- �޿��� 10% �λ�
        Update emp 
        
        SET sal = sal*1.1 
        where empno = P_empno;
        commit;
        SELECT sal 
       
        INTO vsal
        from emp
        where empno = P_empno;
        return vsal;
End;

--SELECT func_sal(7839)
--FROM dual; -- function�� �����ϰ� ������