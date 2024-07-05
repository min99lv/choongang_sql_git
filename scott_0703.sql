----------------------------------------------------------------------------------------------------------------------
---   데이터베이스 보안
---  1. 다중 사용자 환경(multi-user environment)
---     1) 사용자는 자신이 생성한 객체에 대해 소유권을 가지고 데이터에 대한 조작이나 조회 가능
---     2) 다른 사용자가 소유한 객체는 소유자로부터 접근 권한을 부여받지 않는 접근 불가
---     3) 다중 사용자 환경에서는 데이터베이스 관리자의 암호를 철저하게 관리
---  2. 중앙 집중적인 데이터 관리
---  3. 시스템 보안
---     1) 데이터베이스 관리자는 사용자 계정, 암호 관리, 사용자별 허용 가능한 디스크공간 할당
---     2) 시스템 관리 차원에서 데이터베이스 자체에 대한 접근 권한을 관리
---  4. 데이터 보안
---     1) 사용자별로 객체를 조작하기 위한 동작 관리
---     2) 데이터베이스 객체에 대한 접근 권한을 관리
---------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------
---  권한(Privilege) 부여
---    1. 정의 : 사용자가 데이터베이스 시스템을 관리하거나 객체를 이용할 수 있는 권리
---    2. 유형 
---         1) 시스템 권한 : 시스템 차원의 자원 관리나 사용자 스키마 객체 관리 등과 같은 
---                               데이터베이스 관리 작업을 할 수 있는 권한
---             [1]  데이터베이스 관리자가 가지는 시스템 권한
---                   CREATE USER     :  사용자를 생성할 수 있는 권한
---                   DROP    USER     : 사용자를 삭제할 수 있는 권한
---                   DROP ANY TABLE : 임의의 테이블을 삭제할 수 있는 권한
---                   QUERY REWRITE  : 함수 기반 인덱스를 생성하기 위한 권한
---             [2]  일반사용자가 가지는 시스템 권한
---                   CREATE SESSION      : DB에 접속할 수 있는 권한
---                   CREATE TABLE          : 사용자 스키마에서 테이블을 생성할 수 있는 권한
---                   CREATE SEQUENCE   : 사용자 스키마에서 시퀀스를 생성할 수 있는 권한
---                   CREATE VIEW            : 사용자 스키마에서 뷰를 생성할 수 있는 권한
---                   CREATE PROCEDURE : 사용자 스키마에서 프로시저, 함수, 패키지를 생성할 수 있는 권한
---         2) 객체 권한    : 테이블, 뷰, 시퀀스, 함수 등과 같은 객체를 조작할 수 있는 권한
---------------------------------------------------------------------------------------------------------------------
-- 
----------------------------------------------------------------------------------------------------------------------
---  롤(role)
---  1. 개념 : 다수 사용자와 다양한 권한을 효과적으로 관리하기 위하여 서로 관련된 권한을 그룹화한 개념
---              일반 사용자가 데이터베이스를 이용하기 위한 공통적인 권한(데이터베이스 접속권한, 
--                테이블 생성, 수정, 삭제, 조회 권한, 뷰 생성 권한)을 그룹화
-- 사전에 정의된 롤 = 내장 롤
-- 1. CONNECT 롤 - 접속할 수 있는 권한
--     1) 사용자가 데이터베이스에 접속하여 세션을 생성할 수 있는 권한
--     2) 테이블 또는 뷰와 같은 객체를 생성할 수 있는 권한
-- 2. RESOURCE 롤
--     1) 사용자에게 자신의 테이블, 시퀀스, 프로시져, 트리거 객체 생성 할 수 있는 권한
--     2) 사용자 생성시 : CONNECT 롤과 RESOURCE 롤을 부여
-- 3.  DBA 롤 = grant dba to scott
--     1) 시스템 자원의 무제한적인 사용이나 시스템 관리에 필요한 모든 권한
--     2) DBA 권한을 다른 사람에게 부여할 수 있음
--     3) 모든 사용자 소유의 CONNECT, RESOURCE, DBA 권한을 포함한 모든 권한을 부여 및 철회 가능

---------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------
---   Admin 사용자 생성 /권한 부여
------------------------------------------------
-- 1-1. USER 생성
create user usertest01 IDENTIFIED by tiger;  --> 접속 후 테스트 세션권한이 없다
-- 1-2. USER 생성
create user usertest02 IDENTIFIED by tiger;
-- 1-3. USER 생성
create user usertest03 IDENTIFIED by tiger;
-- 1-4. USER 생성
create user usertest04 IDENTIFIED by tiger;


-- 2-1. session 권한 부여 --> 접속권한만 주어짐 / 테이블 생성 불가
grant create session to usertest01;
-- 2-2. session 권한 부여 --> 접속권한, 만 주어짐
grant create session, create table, create view to usertest02
-- 2-3. 현장에서 DBA가  개발자 권한 부여
grant connect,resource to usertest03;
-- 2-4 dba권한 부여
grant dba to usertest04;
--      dba권한 회수
revoke dba from usertest04;