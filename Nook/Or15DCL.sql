/******************************************************************************
���ϸ�: Or15DCL.sql
DCL : Data Control Language(������ �����)
����: ���ο� ����ڰ����� �����ϰ� �ý��� ������ �ο��ϴ� ����� �н�
*******************************************************************************/
--system �������� �����մϴ�.
/**
[����� ���� ���� �� ���Ѽ���]
-�ش� �κ��� DBA������ �ִ� �ְ�������(sys,system)���� ������ �� �����ؾ���.
-���ο� ����� ������ ������ �� ���� �� �������� �׽�Ʈ�� cmd(����������Ʈ)
  ���� �����Ѵ�.
*/

/*
1] ����� ���� ���� �� ��ȣ����
����] create user ���̵� identified by ��ȣ;
**/
--����Ŭ12c ���ĺ��ʹ� �ش������ ���� ������ �� ������ �����ؾ���
--�̽��� ���¿��� ������ �����ϸ� ������ �߻��Ѵ�.
alter session set "_ORACLE_SCRIPT" = true;
--�� ������ ���ٸ� ���� ������ C##�� ������ �տ� �߰��ؾ� �Ѵ�.
create user test_user1 identified by 1234;
/*
�������� ���� cmd���� sqlplus�������� ������ �õ��غ��� login denied
������ �߻��Ѵ�. create session ���� �� ���ӱ����� ���� ������ �� ����.
*/
/****
 2] ������ ������ ���� Ȥ�� ���� �ο�
����]
    grant �ý��۱���1, ����2, ....N
        to ����ڰ�����
            [with grant �ɼ�]
*/
--���ӱ����� �ο��մϴ�. ������ �ο��� ���� to�� ���.
grant create session to test_user1;
--���� �ο��� ������ ����������, ���̺� ������ ���� �ʴ´�.
grant create table to test_user1;
--���� ���̺����� ����(on cmd)

/*
3]��ȣ����
    alter user ����ڰ��� identified by ������ ��ȣ;
*/
alter user test_user1 identified by 0000;
/*
quit Ȥ�� exit �������� ������ ������ �� �ٽ� �����ϸ�
  ���� ��ȣ�δ� ���ӵ��� �ʴ´�. ������ 0000���� ������ �� �ִ�.
*/
/*
4] Role(��,����)�� ���� �������� ������ ���ÿ� �ο��ϱ�
    : ���� ����ڰ� �پ��h ������ ȿ�������� ������ �� �ֵ��� 
        ���õ� ���ѳ��� ������� ���� ���Ѵ�.
    *�츮�� �ǽ��� ���� ���Ӱ� ������ ������ connect,resource���� �ַ� �ο�.    
*/
alter session set "_ORACLE_SCRIPT" = true;
create user test_user2 identified by 1234;
grant connect, resource to test_user2;
/*
test_user2 ������ ���� ���� ������ �ο��� �� 
 ���� �� ���̺� ������ ���������� �ȴ�.
*/
/*
4-1] ROle �����ϱ� : ����ڰ� ���ϴ� ������ ���� ���ο� ���� �����Ѵ�.
*/
create role my_role;
/*
4-2] ������ �ѿ� ���Ѻο��ϱ�
*/
--������ �ѿ� 3���� ������ �ο��Ѵ�.
grant create session, create table, create view to my_role;
--���ο� ����� ������ �����Ѵ�.
create user test_user3 identified by 1324;
alter user test_user3 identified by 1234;
--����ڿ��� ���� ���� ������ �ο��Ѵ�.
grant my_role to test_user3;
--���� �� ���̺� ���� Ȯ��

/*
4-3 ] �� �����ϱ�
*/
drop role my_role;
/*
  test_user3�� my_role�� ���� ������ �ο��޾����Ƿ� 
  �ش� ���� �����ϸ� ��� ������ ȸ��(revoke)�ȴ�.
  ��, �� �����Ŀ��� ������ �� ����.
*/
/*
5] ��������(ȸ��)
    ����] revoke ���� �� ���� from ����ڰ���;
*/

revoke create session from test_user1;
--test_user1�δ� ������ �� ����. ���ӽ� ������ �߻��Ѵ�.
/*
6] ����� ���� ����
    ����] drop user ����ڰ���[cascade]
    *cascade�� �����ϸ� ����ڰ����� ���õ� ��� �����ͺ��̽� ��Ű����
        ������ �������� ���� �����ǰ�, ��� ��Ű�� ��ü�� ���������� �����ȴ�.
*/
--���� ������ ����� ����� Ȯ���� �� �ִ� �����ͻ��� 
select * from dba_users;
--������ �����Ϸ��� ��� �������� ��Ű������ ���� �����Ѵ�.
alter session set "_ORACLE_SCRIPT"=true ;
drop user test_user1 cascade;

select * from dba_users where lower(username)='test_user1'; --�������
select * from dba_users where lower(username)='test_user2'; 
select * from dba_users where username=upper('test_user2');
create user test_user4 identified by 1234;
grant create session , create table to test_user4;
/*
���̺� �����̽���?
    -��ũ ������ �Һ��ϴ� ���̺��� ��, �׸��� �׹��� �ٸ� �����ͺ��̽�
      ��ü���� ����Ǵ� ����̴�. 
    -���� ��� ����Ŭ�� ���ʷ� ��ġ�ϸ� hr������ �����͸� �����ϴ� user��� 
      ���̺� �����̽��� �ڵ����� �����ȴ�.
*/
--���̺� �����̽� ��ȸ�ϱ�
desc dba_tablespaces;
select tablespace_name, status, contents from dba_tablespaces;
--���̺� �����̽��� ��� ������ ���� Ȯ���ϱ�
select
    tablespace_name, sum(bytes),max(bytes), 
    trim(to_char(sum(bytes),'9,999,999,000')) "�հ�",
    trim(to_char(max(bytes),'9,999,999,000')) "�ִ�"
from dba_free_space
group by tablespace_name;


--�տ��� ������ test_user4 ������� ���̺������̽� Ȯ���ϱ�
select username, default_tablespace from dba_users
    where username in upper('test_user4'); --users���̺� �����̽����� Ȯ��

--���̺� �����̽� ���� �Ҵ�
alter user test_user4 quota 2m on users;
/*
    test_user4�� system ���̺� �����̽��� ���̺��� �����Ҽ� �ֵ���
    2megabyte�� �뷮�� �Ҵ��Ѵ�.
*/
--cmd���� ���̺��� insert to �Ǵ��� Ȯ���� ����.(����)

--2��° ����� �߰� : ���̺� �����̽� users�� �����Ͽ� �����Ѵ�.
create user test_user5 identified by 1234 default tablespace users;
grant create session to test_user5; --���� ���� �ο�
grant create table to test_user5; --���̺� ���� ���� �ο�
--�տ��� �����Ѵ�� ���̺������̽� users�� ����ϰ� �ִ�.
select username, default_tablespace from dba_users
    where username in upper('test_user5');
--users ���̺������̽� 10m������ �Ҵ��Ѵ�.
alter user test_user5 quota 10m on users;
--���̺��� ���������� �����ȴ�.
/*
�̹� ������ ������� 
����Ʈ ���̺������̽��� �����ϰ� ��������
alter user ������ ����Ѵ�.
*/
select username, default_tablespace from dba_users
    where username in upper('test_user5'); 
select username, default_tablespace from dba_users;
   
alter test_user5     
/*
    ���̺��� �����ϸ� users���̺������̽��� ���� ������ ���� �������� �ʴ´�.
*/

