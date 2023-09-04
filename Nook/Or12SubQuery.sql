/******************************************************************************
���ϸ�: Or12SubQuery.sql
��������
����: ������ �ȿ� �� �ٸ� �������� ���� ������ select��
    where���� select���� ����ϸ� ����������� �Ѵ�.
*******************************************************************************/
--HR����

/*
������ ��������
    �� �ϳ��� �ุ ��ȯ�ϴ� ���������� �񱳿�����(=,<,<=,>,>=,<>)�� ���.
  ����]
    select *from ���̺�� where �÷�=(
            select �÷� from ���̺�� where ����
        );
    *��ȣ���� ���������� �ݵ��! �ϳ���! ����� �����ؾ� �Ѵ�.(�������� �� �ٸ�)    
*/
/*
�ó�����] ������̺��� ��ü����� ��ձ޿����� ���� �޿��� �޴� ������� ����.
    ����׸� : �����ȣ, �̸�, �̸���, ����ó, �޿�
*/
-------------------------Nook
select employee_id, first_name , email, phone_number, salary 
    from employees
    where salary<(select avg(salary) from employees);
-----------------------------
--1. ��ձ޿� ���ϱ� : 6462
select avg(salary) from employees;

--2.�ش� �������� ���ƻ� �´� �� ������ �׷��Լ��� �������� ������ ������ ����.
select * from employees where salary<avg(salary);
--3. �տ��� ���� ��� �޿��� �������� select�� �ۼ�
select * from employees where salary<3632;--���ڷ� �����ϱ� �����ϳ�?
--4. �ΰ��� �������� �ϳ��� �������������� ���ļ� ����� Ȯ���Ѵ�.
select employee_id, first_name, email, phone_number, salary
    from employees 
    where salary<(
        select avg(salary) from employees);
/*
����] ��ü ����� �޿��� �������� ����� �̸��� �޿��� ����ϴ� 
    ���������� �ۼ��Ͻÿ�.
    ����׸� : �̸�1,�̸�2,�̸���, �޿�
*/
--------------------------------NOOOK
select first_name||' '||last_name "name",email, salary
from employees
where salary =(select min(salary) from employees);
--------------------------------------------------------
--1�ܰ� : �ּұ޿��� Ȯ���Ѵ�.
select min(salary) from employees;
--2�ܰ� : 2100�� �޴� ������ ������ �����Ѵ�.
select * from employees where salary= 2100;
--3�ܰ� : �ΰ��� �������� ���ļ� ���������� �����.
select * from employees where salary=(select min(salary) from employees);

/*
�ó�����] ��ձ޿��� ���� �޿��� �޴� �������  ����� ��ȸ�� �� �ִ�
���������� �ۼ�
    ��� ���� : �̸�1,�̸�2, ��������, �޿�
    *���������� jobs���̺� �����Ƿ� join�ؾ���.
*/
-----------------------------------------------------NOOK
select first_name,last_name, job_title, salary
from employees
    inner join jobs using(job_id)
where salary>(select avg(salary) from employees)
order by salary;
---------------------------------------------------------------
--�ܰ� 1.��ձ޿�
select avg(salary) from employees;
--2�ܰ� : ���̺� ����
select first_name, last_name, job_title, salary
from employees
    inner join jobs using (job_id)
where salary>6462;
--3�ܰ� : �������������� ����
select first_name, last_name, job_title, salary
from employees
    inner join jobs using (job_id)
where salary>(select avg(salary) from employees);

/*
���� ����������
**/
/*
�ó�����] ���������� ���� ���� �޿��� �޴� ����� ����� ��ȸ�Ͻÿ�.
    ��¸�� : ������̵�, �̸�, ������ ���̵�, �޿�
*/
--------------------------------------------NOOK
select employee_id,first_name,job_id,salary
from employees where salary in 
(select max(salary) from employees group by job_id)
group by job_id;
--�������� �����Ƿ� in �ھ����¡~~����
------------------------------------------------------------
--1�ܰ� �������� ���� ���� �޿� Ȯ��
select job_id ,  max(salary) from employees group by job_id;
--select max(salary) from employees group by job_id;

--2�ܰ�. ���ǰ���� �ܼ��� or �������� ���´�.
select * from employees
where 
    (job_id='SH_CLERK' and salary=4200) or
    (job_id='AD_ASST' and salary=4400) or
    (job_id='MK_MAN' and salary=1300) or
    (job_id='MK_REP' and salary=6000);
--3�ܰ�. : ������ �����ڸ� ���� ���������� �����Ѵ�.
select employee_id,first_name,job_id,salary
from employees 
where (job_id, salary) 
    in
    ( 
    select job_id ,  max(salary) from employees group by job_id
    )
order by salary;

/*
������ ������ : any
    ���������� �������� 
    ���������� �˻������ �ϳ��̻� ��ġ�ϸ� ���̵Ǵ� ������.
    ��, ���� �ϳ��� ���̸� ����(or�� ���ӻ� ���)
*/
/*
�ó�����] ��ü ����߿��� �μ���ȣ�� 20�� ������� �޿����� ���� �޿��� 
    �޴� �������� �����ϴ� ������������ �ۼ��Ͻÿ�.
    ��, ���� �ϳ��� �����ϴ��� �����Ͻÿ�.
*/
---------------------------------------------NOOK
select * from employees where salary >any
( select salary from employees where department_id  = 20);
---------------------------------------------------
--1�ܰ� : 20�μ� �޿�Ȯ��
select salary from employees where department_id  = 20;
--2�ܰ� : 1���� ����� �ܼ��� or���� �ۼ�
select first_name, salary from employees
where salary >13000 or salary>6000;
--3�ܰ� : ���� �ϳ��� �����ϸ� �ǹǷ� ������ ������ any�� �̿��ؼ� 
--  ���������� �����ȴ�. �� 6000���� ũ�� �Ǵ� 13000���� ū �������� ����.
select 
    first_name, salary 
from 
    employees
where 
    salary>any(select salary from employees where department_id  = 20);
/*
������ ������3: all�� and�� ����� �����Ѵ�.
    ���������� �������� ���������� �˻������ ��� ��ġ�ؾ� ���ڵ带 �����Ѵ�.
*/
/*
�ó�����] ��ü �����߿��� �μ���ȣ�� 20�� ������� �޿����� ���� �޿��� �޴� 
�������� �����ϴ� ������������ �ۼ��Ͻÿ�. ��, �� �� �����ض�.
*/
select first_name, salary 
from employees
where salary >all 
    (select salary from employees where department_id = 20);
--13000���� ū�ֵ�!    
--6000�̻� ���ÿ� 13000�̻��̿��� �ϹǷ� ��������� 13000�̻��� ���ڵ� ����.
/*
rownum : ���̺��� ���ڵ带 ��ȸ�� ������� ������ �ο��Ǵ� ������ �÷�.
�ش� �÷��� ��� ���̺� �������� �����Ѵ�.
*/
--��� ������ �������� �����ϴ� ���̺��̴�.
select * from dual;
--���ڵ��� ���ľ��� ��� ���ڵ带 �����ͼ� rownum�� �ο��Ѵ�.
--�� ��� rownum�� ������� ��µȴ�.
select employee_id, first_name,rownum from employees;
--�̸��� ������������ �����ϸ� rownum�� ������ �̻��ϰ� ���´�.
select employee_id, first_name, rownum from employees order by first_name;
/*
rownum�� �츮�� ������ ������� ��ο��ϱ� ���� ���������� ����Ѵ�.
from������ ���̺��� ���;� �ϴµ�, �Ʒ��� �������������� ������̺���
��ü ���ڵ带 ������� �ϵ� �̸��� ������������ ���ĵ� ���·� ���ڵ带
�����ͼ� ���̺�ó�� ����Ѵ�.
*/
select first_name, rownum
from (select* from employees order by first_name asc);
--���� ���̺��� �̸��� ������������ �����ؼ� �ο�� init.
--���̺��� �����ؼ� ���ο� ���̺��� �� �Ͱ� ����� ȿ��.

--------------------------------------------------------
--------------- Sub Query �� �� �� �� ------------------ 
--------------------------------------------------------

-- scott�������� �����մϴ�. 
/*
01.�����ȣ�� 7782�� ����� ��� ������ ���� ����� ǥ���Ͻÿ�.
��� : ����̸�, ��� ����
*/
select* from emp;
select ename,job
    from emp
    where job =(select job from emp where  empno=7782);


/*
02.�����ȣ�� 7499�� ������� �޿��� ���� ����� ǥ���Ͻÿ�.
��� : ����̸�, �޿�, ������
*/
select ename, sal, job
    from emp
    where sal>(select sal from emp where empno=7499);


/*
03.�ּ� �޿��� �޴� �����ȣ, �̸�, ��� ���� �� �޿��� ǥ���Ͻÿ�.
(�׷��Լ� ���)
*/
select empno,ename,job,sal
from emp 
where sal=(select min(sal) from emp);

/*
04.��� �޿��� ���� ���� ����(job)�� ��� �޿��� ǥ���Ͻÿ�.
*/

select job, avg(sal)  from emp 
group by job
having avg(sal)<=all(select avg(sal) from emp group by job);
/*
05.�� �μ��� �ּ� �޿��� �޴� ����� �̸�, �޿�, �μ���ȣ�� ǥ���Ͻÿ�.
*/

select ename,sal,deptno from emp
where sal in (select min(sal) from emp group by job);


/*
06.��� ������ �м���(ANALYST)�� ������� �޿��� �����鼭 
������ �м���(ANALYST)�� �ƴ� ������� ǥ��(�����ȣ, �̸�, ������, �޿�)
�Ͻÿ�.
*/
select empno,ename,job,sal from emp
where sal<all(select sal from emp where lower(job)='analyst') and 
    not lower(job)='analyst';


/*
07.�̸��� K�� ���Ե� ����� ���� �μ����� ���ϴ� ����� 
�����ȣ�� �̸�, �μ���ȣ�� ǥ���ϴ� ���Ǹ� �ۼ��Ͻÿ�
*/
select empno, ename, deptno from emp 
where job in 
    (select job from emp where upper(ename) like '%K%');

/*
08.�μ� ��ġ�� DALLAS�� ����� �̸��� �μ���ȣ �� ��� ������ ǥ���Ͻÿ�.
*/
select deptno from dept where lower(loc) = 'dallas';
select ename,deptno,job from emp where deptno = 20;
select ename, deptno,job from emp 
    where deptno =(select deptno from dept where lower(loc) = 'dallas');

/*
09.��ձ޿� ���� ���� �޿��� �ް� �̸��� K�� ���Ե� ����� ���� 
�μ����� �ٹ��ϴ� ����� �����ȣ, �̸�, �޿��� ǥ���Ͻÿ�.
*/
select empno,ename, sal, deptno from emp
where deptno in(select deptno from emp where ename like '%K%') and
    sal>(select avg(sal) from emp);

/*
10.��� ������ MANAGER�� ����� �Ҽӵ� �μ��� ������ �μ��� ����� ǥ���Ͻÿ�.
*/
select * from emp 
where deptno in (select deptno from emp where lower(job)='manager');


/*
11.BLAKE�� ������ �μ��� ���� ����� �̸��� �Ի����� ǥ���ϴ� 
���Ǹ� �ۼ��Ͻÿ�. (��, BLAKE�� ����)
*/
select ename from emp 
where deptno =(select deptno from emp where lower(ename)='blake')

