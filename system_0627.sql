--------------------------------------------------------------------------------
---   8장. 그룹함수 **
---   테이블의 전체 행을 하나 이상의 컬럼을 기준으로 그룹화하여
---   그룹별로 결과를 출력하는 함수
--      그룹함수는 통계적인 결과를 출력하는데 자주 사용
--------------------------------------------------------------------------------
-- SELECT  column, group_function(column)
-- FROM  table
-- [WHERE  condition]
-- [GROUP BY  group_by_expression]
-- [HAVING  group_condition]
-- ? GROUP BY : 전체 행을 group_by_expression을 기준으로 그룹화
-- ? HAVING : GROUP BY 절에 의해 생성된 그룹별로 조건 부여

--  종류 의미
--  COUNT : 행의 개수 출력
--  MAX : NULL을 제외한 모든 행에서 최대 값
--  MIN : NULL을 제외한 모든 행에서 최소 값
--  SUM : NULL을 제외한 모든 행의 합
--  AVG : NULL을 제외한 모든 행의 평균 값
--------------위 필수 ------------아래 구글링-------------------------------------
--  STDDEV : NULL을 제외한 모든 행의 표준편차
--  VARIANCE : NULL을 제외한 모든 행의 분산 값
--  GROUPING : 해당 칼럼이 그룹에 사용되었는지 여부를 1 또는 0으로 반환
--  GROUPING SETS : 한 번의 질의로 여러 개의 그룹화 기능
-- 1) COUNT 함수
-- 테이블에서 조건을 만족하는 행의 갯수를 반환하는 함수
-- 문1) 101번 학과 교수중에서 보직수당을 받는 교수의 수를 출력하여라
-- count(*) = 101번학과의 row의 수 
select count(*),count(comm)
from professor
where deptno = 101
;
--102번 학과 학생들의 몸무게 평균과 합계를 출력하여라
select avg(weight),sum(weight)
from student
where deptno = 102
;
-- 교수 테이블에서 급여의 표준편차와 분산을 출력
select stddev(sal),variance(sal)
from professor
;
-- 학과별  학생들의 인원수, 몸무게 평균과 합계를 출력하여라
select deptno, count(*), avg(weight), sum(weight)
from student
group by deptno
;
-- 교수 테이블에서 학과별로 교수 수와 보직수당을 받는 교수 수를 출력하여라
-- 통계함수와 일반함수는 같이 사용 불가능 group by로 빼주어야 한다 == deptno
select deptno, count(*),count(comm)
from professor
group by deptno
;
-- 교수 테이블에서 학과별로 교수 수와 보직수당을 받는 교수 수를 출력하여라
-- 단 학과별로 교수 수가 2명 이상인 학과만 출력
select deptno, count(*), count(comm)
from professor
group by deptno
having COUNT(*)> 1  -- group by 조건문은 having 사용해야한다.
;
-- 학생 수가 4명이상이고 평균키가 168이상인  학년에 대해서 학년, 학생 수, 평균 키, 평균 몸무게를 출력
-- 단, 평균 키와 평균 몸무게는 소수점 두 번째 자리에서 반올림 하고, 
-- 출력순서는 평균 키가 높은 순부터 내림차순으로 출력하고 
-- 그 안에서 평균 몸무게가 높은 순부터 내림차순으로 출력
select grade, count(*), round(avg(height),1) 평균키, round(avg(weight),1) 평균몸무게
from student
group by grade
having count(*)>=4 and round(avg(height))>= 168
order by 평균키 desc, 평균몸무게 desc
;
--  최근 입사 사원과 가장 오래된 사원의 입사일 출력 (emp)
select max(hiredate), min(hiredate)
from emp
;
--  부서별 최근 입사 사원과 가장 오래된 사원의 입사일 출력 (emp)
select deptno,min(hiredate), max(hiredate)
from emp
group by deptno
;
-- 부서별, 직업별 count & sum[급여]   (emp)
select deptno, job,count(*),sum(sal)
from emp
group by deptno, job
order by deptno, job
;
-- 부서별 급여총액 3000이상 부서번호,부서별 급여최대    (emp)
select deptno, max(sal)
from emp
GROUP by deptno
having sum(sal)>= 3000
order by deptno
;
-- 전체 학생을 소속 학과별로 나누고, 같은 학과 학생은 다시 학년별로 그룹핑하여, 
--   학과와 학년별 인원수, 평균 몸무게를 출력, 
-- (단, 평균 몸무게는 소수점 이하 첫번째 자리에서 반올림 )  STUDENT
select deptno,grade, count(*), round(avg(weight))
from student
group by deptno, grade
order by deptno, grade
;
-- ROLLUP 연산자
-- GROUP BY 절의 그룹 조건에 따라 전체 행을 그룹화하고
--          각 그룹에 대해 부분합을 구하는 연산자
-- ex1) 소속 학과별로 교수 급여 합계와 모든 학과 교수들의 급여 합계를 출력하여라
select deptno,sum(sal)
FROM professor
group by rollup(deptno)
;
-- ex2) ROLLUP 연산자를 이용하여 학과 
--      및 직급별 교수 수, 학과별 교수 수, 전체 교수 수를 출력하여라
select deptno, position, count(*)
from professor
GROUP by rollup(deptno, position)
;
-- CUBE 연산자
-- ROLLUP에 의한 그룹 결과와 GROUP BY 절에 기술된 조건에 따라 
-- 그룹 조합을 만드는 연산자
-- ex1) CUBE 연산자를 이용하여 학과 및 직급별 교수 수, 학과별 교수 수, 전체 교수 수를 출력하여라.
select deptno, position,count(*)
from professor
GROUP by cube(deptno, position)
;
--------------------------------------------------------------------------------
----    9-0.    DeadLock     ---------
--------------------------------------------------------------------------------
-- Transaction A --> developer
-- 트랜잭션 db관점 : 동시에 커밋되거나 롤백 되기위한 요소 / 
-- 1) Smith  - 1 오라클 실행
Update emp  -- 자원 1
SET sal = sal * 1.1
WHERE empno = 7369
;
-- 2) KING -- A가 자원 2요구
Update emp
SET sal = sal * 1.1
WHERE empno = 7839
;
-- Transation B
-- 2. sqlplus 실행
Update emp
SET comm = 500 -- 자원2
WHERE empno = 7839
;
Update emp -- 자원1 요구
SET comm = 300
WHERE empno = 7369
;

insert into dept Values(72,'kk','kk')
;
commit;
----------------------------------------------------------------------
----                    9-1.     JOIN       ***                                           ---------
----------------------------------------------------------------------
-- 1) 조인의 개념
--  하나의 SQL 명령문에 의해 여러 테이블에 저장된 데이터를 한번에 조회할수 있는 기능
-- ex1-1) 학번이 10101인 학생의 이름과 소속 학과 이름을 출력하여라
select studno, name, deptno
from student
where studno = 10101
;
-- ex1-2)학과를 가지고 학과이름
select dname
from department
where deptno = 101
;
-- ex1-3) [ex1-1]+[ex1-2]한방 조회 --> join
select studno, name, student.deptno, department.dname
from student, department
where student.deptno = department.deptno
;
-- 애매모호성 (ambiguously) --> 별명 명시
SELECT studno, name,deptno, dname
FROM student s, department d
WHERE s.deptno = d.deptno
;   
-- 애매모호성 (ambiguously) --> 해결: 별명(alias)
-- 권장 alias문 전체 걸어주는 것 
SELECT s.studno, s.name,d.deptno, d.dname
FROM student s, department d
WHERE s.deptno = d.deptno
;   
-- 전인하 학생의 학번, 이름, 학과 이름 그리고 학과 위치를 출력
select s.studno, s.name, d.dname, d.loc
FROM student s, department d
WHERE s.deptno = d.deptno 
and s.name = '전인하'
;
-- 몸무게가 80kg이상인 학생의 학번, 이름, 체중, 학과 이름, 학과위치를 출력
select s.studno, s.name, s.weight, d.dname, d.loc
FROM student s, department d
WHERE s.deptno = d.deptno and s.weight>= 80
;
-- 카티션 곱 : 두 개 이상의 테이블에 대해 연결 가능한 행을 모두 결합
-- 1) 개발자 실수
-- 2) 개발초기에 많은 Data 생성
SELECT s.studno, s.name,d.dname, d.loc,s.weight,d.deptno
FROM student s, department d
-- where 조건이 없다 단순히 호출한 뿐...
-- 7 * 17 = 119
;
SELECT s.studno, s.name,d.dname, d.loc,s.weight,d.deptno
FROM student s
CROSS JOIN department d
;
-- *** equi join
-- 조인 대상 테이블에서 공통 칼럼을 ‘=‘(equal) 비교를 통해 같은 값을 
-- 가지는 행을 연결하여 결과를 생성하는 조인 방법
--  SQL 명령문에서 가장 많이 사용하는 조인 방법
-- 자연조인을 이용한 EQUI JOIN
-- 오라클 9i 버전부터 EQUI JOIN을 자연조인이라 명명
-- WHERE 절을 사용하지 않고  NATURAL JOIN 키워드 사용
-- 오라클에서 자동적으로 테이블의 모든 칼럼을 대상으로 공통 칼럼을 조사 후, 
-- 내부적으로 조인문 생성
-- 키워드를 사용하지 않은 join

-- 오라클 JOIN 표기법
SELECT s.studno, s.name,d.deptno,d.dname
FROM student s, department d
WHERE s.deptno = d.deptno
;
-- ANSI 표기법
-- Natural Join Convert Error 해결 
-- NATURAL JOIN시 조인 애트리뷰트에 테이블 별명을 사용하면 오류가 발생
SELECT s.studno, s.name, s.weight, d.dname, d.loc, d.deptno
FROM student s 
     NATURAL JOIN department d
;                                        --join할 컬럼에 대한 공통 컬럼 별명 제외
SELECT s.studno, s.name, s.weight, d.dname, d.loc, deptno
FROM student s 
     NATURAL JOIN department d
;
-- NATURAL JOIN을 이용하여 교수 번호, 이름, 학과 번호, 학과 이름을 출력하여라
SELECT p.profno,p.name, deptno, d.dname
FROM professor p
natural join department d
;
-- NATURAL JOIN을 이용하여 4학년 학생의 이름, 학과 번호, 학과이름을 출력하여라
SELECT s.name, s.grade, deptno, d.dname
FROM student s
    natural join department d
where s.grade = '4'
;
-- JOIN ~ USING 절을 이용한 EQUI JOIN
-- USING절에 조인 대상 칼럼을 지정
-- 칼럼 이름은 조인 대상 테이블에서 동일한 이름으로 정의되어 있어야함
-- 문1) JOIN ~ USING 절을 이용하여 학번, 이름, 학과번호, 학과이름, 학과위치를
--       출력하여라
select s.studno, s.name, deptno, dname
FROM student s JOIN department
    using(deptno)
;
-- EQUI JOIN의 4가지 방법을 이용하여 성이 ‘김’씨인 학생들의 이름, 학과번호,학과이름을 출력
-- 1) 오라클 조인 기법 where 절
select s.studno,s.name, d.deptno, d.dname
FROM student s, department d
where s.deptno = d.deptno 
and s.name like '김%'
;
-- 2) natural 조인 기법
select s.studno, s.name,deptno, dname
FROM student s NATURAL join department d
where s.name like '김%'
;
-- 3) join using 기법
select s.studno,s.name, deptno, d.dname
FROM student s join department d
        using(deptno)
where s.name like '김%'
;
-- 4)ANSI JOIN(INNER JOIN ~ ON)
select s.studno,s.name, d.deptno,dname
FROM student s inner join department d
on s.deptno = d.deptno
where s.name like '김%'
;    
-- NON-EQUI JOIN ** == 범위 조인
-- ‘<‘,BETWEEN a AND b 와 같이 ‘=‘ 조건이 아닌 연산자 사용
-- 교수 테이블과 급여 등급 테이블을 NON-EQUI JOIN하여 
-- 교수별로 급여 등급을 출력하여라
CREATE TABLE "SCOTT"."SALGRADE2" 
   (	
        "GRADE" NUMBER(2,0), 
     	"LOSAL" NUMBER(5,0), 
    	"HISAL" NUMBER(5,0)
  )
;
-- 범위 조인
SELECT p.profno, p.name, p.sal, s.grade
FROM professor p, salgrade2 s
WHERE p.sal BETWEEN s.losal AND s.hisal
;
-- OUTER JOIN  ***
-- EQUI JOIN에서 양측 칼럼 값중의 하나가 NULL 이지만 조인 결과로 출력할 필요가 있는 경우
-- equi join 사용
select s.name, s.grade, p.name, p.position
from student s, professor p
where s.profno = p.profno
;
-- 학생 테이블과 교수 테이블을 조인하여 이름, 학년, 지도교수의 이름, 직급을 출력
-- 단, 지도교수가 배정되지 않은 학생이름도 함께 출력하여라.
-- orcle left outer join 사용
select s.name, s.grade, p.name, p.position
from student s, professor p
where s.profno = p.profno(+) -- 오른쪽에 걸어주는것 left outer join
-- 스튜던트 테이블 기준으로 profno = null이 걸린 테이블 다 나옴
;
-- ansi outer join
-- 1. ansi left outer join
select s.studno, s.name, s.profno, p.name
from student s
    left outer join professor p
    on s.profno = p.profno
;

--학생 테이블과 교수 테이블을 조인하여 이름, 학년, 지도교수 이름, 직급을 출력
-- 단, 지도학생을 배정받지 않은 교수 이름도 함께 출력하여라
-- oracle right outer join
select s.name,s.grade, p.name,p.position
from student s, professor p
where s.profno(+) = p.profno
order by p.profno
; -- 지도교수중에서 학생을 할당 받지 못한 교수님 출력
-- professor 기준으로 student에 거론되지 않은 교수들이 +해서 출력됨
--- ANSI OUTER JOIN
-- 1. ANSI RIGHT  OUTER JOIN
SELECT s.studno, s.name, s.profno, p.name
FROM student s
    RIGHT OUTER JOIN professor p
    ON s.profno = p.profno
;
---- <<<   FULL OUTER JOIN  >>> -------------------------------
--학생 테이블과 교수 테이블을 조인하여 이름, 학년, 지도교수 이름, 직급을 출력
-- 단, 지도학생을 배정받지 않은 교수 이름 및 
--  지도교수가 배정되지 않은 학생이름  함께 출력하여라
-- ORCLE JOIN 
--  Oracle 지원 안 함.......
SELECT s.name, s.grade, p.name,p.position
FROM student s, professor p
WHERE s.profno(+) = p.profno(+)
ORDER BY p.profno
;

-- FULL OUTER 모방 --> UNION
select s.name, s.grade, p.name,p.position
FROM student s, professor p
where s.profno = p.profno(+)
union
select s.name, s.grade, p.name, p.position
FROM student s, professor p
WHERE s.profno(+) = p.profno
;
-- 3. ANSI FULL OUTER JOIN
SELECT s.studno, s.name, s.profno,p.name
FROM student s
    FULL outer JOIN professor p
    ON s.profno = p.profno
;
-------                    SELF JOIN   **           ----------------       
-- 하나의 테이블내에 있는 칼럼끼리 연결하는 조인이 필요한 경우 사용
-- 조인 대상 테이블이 자신 하나라는 것 외에는 EQUI JOIN과 동일
SELECT c.deptno, c.dname,c.college, d.dname college_name
    -- 학과             학부
FROM department c, department d
WHERE c.college = d.deptno
;

-- SELF JOIN --> 부서 번호가 201 이상인 부서 이름과 상위 부서의 이름을 출력
-- 결과 : xxx소속은 xxx학부
select concat(dept.dname, ' 소속은 ')|| concat(org.dname, '이다')
--select dept.dname || '의 소속은' || org.dname || '이다'
FROM department dept, department org
where dept.college = org.deptno 
and dept.deptno >= 201
;
-- hw (inner)
-- 1. 이름, 관리자명(관리자이름)(emp TBL) self - join
select e1.ename, e2.ename 관리자명
from emp e1, emp e2
where e1.empno = e2.mgr
;
-- 2. 이름,급여,부서코드,부서명,근무지, 관리자 명, 전체직원(emp ,dept TBL)
select e.ename 이름, e.sal, e.deptno, d.dname, d.loc, e2.ename 관리자명
        , (SELECT COUNT (*) FROM emp) 전체직원수
from emp e, dept d, emp e2
where e.deptno = d.deptno and e.empno = e2.empno
;
-- 3. 이름,급여,등급,부서명,관리자명, 급여가 2000이상인 사람
--    (emp, dept,salgrade TBL)
select e.ename, e.sal,s.grade,d.dname, e2.ename 관리자명 
from emp e, dept d, salgrade s ,emp e2
where e.deptno = d.deptno and e.sal > 2000
    and e.empno = e2.empno 
;
-- 4. 보너스를 받는 사원에 대하여 이름,부서명,위치를 출력하는 SELECT 문장을 작성emp ,dept TBL)
select e.ename, d.dname, d.loc
from emp e, dept d
where e.deptno = d.deptno and e.comm is not null
;
-- 5. 사번, 사원명, 부서코드, 부서명을 검색하라. 사원명기준으로 오름차순정열(emp ,dept TBL)
select e.empno, e.ename, e.deptno, d.dname
from emp e, dept d
where e.deptno = d.deptno 
order by e.ename
;