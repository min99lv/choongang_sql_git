-- 1) 학생 테이블에서 ‘김영균’ 학생의 이름, 사용자 아이디를 출력하여라. 
--    그리고 사용자 아이디의 첫 문자를 대문자로 변환하여 출력하여라
select name, initcap(userid)
FROM student
;
-- 2) 부서 테이블에서 부서 이름의 길이를 문자 수와 바이트 수로 각각 출력하여라
select length(dname), lengthb(dname)
from dept
;
-- 3) 학생 테이블에서 1학년 학생의 주민등록 번호에서 생년월일과 태어난 달을 추출하여 
--      이름, 주민번호, 생년월일, 태어난 달을 출력하여라
--      1부터 6바이트 , 3부터 2바이트
select name, idnum, substr(idnum,1,6) birthday, substr(idnum,3,2) birth_month
from student
;
-- 4) 문자열중에서 사용자가 지정한 특정 문자가 포함된 위치를 반환하는 함수
--      학과  테이블의 부서 이름 칼럼에서 ‘과’ 글자의 위치를 출력하여라
select dname,instr(dname,'과')
from department
;
-- 5) 교수테이블에서 직급 칼럼의 왼쪽에 ‘*’ 문자를 삽입하여 10바이트로 출력하고 
--      교수 아이디 칼럼은 오른쪽에 ‘+’문자를 삽입하여 12바이트로 출력
--       글자수를 포함해서 10바이트를 채운다
select name,sal, round(sal/22), round(sal/22,2),round(sal/22,-1)
from professor
;
-- 6)학과 테이블에서 부서 이름의 마지막 글자인 ‘과’를 삭제하여 출력하여라
select dname,instr(dname,'과')
from department
;

-- 7) 교수 테이블에서 101학과 교수의 일급을 계산(월 근무일은 22일)하여 소수점 첫째 자리와 
--      셋째 자리에서 반올림 한 값과 소숫점 왼쪽 첫째 자리에서 반올림한 값을 출력하여라
--                        소수섬 첫째자리 반올림/ 두자리지점에서 반올림/ 정수기준 반올림

-- 8) 교수 테이블에서 101학과 교수의 일급을 계산(월 근무일은 22일)하여
--      소수점 첫째 자리와 셋째 자리에서 절삭 한 값과 
--      소숫점 왼쪽 첫째 자리에서 절삭한 값을 출력

-- 9) 교수 테이블에서 101번 학과 교수의 급여를 보직수당으로 나눈 나머지를 계산하여 출력하여라

-- 10) 19.7보다 큰 정수 중에서 가장 작은 정수와 12.345보다 작은 정수 중에서 가장 큰 정수를 출력하여라

-- 11) 교수 번호가 9908인 교수의 입사일을 기준으로 입사 30일 후와 60일 후의 날짜를 출력

-- 12) 입사한지 120개월 미만인 교수의 교수번호, 입사일, 입사일로 부터 현재일까지의 개월 수,
--     입사일에서 6개월 후의 날짜를 출력하여라

-- 13) 학생 테이블에서 전인하 학생의 학번과 생년월일 중에서 년월만 출력하여라

-- 14) 오늘이 속한 달의 마지막 날짜와 다가오는 토요일의 날짜를 출력하여라

-- 15) 학생 테이블에서 전인하 학생의 학번과 생년월일 중에서 년월만 문자로 출력하여라

-- 16) 보직수당을 받는 교수들의 이름, 급여, 보직수당, 
--      그리고 급여와 보직수당을 더한 값에 12를 곱한 결과를 연봉(anual_sal)으로 출력

-- 17) student Table에서 주민등록번호에서 생년월일을 추출하여 문자‘YY/MM/DD’ 형태
--      별명 BirthDate로 출력하여라

-- 18)101번 학과 교수의 이름, 직급, 급여, 보직수당, 급여와 보직수당의 합계를 출력하여라. 
--      단, 보직수당이 NULL인 경우에는 보직수당을 0으로 계산한다

-- 19) salgrade 데이터 전체 보기
select *
from salgrade
;
-- 20) scott 에서 사용가능한 테이블 보기
select *
from tab
;
-- 21) emp Table에서 사번 , 이름, 급여, 업무, 입사일
select empno, ename, sal,job, hiredate
from emp
;

-- 22) emp Table에서 급여가 2000미만인 사람 에 대한 사번, 이름, 급여 항목 조회
select empno, ename, sal
from emp
where sal < 2000
;
-- 23) emp Table에서 80/02이후에 입사한 사람에 대한  사번,이름,업무,입사일 
select empno, ename, job, hiredate
from emp
where hiredate > '80/02/01'
;
-- 24) emp Table에서 급여가 1500이상이고 3000이하 사번, 이름, 급여  조회(2가지)
select empno, ename, sal
from emp
where sal between 1500 and 3000
;
-- 25) emp Table에서 사번, 이름, 업무, 급여 출력 [ 급여가 2500이상이고  업무가 MANAGER인 사람]
select empno, ename, job, sal
from emp
where job = 'MANAGER' and sal >= 2500
;
-- 26) emp Table에서 이름, 급여, 연봉 조회 
--    [단 조건은  연봉 = (급여+상여) * 12  , null을 0으로 변경]
select empno, ename, sal, (sal+NVL(comm,0))*12
from emp
;
-- 27) emp Table에서  81/02 이후에 입사자들중 xxx는 입사일이 xxX
--  [ 전체 Row 출력 ] --> 2가지 방법 다
select empno 
from emp
;
-- 28) emp Table에서 이름속에 T가 있는 사번,이름 출력
select 
from emp
;

-- 30) 102번 학과 교수중에서 보직수당을 받는 사람은 급여와 보직수당을 
-- 더한 값을 급여 총액으로 출력하여라. 
-- 단, 보직수당을 받지 않는 교수는 급여만 급여 총액으로 출력하여라.

-- 31) 교수 테이블에서 이름의 바이트 수와 사용자 아이디의 바이트 수를 비교해서
--      같으면 NULL을 반환하고 
--      같지 않으면 이름의 바이트 수를 반환

-- 32) 교수 테이블에서 교수의 소속 학과 번호를 학과 이름으로 변환하여 출력하여라. 
-- 학과 번호가 101이면 ‘컴퓨터공학과’, 102이면 ‘멀티미디어학과’, 201이면 ‘전자공학과’, 
-- 나머지 학과 번호는 ‘기계공학과’(default)로 변환

-- 33)
-- decode/case
-- 교수 테이블에서 소속 학과에 따라 보너스를 다르게 계산하여 출력하여라. (별명 --> bonus)
-- 학과 번호별로 보너스는 다음과 같이 계산한다.
-- 학과 번호가 101이면 보너스는 급여의 10%, 102이면 20%, 201이면 30%, 나머지 학과는 0%

-- 34) emp Table 의 이름을 대문자, 소문자, 첫글자만 대문자로 출력
select ename, initcap(ename)
from emp
;
-- 35) emp Table 의  이름, 업무, 업무를 2-5사이 문자 출력
select ename, job,substr(job,2,5)
from emp
;
-- 36) emp Table 의 이름, 이름을 10자리로 하고 왼쪽에 #으로 채우기
select ename, lpad(ename,10,'#')
from emp
;
-- 37) emp Table 의  이름, 업무, 업무가 MANAGER면 관리자로 출력
select ename, job
from emp
;
-- 38) emp Table 의  이름, 급여/7을 각각 정수, 소숫점 1자리. 10단위로   반올림하여 출력
select ename, sal/7, round(sal/7), round(sal/7,1),round(sal/7,-2)
from emp
;


