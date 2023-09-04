/***************
���ϸ� :  Or10DML.sql
DML : Data Manipulation Language (������ ���۾�)
���� : ���ڵ带 ������ �� ����ϴ� ������. �տ��� �н��ߴ� 
    select���� ����Ͽ� update(���ڵ����), delete(���ڵ����),
    insert(���ڵ��Է�) �� �ִ�.
****************/
-- STUDY ����

/*
���ڵ� �Է��ϱ� : insert
    ���ڵ� �Է��� ���� ������ �������� �ݵ�� '�� ���ξ� �Ѵ�.
    �������� '���� �׳� ����ȴ�. ���� �������� '�� ���θ� �ڵ�����
    ��ȯ�Ǿ� �Էµȴ�.
*/
-- ���ο� ���̺� �����ϱ�
create table tb_sample (
    dept_no number(10),
    dept_name varchar2(20),
    dept_loc varchar2(15),
    dept_manager varchar2(30)
);
-- ������ ���̺��� ���� Ȯ��
desc tb_sample;

-- ������ �Է�1 : �÷��� ������ �� insert�Ѵ�.
insert into tb_sample (dept_no, dept_name, dept_loc, dept_manager)
    values(10, '��ȹ��', '����', '����');
insert into tb_sample (dept_no, dept_name, dept_loc, dept_manager)
    values(20, '������', '����', '����');

-- ������ �Է�2 : �÷� �������� ��ü �÷��� ������� insert�Ѵ�.
insert into tb_sample values (30, '������', '�뱸', '���');
insert into tb_sample values (40, '�λ���', '�λ�', '��ȿ');
select * from tb_sample;

/*
�÷��� �����ؼ� insert�ϴ� ��� �����͸� �������� ���� �÷��� ������ �� 
�ִ�. �Ʒ��� ��� dept_name�� null�� �ȴ�.
*/
insert into tb_sample (dept_no, dept_loc, dept_manager)
    values (50, '����', 'ȿ��');
select * from tb_sample;

/*
    ���ݱ��� �۾�(Ʈ�����)�� �״�� �����ϰڴٴ� ������� Ŀ����
    �������� ������ �ܺο����� ����� ���ڵ带 Ȯ���� �� ����.
    ���⼭ ���ϴ� �ܺζ� Java/JSP�� ���� Oracle �̿��� ���α׷��� ���Ѵ�.
    * Ʈ������̶� �۱ݰ� ���� �ϳ��� �����۾��� ���Ѵ�.
*/
commit;

-- Ŀ�� ���� ���ο� ���ڵ带 �����ϸ� �ӽ����̺� ����ȴ�.
insert into tb_sample values (60, '������', '����', '���̸�');
-- ����Ŭ���� Ȯ���ϸ� ���� ���ԵȰ� ó�� ���δ�. ������ ���� �ݿ�����
-- ���� �����̴�.
select * from tb_sample;
-- �ѹ� ������� ������ Ŀ�� ���·� �ǵ��� �� �ִ�.
rollback;
-- �������� �Է��� '���̸�'�� ���ŵȴ�.
select * from tb_sample;
/*
    rollback ����� ������ Ŀ�� ���·� �ǵ����ش�.
    ��, commit �� ������ ���·δ� �ѹ��� �� ����.
*/

/*
���ڵ� �����ϱ� : update
    ����]
        update ���̺��
        set �÷�1 = ��1, �÷�2 = ��2, ...
        where ����;
    * ������ ���� ��� ��� ���ڵ尡 �Ѳ����� �����ȴ�.
    * ���̺�� �տ� from�� ���� �ʴ´�.
*/
-- �μ���ȣ 40�� ���ڵ��� ������ �̱����� �����Ͻÿ�.
update tb_sample set dept_loc = '�̱�' where dept_no = 40;
-- ������ ������ ���ڵ��� �Ŵ������� '������'���� �����Ͻÿ�.
update tb_sample set dept_manager = '������' where dept_loc = '����';
select * from tb_sample;

-- ��� ���ڵ带 ������� ������ '����'���� �����Ͻÿ�.
update tb_sample set dept_loc = '����';
/*
    ��ü ���ڵ尡 ����̹Ƿ� where���� ���� �ʴ´�.
*/
select * from tb_sample;

/*
���ڵ� �����ϱ� : delete 
    ����]
        delete from ���̺�� where ����;
        * ���ڵ带 �����ϹǷ� delete �ڿ� �÷��� ������� �ʴ´�.
*/
-- �μ���ȣ�� 10�� ���ڵ带 �����Ͻÿ�.
delete from tb_sample where dept_no = 10;
select * from tb_sample;
-- ���ڵ� ��ü�� �����Ͻÿ�.
delete from tb_sample;
/*
    where ���� �����Ƿ� ��� ���ڵ带 �����Ѵ�.
*/
select * from tb_sample;

-- �������� Ŀ���ߴ� �������� �ǵ�����.
rollback;
select * from tb_sample;

/*
DML�� : ���ڵ带 �Է� �� �����ϴ� ������
(Data Manipulation Language : ������ ���۾�)
    ���ڵ� �Է� : insert into ���̺�� (�÷�) values (��)
    ���ڵ� ���� : update ���̺�� set �÷� = �� where ����
    ���ڵ� ���� : delete from ���̺�� where ����
* insert�� ��� �÷��� ������ �� �ִ�.
*/
--------------------------------------------------------------------
-- ��������

/*
1.
*/
desc pr_emp;
insert into pr_emp (eno, ename, job, regist_date)
    values (1, '���¿�', '��¹�', to_date('1975-11-21'));
insert into pr_emp (eno, ename, job, regist_date)
    values (2, '������', '���л��¹�', to_date('1978-07-23'));
insert into pr_emp
    values (3, '�Ѱ���', '�����', to_date('1982-10-24'));
insert into pr_emp 
    values (4, '�����', '���л�����', to_date('1985-05-21'));
    select * from pr_emp;
    delete from pr_emp where eno = null;
        select * from pr_emp;

/*
2.
*/
select * from pr_emp where mod (eno, 2) = 0;
update pr_emp set job = job || '(¦��)' where mod (eno, 2) = 0; 
update pr_emp set job = job || '(Ȧ��)' where mod (eno, 2) = 1;
/*
3.
*/

/*
4.
*/

/*
5.
*/
desc pr_emp;
create table pr_emp_clone(idx, name, nickname, regidate)
    as select * from pr_emp;
 
select * from pr_emp_clone;
/*
6.
*/

/*
7.
*/









