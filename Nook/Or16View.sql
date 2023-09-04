/******************************************************************************
���ϸ�: Or16view.sql
View(��)
����: View�� ���̺�κ��� ������ ������ ���̺�� ���������δ� �������� �ʰ�
    �������� �����ϴ� ���̺��̴�.
*******************************************************************************/
--hr�������� �����մϴ�.

/*
���� ����
����] 
    create [or replace] view  ���̸�[(�÷�1,�÷�2,....)]
    as
    select * from ���̺�� where ����
        Ȥ�� join���� ������.
*/
/*
�ó�����] hr������ ������̺��� 
    �������� ST_clerk�� ��������� ��ȸ�Ҽ� �ִ�  view�� �����Ͻÿ�.
    ����׸� : ������̵�, �̸�, �������̵�, �Ի��� , �μ����̵�
*/
--1. ���Ǵ�� select �ϱ�
select employee_id, first_name, job_id, hire_date, department_id, rownum
from employees
where job_id ='ST_CLERK';

--2. �� �����ϱ�
create view view_employees
as
    select employee_id, first_name, job_id, hire_date, department_id
    from employees
    where job_id ='ST_CLERK';

--3.�� �����ϱ� : select���� �����ϴ� �Ͱ� ������ ����� ����ȴ�.
select * from view_employees;
--4.�����ͻ������� �� Ȯ���ϱ�
select * from user_views;
--������ ���� �������� �״�� ����Ǵ°� �� �� �ִ�.
--select * from emp_details_view;
/*
�� �����ϱ�
    : �� ���� ���忡 or replace�� �߰��ϸ� �ȴ�.
    �ش� �䰡 �����ϸ� �����ǰ�, �������� ������ ���Ӱ� �����ȴ�.
    ���� ó�� �並 �����Ҷ����� ����ص� �����Ѵ�.
*/
/*
�ó�����] �������� ������ �並 ������ ���� �����Ͻÿ�.
    ���� �÷��� employee_id,first_name,job_id,hire_date,department_id��
    id, fname,hdate , deptid�� �����Ͽ� �並 �����Ͻÿ�
*/
create or replace view vew_employees
    (id, fname,jobid,hdate , deptid)
as 
    select employee_id, first_name, job_id, hire_date, department_id
    from employees
    where job_id ='ST_CLERK';
select * from view_employees;
drop view vew_employees;



select * from tab;
/*
����] ������ ������ view_employees �並 �Ʒ� ���ǿ� �°� �����Ͻÿ�.
    �������̵� ST_MAN�� ����� �����ȣ, �̸�, �̸���, �Ŵ������̵� ��ȸ�Ҽ� 
    �ְ� �����Ͻÿ�.
    ���� �÷����� e_id,name,email,m_id�� �����Ѵ�. 
    ��, �̸��� first_name�� last_name�� ����� ���·� ����Ͻÿ�.
*/
create or replace view view_employees
(e_id,name,eamail,m_id)
as
    select employee_id, first_name||' '||last_name, email, manager_id
    from employees
    where job_id = upper('ST_man');

select * from view_employees;

/*
����] �����ȣ, �̸�, ������ ����Ͽ� ����ϴ� �並 �����Ͻÿ�.
    �÷��� �̸��� emp_id, l_name, annual_sal�� �����Ͻÿ�.
    ���������� -> (�޿�+�޿�*���ʽ���)*12
    ���̸�:v_emp_salalry
    ��. ������ ���ڸ����� �ĸ� ����
**/
create or replace view v_emp_salalry
(emp_id,l_name,annual_sal)
as
    select employee_id,last_name, 
       to_char((salary+(salary*nvl(commission_pct,0)))*12,'$999,999')
        "����"
    from employees
    order by "����" asc;    

/**
-������ ���� view����
�ó�����] ������̺�� �μ����̺�, �������̺��� �����Ͽ� ���� ���ǿ� ����
�並 �����Ͻÿ�.
    ����׸� : �����ȣ, ��ü�̸�, �μ���ȣ, �μ���, �Ի�����, ������
    ���Ǹ�Ī : v_emp_join
    ���� �÷� : empid,fullname,deptid, deptname, hdate, locname
    �÷��� ������� : 
        fullname => first_name + last_name
        hdate =>< 0000sus00��00��
        locname => xxxx���� YYY(ex: Texas���� southlake)
*/
--1. select ������ �ۼ�
select employee_id,first_name||' '||last_name "fullname",
    department_id, department_name, 
    to_char(hire_date,'YYYY"��"MM"��"DD"��"')"hdate",
    city||'���� '||state_province "locname"
from employees
    inner join departments using (department_id)
    inner join locations using(location_id);
--2. view�����
create or replace view v_emp_join
(empid,fullname,deptid,deptname,hdate,locname)
as
    select employee_id,first_name||' '||last_name "fullname",
        department_id, department_name, 
        to_char(hire_date,'YYYY"��"MM"��"DD"��"')"hdate",
        city||'���� '||state_province "locname"
    from employees
        inner join departments using (department_id)
        inner join locations using(location_id);
select * from v_emp_join;    
--3. ������ �������� view�� ���� ������ ��ȸ�� �� �ִ�.
select *from v_emp_join;






