/******************************************************************************
파일명: Or15DCL.sql
DCL : Data Control Language(데이터 제어어)
설명: 새로운 사용자계정을 생성하고 시스템 권한을 부여하는 방법을 학습
*******************************************************************************/
--system 계정에서 진행합니다.
/**
[사용자 계정 생성 및 권한설정]
-해당 부분은 DBA권한이 있는 최고관리자(sys,system)으로 접속한 후 실행해야함.
-새로운 사용자 계정이 생성된 후 접속 및 쿼리실행 테스트는 cmd(명렴프롬프트)
  에서 진행한다.
*/

/*
1] 사용자 계정 생성 및 암호설정
형식] create user 아이디 identified by 암호;
**/
--오라클12c 이후부터는 해당명령은 먼저 실행한 후 계정을 생성해야함
--미실행 상태에서 계정을 생성하면 오류가 발생한다.
alter session set "_ORACLE_SCRIPT" = true;
--위 명령이 없다면 계정 생성시 C##을 계정명 앞에 추가해야 한다.
create user test_user1 identified by 1234;
/*
계정생성 직후 cmd에서 sqlplus명령으로 접속을 시도해보면 login denied
에러가 발생한다. create session 권한 즉 접속권한이 없어 접속할 수 없다.
*/
/****
 2] 생성된 계정에 권한 혹은 역할 부여
형식]
    grant 시스템권한1, 권한2, ....N
        to 사용자계정명
            [with grant 옵션]
*/
--접속권한을 부여합니다. 권한을 부여할 때는 to를 사용.
grant create session to test_user1;
--권한 부여후 접속은 성공했지만, 테이블 생성은 되지 않는다.
grant create table to test_user1;
--이후 테이블생성 성공(on cmd)

/*
3]암호변경
    alter user 사용자계정 identified by 변경할 암호;
*/
alter user test_user1 identified by 0000;
/*
quit 혹은 exit 명령으로 접속을 해제한 후 다시 접속하면
  기존 암호로는 접속되지 않는다. 변경한 0000으로 접속할 수 있다.
*/
/*
4] Role(롤,역할)을 통한 여러가지 권한을 동시에 부여하기
    : 여러 사용자가 다앙햔 권한을 효과적으로 관리할 수 있도록 
        관련된 권한끼리 묶어놓은 것을 말한다.
    *우리는 실습을 위해 새롭게 생성한 계정에 connect,resource롤을 주로 부여.    
*/
alter session set "_ORACLE_SCRIPT" = true;
create user test_user2 identified by 1234;
grant connect, resource to test_user2;
/*
test_user2 계정에 롤을 통해 권한을 부여한 후 
 접속 및 테이블 생성이 정상적으로 된다.
*/
/*
4-1] ROle 생성하기 : 사용자가 원하는 권한을 묶어 새로운 롤을 생성한다.
*/
create role my_role;
/*
4-2] 생성된 롤에 권한부여하기
*/
--생성된 롤에 3가지 권한을 부여한다.
grant create session, create table, create view to my_role;
--새로운 사용자 계정을 생성한다.
create user test_user3 identified by 1324;
alter user test_user3 identified by 1234;
--사용자에게 롤을 통해 권한을 부여한다.
grant my_role to test_user3;
--접속 및 테이블 생성 확인

/*
4-3 ] 롤 삭제하기
*/
drop role my_role;
/*
  test_user3가 my_role을 통해 권한을 부여받았으므로 
  해당 롤을 삭제하면 모든 권한이 회수(revoke)된다.
  즉, 롤 삭제후에는 접속할 수 없다.
*/
/*
5] 권한제거(회수)
    형식] revoke 권한 및 역할 from 사용자계정;
*/

revoke create session from test_user1;
--test_user1로는 접속할 수 없다. 접속시 오류가 발생한다.
/*
6] 사용자 계정 삭제
    형식] drop user 사용자계정[cascade]
    *cascade를 명시하면 사용자계정과 관련된 모든 데이터베이스 스키마가
        데이터 사전으로 부터 삭제되고, 모든 스키마 객체도 물리적으로 삭제된다.
*/
--현재 생성된 사용자 목록을 확인할 수 있는 데이터사전 
select * from dba_users;
--계정을 삭제하려면 모든 물리적인 스키마까지 같이 삭제한다.
alter session set "_ORACLE_SCRIPT"=true ;
drop user test_user1 cascade;

select * from dba_users where lower(username)='test_user1'; --결과없음
select * from dba_users where lower(username)='test_user2'; 
select * from dba_users where username=upper('test_user2');
create user test_user4 identified by 1234;
grant create session , create table to test_user4;
/*
테이블 스페이스란?
    -디스크 공간을 소비하는 테이블과 뷰, 그리고 그밖의 다른 데이터베이스
      객체들이 저장되는 장소이다. 
    -예를 들어 오라클을 최초로 설치하면 hr계정의 데이터를 저장하는 user라는 
      테이블 스테이스가 자동으로 생성된다.
*/
--테이블 스페이스 조회하기
desc dba_tablespaces;
select tablespace_name, status, contents from dba_tablespaces;
--테이블 스페이스별 사용 가능한 공간 확인하기
select
    tablespace_name, sum(bytes),max(bytes), 
    trim(to_char(sum(bytes),'9,999,999,000')) "합계",
    trim(to_char(max(bytes),'9,999,999,000')) "최대"
from dba_free_space
group by tablespace_name;


--앞에서 생성한 test_user4 사용자의 테이블스페이스 확인하기
select username, default_tablespace from dba_users
    where username in upper('test_user4'); --users테이블 스페이스임을 확인

--테이블 스페이스 영역 할당
alter user test_user4 quota 2m on users;
/*
    test_user4가 system 테이블 스페이스에 테이블을 생성할수 있도록
    2megabyte의 용량을 할당한다.
*/
--cmd에서 테이블에 insert to 되는지 확인해 본다.(성공)

--2번째 사용자 추가 : 테이블 스페이스 users로 지정하여 생성한다.
create user test_user5 identified by 1234 default tablespace users;
grant create session to test_user5; --접속 권한 부여
grant create table to test_user5; --테이블 생성 권한 부여
--앞에서 지정한대로 테이블스페이스 users를 사용하고 있다.
select username, default_tablespace from dba_users
    where username in upper('test_user5');
--users 테이블스페이스 10m공간을 할당한다.
alter user test_user5 quota 10m on users;
--테이블이 정상적으로 생성된다.
/*
이미 생성된 사용자의 
디폴트 테이블스페이스를 변경하고 싶을때는
alter user 명령을 사용한다.
*/
select username, default_tablespace from dba_users
    where username in upper('test_user5'); 
select username, default_tablespace from dba_users;
   
alter test_user5     
/*
    테이블을 생성하면 users테이블스페이스에 대한 권한이 없어 생성되지 않는다.
*/


