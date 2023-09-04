/******************************************************************************
���ϸ�: Or10DML.sql
DML : Data Manipulation Language(������ ���۾�)
����: ���ڵ带 ������ �� ����ϴ� ������. �տ��� �н��ߴ�
    select���� ����Ͽ� update(���ڵ� ����), delete from(���ڵ� ����),
    insert into(���ڵ� ����)�� �ִ�.
*******************************************************************************/
--study����

/*
���ڵ� �Է��ϱ� : insert
    ���ڵ� �Է��� ���� ������ �������� �ݵ�� ''�� ���ξ� �Ѵ�.
    �������� ''���� �׳� ����ȴ�. 
    ���� �������� ''�� ���θ� �ڵ����� ��ȯ�Ǿ� �Է��Ѵ�.
*/

--Here COMES a NEW TABLE!!

create table tb_sample(
    dept_no number(10),
    dept_NAME varchar2(20),
    dept_log varchar2(15),
    dept_manager varchar2(30)
);
select * from tab;
desc tb_sample;

drop table tb_sample;

create table tb_sample(
    dept_no number(10),
    dept_NAME varchar2(20),
    dept_loc varchar2(15),
    dept_manager varchar2(30)
);

insert into tb_sample(dept_no,dept_name,dept_loc,dept_manager)
    values(10, '��ȹ��','����','����');
insert into tb_sample(dept_no,dept_name,dept_loc,dept_manager)
    values(20, '������','����','����');
select * from tb_sample;

--������ �Է�2 : �÷� �������� ��ü �ø��� ������� insertgksek.
insert into tb_sample values(30,'������','�뱸','���');
insert into tb_sample values(40,'�λ���','�λ�','��ȿ');
select * from tb_sample;

/*
�÷��� �����ؼ� insert �ϴ� ��� �����͸� �������� ���� �÷��� ������ �� �ִ�.
�Ʒ��� ��� drop
*/
insert into tb_sample (dept_no,dept_loc,dept_manager)
    values(50,'����','ȿ��');

select * from tb_sample;    

/*
    ���ݱ��� �۾�(Ʈ�����)�� �״�� �����ϰڴٴ� ������� Ŀ���� �������� ������
    �ܺο����� ����� ���ڵ带 Ȯ�� �� �� ����.
    ���⼭ ���ϴ� �ܺζ� java,jsp�� ���� Oracle�̿��� ���α׷��� ���Ѵ�.
    *Ʈ������̶� �۱ݰ� ���� �ϳ��� �����۾��� ���Ѵ�.
*/
commit;
--Ŀ�� ���� ���ο� ���ڵ带 �����ϸ� �ӽ����̺� ����ȴ�.
insert into tb_sample values(60,'������','����','���̸�');
--oracle���� Ȯ���ϸ� ���� ���Ե� ��ó�� ���δ�. ������ �ݿ����� ���� �����̴�.

select * from tb_sample;

rollback;
--�ѹ� ������� ������ Ŀ�� ���·� �ǵ��� �� �ִ�.
--�������� �Է��� '���̸�'�� ���ŵȴ�.
select * from tb_sample;

--�� Ŀ���� ������ ���·δ� �ѹ��� �� ����.

/**
���ڵ� �����ϱ� : update
    ����]
        update ���̺��
        set �÷�1=��1, �÷�2 = ��2,....
        where ����;
    *������ ���� ��� ��� ���ڵ尡 �Ѳ����� �����ȴ�.
    *���̺�� �տ� from�� ���� �ʴ´�.
*/
--�μ���ȣ 40�� ���ڵ��� ������ �̱����� �����Ͻÿ�.
update tb_sample 
    set dept_loc ='�̱�'
    where dept_no =40;
--������ ������ ���ڵ��� �Ŵ������� '������'���� �����Ͻÿ�.
UPDATE tb_sample
SET
    dept_manager = '������'
WHERE
    dept_loc = '����';
 --ctrl + f7   
select * from tb_sample;

--��� ���ڵ带 ������� ������ '����'���� �����Ͻÿ�.
update tb_sample set dept_loc = '����';
/*
    ��ü ����尡 ����̹Ƿ� where���� ���� �ʴ´�.
*/

select * from tb_sample;

/*
���ڵ� �����ϱ� : delete
    ����] 
        delete from ���̺�� where ����;
    *���ڵ带 �����ϹǷ� delete �ڿ� �÷��� ������� �ʴ´�.
*/
delete from tb_sample where dept_no=10;
select * from tb_sample;
--���ڵ� ��ü�� �����Ͻÿ�
delete from tb_sample;
/*
where ���� �����Ƿ� ��� ���ڵ带 �����Ѵ�.
*/
select * from tb_sample;

--�������� Ŀ���ߴ� �������� �ǵ�����.
rollback;
select * from tb_sample;
/*
DML�� : ���ڵ带 ���� �� �����ϴ� ������
(Data Manipulation Language : ������ ���۾�)
    ���ڵ� �Է� : insert into  ���̺��(�÷�1,�÷�2,...) values(��1,��2,...)
    ���ڵ� ���� : update ���̺�� set �÷� = �� where ����
    ���ڵ� ���� : delete from ���̺�� where ����
  *insert�� ��� �÷��� ������ �� �ִ�.  
*/    

--insert �� ��� �÷��� ������ �� �ִ�.
--------------------------------------------------
/*
1. DDL�� �������� 2������ ���� "pr_emp" ���̺� ������ ���� ���ڵ带 �����϶�.
*/
--���1.
desc pr_emp;
insert into pr_emp (eno,ename,job,regist_date)  
        values(1,'���¿�','��¹�',to_date('1975-11-21'));
insert into pr_emp (eno,ename,job,regist_date)  
        values(2,'������','���л��¹�',to_date('1978-07-23'));
--���2.
insert into pr_emp values(3,'�Ѱ���','�����',to_date('1982-10-24'));
insert into pr_emp values(4,'�����','���л�����',to_date('1988-05-21'));
insert into pr_emp values(4,'�����','���л�����','88/05/21');

select * from pr_emp;

delete from pr_emp where eno=4;

/*
2. eno ¦�� ����Ƽ� job�÷� ����
*/
select *from pr_emp where mod(eno,2)=0;
update pr_emp set job = job||'(¦��)' where mod(eno,2)=0;
update pr_emp set job = concat(job,'(Ȧ��)') where mod(eno,2)=1;
select * from pr_emp;
/*
3. pr_emp ���̺��� job �� ���л��� ���ڵ带 ã�� �̸��� �����Ͻÿ�. 
���ڵ�� �����Ǹ� �ȵ˴ϴ�.
*/
update pr_emp set ename='' where job like'%���л�%';
select * from pr_emp;


/*
4.  pr_emp ���̺��� ������� 10���� ��� ���ڵ带 �����Ͻÿ�.
*/
delete pr_emp where to_char(regist_date,'mm') = '10';
delete pr_emp where substr(regis_date,6,2) ='10';

/*
5. pr_emp ���̺��� �����ؼ� pr_emp_clone ���̺��� �����ϵ� ���� ���ǿ� �����ÿ�. 
����1 : ������ �÷����� idx, name, nickname, regidate �Ͱ��� �����ؼ� �����Ѵ�. 
����2 : ���ڵ���� ��� �����Ѵ�. 
*/
--���̺� ����� �÷��� �����Ϸ��� �������̺��� �÷��� 1:1�� ��Ī�Ǵ� �÷���
--������ ���� ����ϸ� �ȴ�. 
--����1
desc pr_emp;

--------------------------------------------NOOK

create table pr_emp_clone 
    as select * from pr_emp where 1=0;
alter table pr_emp_clone    
    rename column eno to idx;  
alter table pr_emp_clone    
    rename column ename to name;
alter table pr_emp_clone    
    rename column job to nickname;
alter table pr_emp_clone    
    rename column regist_date to regidate;
desc pr_emp_clone;    
---------------------------------------------------
create table pr_emp_clone(
idx, name, nickname, regidate)
as select* from pr_emp;
--����2    
create table pr_emp_clone_c2
    as select * from pr_emp where 1=1;    
select * from  pr_emp_clone_c2;

----------------rere
/*
6. 5������ ������ pr_emp_clone ���̺���� pr_emp_rename ���� �����Ͻÿ�.
*/
alter table pr_emp_clone rename to pr_emp_rename;
select * from tab;
purge recyclebin;

/*
7. pr_emp_rename ���̺��� �����Ͻÿ�
*/
drop table pr_emp_rename;