update dept 
set dname='kk',loc='kk'
where deptno = 59 -- 조건
;
--  function 반드시 리턴값
-- or repalce 하는 이유 객체가 이미 존재하는 경우 해당 객체를 대체 한다는 의미
create or replace Function func_sal
(P_empno in number)
return number 
IS
        vsal emp .sal%type;-- emp table에 sal와 같은 타입
Begin
 -- 호출한 곳으로 돌아감 into
 -- 급여의 10% 인상
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
--FROM dual; -- function만 실행하고 싶을때