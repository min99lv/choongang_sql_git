-- 문1) 101번 학과 교수중에서 보직수당을 받는 교수의 수를 출력하여라
-- count(*) = 101번학과의 row의 수 
select count(*), count(comm)
from professor
where deptno = 101
;
--102번 학과 학생들의 몸무게 평균과 합계를 출력하여라
select avg(weight), sum(weight)
from student
where deptno = 102
;
-- 교수 테이블에서 급여의 표준편차와 분산을 출력
select STDDEV(sal), VARIANCE(sal)
from professor
;
-- 학과별  학생들의 인원수, 몸무게 평균과 합계를 출력하여라
select deptno , count(*), avg(weight), sum(weight)
from student
group by deptno
;
-- 교수 테이블에서 학과별로 교수 수와 보직수당을 받는 교수 수를 출력하여라
-- 통계함수와 일반함수는 같이 사용 불가능 group by로 빼주어야 한다 == deptno
select count(*), count(comm)
from professor 
group by deptno
;
-- 교수 테이블에서 학과별로 교수 수와 보직수당을 받는 교수 수를 출력하여라
-- 단 학과별로 교수 수가 2명 이상인 학과만 출력
select deptno, count(*), count(comm) 
from professor
group by deptno
having count(*)>1
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
select deptno, max(hiredate), min(hiredate)
from emp
group by deptno
;
-- 부서별, 직업별 count & sum[급여]    (emp)
select deptno, job, count(*), sum(sal)
from emp
group by deptno, job
;
-- 부서별 급여총액 3000이상 부서번호,부서별 급여최대    (emp)
select deptno, max(sal)
from emp
group by deptno
having sum(sal)>=3000
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
select deptno, sum(sal)
from professor
group by rollup(deptno)
;
-- ex2) ROLLUP 연산자를 이용하여 학과 
--      및 직급별 교수 수, 학과별 교수 수, 전체 교수 수를 출력하여라
select deptno, position, count(*)
from professor
group by rollup(deptno, position)
;
-- CUBE 연산자
-- ROLLUP에 의한 그룹 결과와 GROUP BY 절에 기술된 조건에 따라 
-- 그룹 조합을 만드는 연산자
-- ex1) CUBE 연산자를 이용하여 학과 및 직급별 교수 수, 학과별 교수 수, 전체 교수 수를 출력하여라.
select deptno, position, count(*)
from professor
group by cube(deptno, position)
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
-- 몸무게가 80kg이상인 학생의 학번, 이름, 체중, 학과 이름, 학과위치를 출력
select studno, name, weight, deptno, loc
-- 카티션 곱 : 두 개 이상의 테이블에 대해 연결 가능한 행을 모두 결합
-- 1) 개발자 실수
-- 2) 개발초기에 많은 Data 생성

-- NATURAL JOIN을 이용하여 교수 번호, 이름, 학과 번호, 학과 이름을 출력하여라

-- NATURAL JOIN을 이용하여 4학년 학생의 이름, 학과 번호, 학과이름을 출력하여라

-- 문1) JOIN ~ USING 절을 이용하여 학번, 이름, 학과번호, 학과이름, 학과위치를
--       출력하여라
 

