-- CRUD
-- 행 추가 
INSERT INTO DEPT 
        VALUES(50,'영업1팀','이대');
  Commit;     
-- 행 수정  dname = null 값이 된다.
UPDATE DEPT
SET dname = '',LOC = '홍대'
WHERE DEPTNO = 50
;


-- 모든 컬럼 출력
SELECT *
-- select dname, loc 작성한 컬럼만 출력
FROM DEPT
;

-- 행 삭제
DELETE DEPT
WHERE DEPTNO = 50
;
Select dname,loc From Dept Where deptno =51;

commit;

Select * From emp
;
-- OR가 없으면 객체를 날려주고 다시 컴파일??
CREATE OR REPLACE Procedure Dept_Insert
(   p_deptno in dept.deptno%type,
    p_dname in dept.dname% type,
    p_loc in dept.loc%Type
)
is
begin
    INSERT INTO DEPT VALUES(p_deptno, p_dname,p_loc);
End;