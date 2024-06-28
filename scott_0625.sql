-- 스캇에 있는 모든 테이블들을 보여줘
SELECT * FROM tab;

-- dept 테이블에 대한 구조 조회
DESC dept;

-- dept테이블에 --> deptno, loc 출력
SELECT DEPTNO, LOC 
FROM DEPT;

-- 부서 테이블에서 부서이름과 부서 번호를 출력하라
SELECT DNAME,DEPTNO 
FROM DEPT;
-- 키워드는 대문자 사용권장
-- 테이블명 컬럼이름은 소문자

-- 학생 테이블에서 중복되는 학과 번호(deptno)를 제외하고 출력하여라 --> distinct
SELECT DISTINCT deptno 
FROM student;

--  컬럼 별명 부여 방법
--  칼럼 이름과 별명 사이에 공백을 추가하는 방법
--  칼럼 이름과 별명 사이에 AS 키워드를 추가하는 방법
--  큰따옴표를 사용하는 방법
--  칼럼 이름과 별명 사이에 공백을 추가하는 경우
--  특수문자를 추가하거나 대소문자를 구분하는 경우
-- ex) 부서 테이블에서 부서 이름 칼럼의 별명은 dept_name, 
--     부서 번호 칼럼의 별명은 DN으로 부여하여 출력하여라// 띄어쓰기 새이름, As 새이름
SELECT dname dept_name, deptno As dn
FROM department;

-- 합성(concatenation)연산자 --> ||
-- 하나의 칼럼과 다른 칼럼, 산술 표현식 또는 상수 값과 연결하여 하나의 칼럼처럼 출력할 경우에 사용
-- ex)학생 테이블에서 학번과 이름 칼럼을 연결하여 “StudentAli”라는 별명으로 하나의 칼럼처럼 연결하여 출력하여라
SELECT studno || ' ' || name "StudentAli"
FROM student;

-- hw1/학생의 몸무게를 pound로 환산하고 칼럼 이름을 ‘weight_pound’ 라는 별명으로 출력하여라. 1kg은 2.2pound
-- 출력 내용은 이름, 몸무게, weight_pound 
SELECT name, weight, weight*2.2 AS weigh_pound
FROM student;

-- Char 와 VarChar 비교 예시
CREATE TABLE ex_type
(c char(10), 
 v VARCHAR2(10)
 );
 
INSERT INTO ex_type
VALUES('sql','sql');
commit;

SELECT * 
FROM ex_type
WHERE c = 'sql'
;

SELECT * 
FROM ex_type
WHERE v = 'sql'
;
-- c 와 v의 블랭크.. 둘이 다름
SELECT * 
FROM ex_type
WHERE v = c
;
-- 블랭크가 있을때 공백을 제거 하는 예약어 trim
SELECT * 
FROM ex_type
WHERE v = trim(c)
;

 

-- 조건절 검색 --> where절 밑 condition 
-- WHERE절
-- 테이블에 저장된 데이터중에서 원하는 데이터만 선택적으로 검색하는 기능
-- WHERE 절의 조건문은 칼럼 이름, 연산자, 상수, 산술 표현식을 결합하여 다양한 형태로 표현 가능
-- WHERE 절에서 사용하는 데이터 타입은 문자, 숫자, 날짜 타입 사용 가능
-- 문자와 날짜 타입의 상수 값은 작은 따옴표(‘’)로 묶어서 표현하고 숫자는 그대로 사용
-- 상수 값에서 영문자는 대소문자를 구별

-- 학생 테이블에서 1학년 학생만 검색하여 학번, 이름, 학과 번호를 출력하여라
SELECT studno, name, deptno 
FROM student
Where grade = '1' -- 최신버전 데이터타입 '1' 로 표현 가능
;

SELECT studno, name, deptno 
FROM student
Where grade = to_number('1')
;
-- 연산자 조건절
-- 학생 테이블에서 몸무게가 70kg 이하인 학생만 검색하여 학번, 이름, 학년, 학과번호, 몸무게를 출력하여라.
SELECT studno, name, grade, deptno, weight
FROM student
Where weight <= 70
;
-- 논리 연산자 
-- 학생 테이블에서 1학년 이면서 몸무게가 70kg 이상인 학생만 검색하여 이름, 학년, 몸무게, 학과번호를 출력하여라
SELECT studno, name, grade, deptno, weight
FROM student
Where weight >= 70
And grade = 1
;

-- ?학생 테이블에서 1학년이거나 몸무게가 70kg 이상인 학생만 검색하여 이름, 학년, 몸무게, 학과번호를 출력하여라.
SELECT studno, name, grade, deptno, weight
FROM student
Where weight >= 70
OR grade = 1
;
-- BETWEEN** 연산자를 사용하여 몸무게가 50kg에서 70kg 사이인 학생의 학번, 이름, 몸무게를 출력하여라
SELECT studno, name, weight
FROM student
Where weight BETWEEN 50 and 70
;
-- 학생테이블에서 81년에서 83년도에 태어난 학생의 이름과 생년월일을 출력해라
SELECT name, birthdate
FROM student
where birthdate BETWEEN '81/01/01' and '83/12/31'
-- where birthdate between to_date('810101') and to_date('831231')
;

-- IN* 연산자를 사용하여 102번 학과와 201번 학과 학생의 이름, 학년, 학과번호를 출력하여라
SELECT name, grade, deptno
FROM student
where deptno in(102,201)
-- where deptno = 102 or deptno = 201
;
-- LIKE 연산자
-- 칼럼에 저장된 문자열중에서 LIKE 연산자에서 지정한 문자 패턴과 
-- 부분적으로 일치하면 참이 되는 연산자
-- ex)학생 테이블에서 성이 ‘김’씨인 학생의 이름, 학년, 학과 번호를 출력하여라'_%'
SELECT name, grade, deptno
FROM student
where name Like '김%'
;
-- 이름중 '진' 앞뒤는 상관없이 
SELECT name, grade, deptno
FROM student
where name Like '%진%'
;
-- 이름중 끝이 '진'
SELECT name, grade, deptno
FROM student
where name Like '%진'
;
-- 학생 테이블에서 이름이 3글자, 성은 ‘김’씨고 마지막 글자가
-- ‘영’으로 끝나는 학생의 이름, 학년, 학과 번호를 출력하여라
SELECT name, grade, deptno
FROM student
where name Like '김%영'
;

SELECT name, grade, deptno
FROM student 
where name Like '김_영' -- / _ ->가운데 한글자 여야함
;

-- NULL 개념
-- NULL 은 미확인 값이나 아직 적용되지 않은 값을 의미
SELECT empno, sal, comm 
FROM emp;

SELECT empno, sal, sal+comm
FROM emp;
-- nvl comm = null이면 0으로 취급할게
SELECT empno, sal, sal+NVL(comm,0)
FROM emp;

-- ?교수 테이블에서 이름, 직급, 보직수당을 출력하여라
SELECT name, position, comm
FROM professor
;
-- 교수 테이블에서 보직수당이 없는 교수의 이름, 직급, 보직수당을 출력하여라
Select name, position, comm
FROM professor
-- WHERE comm = null 틀린방법 null 일때는 아래방법으로 한다.
WHERE comm IS null
;
-- 교수 테이블에서 급여에 보직수당을 더한 값은 
-- sal_com이라는 별명으로 출력하여라 
-- 교수의 이름, 직급, sal , 보직수당, sal_com 을 출력
SELECT name, position,sal,comm, sal+comm as sal_com
FROM professor
;
-- 조건 : sal_com 항목은 comm이 NULL이면 0로 취급
SELECT name, position,sal,comm, sal+NVL(comm,0) as sal_com
FROM professor
;
-- 102번 학과의 학생 중에서 1학년 또는 4학년 학생의 이름, 학년, 학과 번호를 출력하여라
SELECT name, grade, deptno
FROM student
Where deptno = 102 
AND (grade = 1 OR grade = 4)
;
-- 집합 연산자
-- 테이블을 구성하는 행집합에 대해 테이블의 부분 집합을 결과로 반환하는 연산자
--합병 가능 : 집합 연산의 대상이 되는 두 테이블의 칼럼수가 같고, 
-- 대응되는 칼럼끼리 데이터 타입이 동일

--집합 연산자
--의미
--UNION
--두 집합에 대해 중복되는 행을 제외한 합집합
--UNION ALL
--두 집합에 대해 중복되는 행을 포함한 합집합
--MINUS
--두 집합간의 차집합
--INTERSECT
--두 집합간의 교집합

-- 1학년 이면서 몸무게가 70kg 이상인 학생의 집합 --> Table  stud_heavy
CREATE Table stud_heave -- 셀렉터한 문장으로 테이블이 만들어짐
AS -- 셀렉트랑 같이 테이블을 만들어주세요
SELECT *
FROM student
where grade = 1 and weight >= 70
;
-- 1학년 이면서 101번 학과에 소속된 학생(stud_101)
CREATE Table stud_101
AS
SElECT *
FROM student
where grade = 1 and deptno = 101
;
-- union 중복 제거 --> 에러 : 동일 컬럼의 수가 아니다
-- Union  중복 제거   (박동진 , 서재진) + (박미경 , 서재진)
SELECT studno , name ,userid
FROM stud_heave
UNION 
SELECT studno, name
FROM stud_101
;
SELECT studno , name
FROM stud_heave
UNION 
SELECT studno, name 
FROM stud_101
;
-- union all 중복된거 빠지지말고 모두 나와라
SELECT studno , name
FROM stud_heave
UNION ALL
SELECT studno, name 
FROM stud_101
;
-- Intersect --> 공통
SELECT studno , name
FROM stud_heave
INTERSECT
SELECT studno, name 
FROM stud_101
;
-- minus (박동진, 서재진)-(박미경, 서재진) 빼는 주체 남은 것을 보여줌
SELECT studno , name
FROM stud_heave
MINUS
SELECT studno, name 
FROM stud_101
;

-- 정렬(sorting)
-- SQL 명령문에서 검색된 결과는 테이블에 데이터가 입력된 순서대로 출력
-- 하지만, 데이터의 출력 순서를 특정 컬럼을 기준으로 오름차순 또는 내림차순으로 정렬하는 경우가 자주 발생
-- 여러 개의 칼럼에 대해 정렬 순서를 정하는 경우도 발생
-- ORDER BY : 칼럼이나 표현식을 기준으로 출력 결과를 정렬할 때 사용
-- 1) ASC : 오른차순으로 정렬, 기본 값
-- 2) DESC : 내림차순으로 정렬하는 경우에 사용, 생략 불가능

-- 학생 테이블에서 이름을 가나다순으로 정렬하여 이름, 학년, 전화번호를 출력하여라
SELECT name, grade, tel
FROM student
ORDER BY name 
-- ORDER BY name asc 오름차순, 기본값
-- ORDER BY name desc 내림차순
;
-- 학생 테이블에서 학년을 내림차순으로 정렬하여 이름, 학년, 전화번호를 출력하여라
SELECT name, grade, tel
FROM student
ORDER BY grade desc
;
-- 모든 사원의 이름과 급여 및 부서번호를 출력하는데, 
-- 부서 번호로 결과를 정렬한 다음 급여에 대해서는 내림차순으로 정렬하라.
SELECT ename, job, deptno, sal
from emp
ORDER  By deptno, sal DESC
;
-- 현장에서 못하면 hw 
-- 문1)부서 10과 30에 속하는 모든 사원의 이름과 부서번호를 
-- 이름의 알파벳 순으로 정렬되도록 질의문을 형성하라.
SELECT ename, deptno
FROM emp
where deptno IN (10,30)
ORDER By ename
;
-- 문2) 1982년에 입사한 모든 사원의 이름과 입사일을 구하는 질의문
SELECT ename,hiredate
FROM emp
WHERE hiredate between '82/01/01' and '82/12/31'
-- where to_char(hiredate,'yymmdd')like '82%'
;
-- 문3) 보너스를 받는 모든 사원에 대해서 이름, 급여 그리고 보너스를 출력하는 질의문을 형성하라.
--       단 급여와 보너스에 대해서 내림차순 정렬
SELECT ename, sal, COMM
FROM emp
where comm is not null
ORDER BY sal desc,comm desc
;
-- 문4) 보너스가 급여의 20% 이상이고 부서번호가 30인 모든 사원에 대해서 
--       이름, 급여 그리고 보너스를 출력하는 질의문을 형성하라
SELECT ename, sal, comm
FROM emp
WHERE deptno = 30 and sal*0.2 <= comm 
;








