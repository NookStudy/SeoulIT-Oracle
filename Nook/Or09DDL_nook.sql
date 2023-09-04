/**********************************
���ϸ�: Or09DDL.sql
DDL : Data Definition Language(������ ���Ǿ�)
����: ���̺� ��� ���� ��ü�� ���� �� �����ϴ� �������� ���Ѵ�.
***********************************/
--SYSTEM����

/*
system�������� ������ �� �Ʒ� ����� �����Ѵ�.
���ο� ����� ������ ������ �� ���ӱ��Ѱ� ���̺� ���� ���� ���� �ο��Ѵ�.
*/
--oracle 21c �̻���ʹ� ���� ������ �ش� ����� �����ؾ� �Ѵ�.
alter session set "_ORACLE_SCRIPT" = true;
--study ������ �����ϰ� , �н����带 1234�� �ο��Ѵ�.
create user study IDENTIFIED by 1234;
--������ ������ ��� ������ �ο��Ѵ�
grant connect, resource to study;
--���ӱ��� �ο� (���ҽ��� ����..)
------------------------------------------------------------------------------------------------
--study ������ ������ �� �ǽ�����.

--��� ������ �����ϴ� ������ ���̺�
select *from dual;

--�ش� ������ ������ ���̺��� ����� ������ �ý��� ���̺�
-- �̿� ���� ���̺��� "�����ͻ���"�̶�� �Ѵ�.
select *from tab;

/*
���̺� �����ϱ�
����] create table ���̺��(
            �÷���1 �ڷ���,  
            �÷���2 �ڷ���,
            .....
            primary key(�÷���)���� �������� �߰�.
            );
*/
create table tb_member (
    idx number(10), 
    userid varchar2(30), 
    passwd varchar2(50), --
    username varchar2(30),
    mileage numbe(7,2)
    );
create table tb_member(
    idx number(10), --10�ڸ� ����
    userid varchar2(30), -- ���������� 30����Ʈ ���尡��
    passwd varchar2(50),
    username varchar2(30),
    mileage number(7,2) --�Ǽ� ǥ��. ��ü7�ڸ�, �Ҽ����� 2�ڸ� ǥ��.
    );
--���� ������ ������ ������ ���̺� ����� Ȯ���Ѵ�.
select *from tab;
--���̺��� ����(��Ű��)Ȯ��. �÷���,�ڷ���, ũ����� Ȯ���Ѵ�.
desc tb_member;
/*
���� ������ ���̺� ���ο� �÷� �߰��ϱ�
    ->tb_member���̺� email �÷��� �߰��Ͻÿ�.
����] alter table ���̺�� add �߰��� �÷� �ڷ���(ũ��) ��������;
*/
alter table tb_member add email varchar2(100);
desc tb_member;

/*
������ ������ ���̺��� �÷��� �����ϱ�   
    ->tb_member ���̺��� email�÷��� ����� 200���� Ȯ���Ͻÿ�.
    ���� �̸��� ����Ǵ� username �÷��� 60���� Ȯ���Ͻÿ�.
    ����] alter table ���̺�� modify ������ �÷��� �ڷ���(ũ��);
*/
alter table tb_member modify email varchar2(200);
alter table tb_member modify username varchar(60);
desc tb_member;

/*
���� ������ ���̺��� �÷� �����ϱ�
    ->tb_member ���̺��� mileage�÷��� �����Ͻÿ�.
����] alter table ���̺� ��  drop column ������ �÷���;
*/
alter table tb_member drop column mileage;
desc tb_member;
/*
����] ���̺� ���Ǽ��� �ۼ��� employees ���̺��� �ش� study ������ �״�� �����Ͻÿ�.
        ��, ���������� ������� �ʽ��ϴ�.
*/

create table employees(
    employee_id number(6),
    first_name varchar2(20),
    last_name varchar2(25),
    email varchar2(30),
    hire_date date,
    job_id varchar2(10),
    salary number(8,2),
    commission_pct number(2,2),
    manager_id number(6),
    department_id number(4)
    );

/*
���̺� �����ϱ�    -> EMPLOYEES ���̺��� �� �̻� ������� �����Ƿ� �����Ͻÿ�.
����] DROP TALBE ������ ���̺��;
*/
SELECT * FROM TAB;
DROP TABLE EMPLOYEES;
--���� �� ���̺� ��Ͽ����� ������ �ʴ´�. �����뿡 �� �����̴�.
SELECT *FROM TAB;
--��ü�� �������� �ʴ´ٴ� ������ �߻���.(�̹� ������)
desc employees;

/*
tb_member ���̺� ���ο� ���ڵ带 �����Ѵ�.(DML�κп��� �н��� ����)
������ ���̺� �����̽���� ������ ���� ������ �� ���� �����̴�.
*/
insert into tb_member values 
    (1,'hong','1234','ȫ�浿','hong@naver.com');
/*
����Ŭ 11g������ ���ο� ������ ������ �� connect, resource�� ��(role)�� �ο��ϸ�
���̺� ���� �� ���Ա��� ������, �� ���Ĺ��������� ���̺����̽� ���ÿ��� �߻�.
���� �Ʒ��� ���� ���̺� �����̽��� ���� ���ѵ� �ο��ؾ� �Ѵ�.
�ش����� system �������� ������ �� �����ؾ� �Ѵ�.
*/    
---system ����
grant unlimited tablespace to study;

--�ٽ� study�� �������� �����
insert into tb_member values 
    (1,'hong','1234','ȫ�浿','hong@naver.com');
insert into tb_member values 
    (2,'yu','9876','����','yoo@hanmail.net');
----���Ե� ���ڵ� Ȯ��
select * from tb_member;    


--���̺� �����ϱ� 1 : ���ڵ���� �Բ� ����.
/*
    select���� ����� �� where���� ������ ��� ���ڵ鸦 ����϶�� ����̹Ƿ�
    �Ʒ������� ��緹�ڵ带 �����ͼ� ���纻 ���̺��� �����Ѵ�.
    ��, ���ڵ���� ����ȴ�.
*/
create table tb_member_copy
    as
    select * from tb_member;

desc tb_member_copy;
select * from tb_member_copy; --where 1=1; ����

purge recyclebin;
select * from tab;
--���̺� �����ϱ� 2 : ���ڵ�� �����ϰ� ���̺� ������ ����

create table tb_member_empty
    as
    select * from tb_member where 1=0;

desc tb_member_empty;
select * from tb_member_empty;
/*
DDL�� : ���̺��� ���� �� �����ϴ� ������
(Data Defintion Language : ������ ���Ǿ�)
    ���̺� ���� : create table ���̺��
    ���̺� ����
        �÷� �߰� :  alter table ���̺�� add �÷���
        �÷� ���� : alter table ���̺�� modify �÷���
        �÷� ���� : alter talbe ���̺�� drop column �÷���
    ���̺� ���� : drop table ���̺��    
*/

-------------------------------------------------------
--��������  �ؿð�. study ����
/*****************************************

1.�������ǿ� �´� "pr_dept"���̺� ����
    dno number(2)
    dname varchar2(20)
    loc varchar2(35)
*/

create table pr_dep(
     dno number(2),
    dname varchar2(20),
    loc varchar2(35)
    );
desc pr_dep;
select * from tab;

/*
2.���� ���ǿ� �´� ���̺� ����
*/
create table pr_emp(
    eno number(4),
    ename varchar2(10),
    job varchar2(30),
    regist_date date
);
commit;

/*
3. pr_emp ���̺��� ename �÷��� varchar2(50) �� �����Ͻÿ�.
*/
alter table pr_emp modify ename varchar2(50);
desc pr_emp;

/*
4. 1������ ������ pr_dept ���̺��� dname Į���� �����Ͻÿ�.
*/
alter table pr_dep drop column dname;
desc pr_dep;
/*
5. ��pr_emp�� ���̺��� job �÷��� varchar2(50) ���� �����Ͻÿ�.
*/
alter table pr_emp modify job varchar2(50);
desc pr_emp;
