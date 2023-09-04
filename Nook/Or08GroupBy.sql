/**********************************
���ϸ�: Or08GroupBy.sql
�׷��Լ�(select�� 2��°)
����: ��ü ���ڵ�(�ο�)���� ������� ����� ���ϱ� ���� �ϳ��̻��� ���ڵ带 �׷����� ��� ���� ��
    ����� ��ȯ�ϴ� �Լ�. Ȥ�� ������
***********************************/
--HR����

--��� ���̺��� ������ ���� : �� 107���� ���� ��.
select job_id from employees;

/*
distinct
    -������ ���� �ִ� ��� �ߺ��� ���ڵ带 ������ �� �ϳ��� ���ڵ常 �����ͼ� �����ش�.
    -�ϳ��� ������ ���ڵ� �̹Ƿ� ������� ���� ����� �� �ִ�.
*/
select distinct job_id from employees; --�ѹ����� ����.
select distinct job_id, count(*) from employees group by job_id; --�ѹ����� ����.

/*
group by 
    -������ ���� �ִ� ���ڵ带 �ϳ��� �׷����� ��� �����´�.
    -�������� �� �������� ���ڵ����� �ټ��� ���ڵ尡 �ϳ��� �׷����� ������ ����̹Ƿ� 
       ������� ���� �Ի��� �� �ִ�.
    -�ִ�,�ּ�,���, �ջ���� ������ �����ϴ�.
*/
--�� �������� ���� ���� ������� ī��Ʈ �Ѵ�.
select job_id, count(*) from employees group by job_id;
select job_id from employees group by job_id;

--������ ���� �ش� ������ ���� select�ؼ� ����Ǵ� ���� ������ ���� ����.
select first_name, job_id from employees where job_id='FI_ACCOUNT';--5�� Ȯ��.
select first_name, job_id from employees where job_id='ST_CLERK'; --20

/*
group ���� ���Ե� select ���� ����
    select
        �÷�1,�÷�2,...Ȥ�� ��ü(*)
    from
        ���̺��
    where
        ����1 and ����2 or ����3
    group by
        ���ڵ� �׷�ȭ�� ���� �÷���
    having
        �׷쿡���� ����
    order by
        ������ ���� �÷���� ���Ĺ��
*������ �������        
    from ���̺� -> where���� -> group by  �׷�ȭ -> having(�׷�����)
        -> select(�÷�����) -> order by (���Ĺ��)
*/
/*
sum() : �հ踦 ���� �� ����ϴ� �Լ�.
    -number Ÿ���� �÷������� ����� �� �ִ�.
    -�ʵ���� �ʿ��� ��� as�� �̿��ؼ� ��Ī�� �ο��� �� �ִ�.
*/
--��ü ������ �޿��� �հ踦 ����Ͻÿ�.
--where���� �����Ƿ� ��ü������ ������� �Ѵ�.
select 
    sum(salary) "sumsal1"
    to_char(sum(salary),'999,000')"sumsalary2",
    ltrim(to_char(sum(salary),'L999,000')) "sumSalary3", --"���� ���� ����,��ȭǥ��(�ڵ�)"
    ltrim(to_char(sum(salary),'$999,000')) "sumSalary4" --"��ȭ��ȣ����";
from employees;   

select 
    sum(salary) sumsal1,
    to_char(sum(salary),'999,000')sumsalary2,
     ltrim(to_char(sum(salary),'L999,000'))  sumSalary3,
    ltrim(to_char(sum(salary),'$999,000')) sumSalary4
from employees;    
--10�� �μ��� �ٹ��ϴ� ������� �޿��� �հԴ� ������ ����Ͻÿ�.
select 
    sum(salary) "�޿��հ�",
    to_char(sum(salary),'999,000')"���ڸ� �ĸ�",
     ltrim(to_char(sum(salary),'L999,000'))  "���� ���� ����,��ȭǥ��(�ڵ�)",
    ltrim(to_char(sum(salary),'$999,000')) "��ȭ��ȣ����"
from employees where department_id=10;    


--sum()�� ���� �׷��Լ��� numberŸ���� �÷������� ����� �� �ִ�.
select sum(first_name) from employees; --error

/*
count() :�׷�ȭ�� ���ڵ��� ������ ī��Ʈ �� �� ����ϴ� �Լ�.
*/
select count(*) from employees;
/*
count() �Լ��� ����� ���� �� 2��2�� ��� ��� ���������� *�� ����� ���� ����.
    �÷��� Ư�� Ȥ�� �����Ϳ� ���� ���ظ� ���� �����Ƿ� ����ӵ��� ������.
*/
/*
count()�Լ��� 
    ���� 1: count(all �÷���)
        => ����Ʈ �������� �÷� ��ü�� ���ڵ带 �������� ī��Ʈ�Ѵ�.
    ���� 2: count(distinct �÷���)
        => �ߺ��� ������ ���׿��� ī��Ʈ�Ѵ�.
*/

select
    count(job_id) "������ ��ü ����1",
    count(*),
    count(all job_id) "������ ��ü ����2",
    count(distinct job_id) "���� ������ ����"
from employees;    
select count(first_name),count(commission_pct),count(manager_id) from employees;
--null�� ���� ������ ġ����.

/*
avg():��հ��� ���� �� ����ϴ� �Լ�
*/
--��ü����� ��ձ޿��� ������ ����ϴ� �������� �ۼ��Ͻÿ�

select 
    count(*) "��ü�����",    
    sum(salary) "����޿��� ��",
    trunc(sum(salary)/count(*),2) "��ձ޿� �������",
    round(avg(salary),2) "��ձ޿� avg()",
    avg(salary) "��ձ޿� avg()",
    trim(to_char(avg(salary), '$999,000'))"���� �� ��������"
from employees;

--������(sales)�� ��ձ޿��� ���ΰ���?
--1.�μ����̺��� �������� �μ���ȣ�� �������� Ȯ��
/*
�����˻��� ��ҹ��� Ȥ�� ������ ���Ե� ��� ��� ���ڵ忡 ���� 
���ڿ��� Ȯ���ϴ� ���� �Ұ����ϹǷ� �ϰ����� ��Ģ�� ������ ���� 
upper()�Լ��� ���� ��ȯ�Լ��� ����ϴ°��� ����.
*/
select * from departments where department_name = initcap('sales');--�μ���ȣȮ��
select *from departments where lower(department_name) ='sales' ;
select * from departments where upper(department_name)=upper('SALES');
--�μ���ȣ�� 80�ΰ��� Ȯ���� �� ���� �������� �ۼ��Ѵ�.
select ltrim(to_char(avg(salary),'$999,000,00'))
    from employees where department_id =80;
/*
min(),max() �Լ� : �ִ밪, �ּҰ��� ã�� �� ����ϴ� �Լ�
*/
--��ü ����� ���� ���� �޿��� ���ΰ���
select min(salary) from employees;
--��ü ����� �޿��� ���� ���� ������ �����ΰ���?
--�Ʒ� �������� error�� �߻���. �׷��Լ��� �Ϲ��÷��� ����� �� ����.
select first_name, salary from employees where salary=min(salary); --error

--������̺��� ���� ���� �޿��� 2100�� �޴� ����� �����Ͻÿ�.
select first_name, salary from employees where salary=2100; 
/*
    ��� �� ���� ���� �޿��� min() �Լ��� ���� �� ������, ���� ���� �޿���
    �޴� ����� �Ʒ��� ���� ���������� ���� ���� �� �ִ�.
    ���� ������ ���� ���������� ������� ���θ� �����ؾ��Ѵ�.
*/    
select first_name, salary from employees where salary = ( 
    select min(salary) from employees);
    --where�� ���ǿ� �������������ۼ��Ͽ� ����־����.
/*
group by �� : �������� ���ڵ带 �ϳ��� �׷����� �׷�Ȳ�Ͽ� ������
    ����� ��ȯ�ϴ� ������
        *distinct�� �ܼ��� �ߺ����� ������.
*/
--������̺��� �� �μ��� �޿��� �հ�� ���ΰ���?
--IT�μ��� �޿� �հ�
SELECT SUM(salary) FROM employees WHERE department_id=60;
--finance �μ��� �޿� �԰�
SELECT SUM(salary) FROM employees WHERE department_id=100;
SELECT ltrim(to_char(SUM(salary),'$999,000')) FROM employees WHERE department_id=100;


/*
step1 : �μ��� ���� ��� ������ �μ����� Ȯ���� �� �����Ƿ� �μ��� �׷�ȭ�Ѵ�.
    �ߺ��� ���ŵ� ����� �������� ������ ���ڵ尡 �ϳ��� �׷����� ������ �������.
*/
select department_id from employees group by department_id;
/*
step2 : �� �μ����� �޿��� �հ踦 ���� �� �ִ�. 4�ڸ��� �Ѿ�� ���
    �������� �������Ƿ� ������ �̿��ؼ� ���ڸ����� �ĸ��� ǥ���Ѵ�.
*/
Select Department_Id , Sum(Salary), Trim(To_Char(Sum(Salary),'$999,000')) 
From Employees
Group By Department_Id
Order By Sum(Salary) Desc;

/*
����] ������̺��� �� �μ��� ������� ��ձ޿��� ������ ����ϴ� ������.
��°�� : �μ���ȣ, �޿�����, �������, ��ձ޿�
��½� �μ���ȣ�� �������� �������� ����.
*/

select department_id, sum(salary), count(*), avg(salary) 
from employees
group by department_id
order by department_id;

select sum(salary), count(*), avg(salary) 
from employees;
--group by department_id
--order by department_id;

select 
    department_id "�μ���ȣ", 
    ltrim(to_char(sum(salary),'$999,999,990'))"�μ��� �����հ�", 
    count(*)"�μ��ο���", 
    to_char(avg(salary),'$999,990') "�μ��� �������"
from employees
group by department_id
order by department_id;

select 
    department_id "�μ���ȣ", 
    ltrim(to_char(sum(salary),'$999,999,990'))"�μ��� �����հ�", 
    count(first_name)"�μ��ο���", 
    to_char(avg(salary),'$999,990') "�μ��� �������"
from employees
group by department_id
order by department_id;


--�⺻��
select
    department_id,sum(salary), count(*),avg(salary)
from employees
group by deartment_id
order by department_id asc;

--���İ� �Ҽ��� ����
select
    department_id "�μ���ȣ",
    rtrim(to_char(sum(salary),'999,000')) "�޿��հ�", 
    count(*) "��� ��",
    rtrim(to_char(avg(salary),'999,000')) "��ձ޿�"
from employees
group by department_id
order by department_id asc;    

/*
�տ��� ����ߴ� �������� �Ʒ��� ���� first_name�÷��� �߰��Ͽ� �����ϸ� ����.
group by ������ ����� �÷��� select������ ����� �� ������ �� ���� �����÷���
select������ ����� �� ����.
�׷�ȭ�� ���¿��� Ư�� ���ڵ� �ϳ��� �����Ͽ� �����ϴ� ���� �ָ��ϱ� �����̴�.
*/
select
    department_id,sum(salary), count(*),avg(salary), first_name
from employees
group by deartment_id
order by department_id asc;

/*
�ó�����] �μ����̵� 50�� ������� ��������, ��ձ޿�, �޿�������
    ������ ����ϴ� ������ �ۼ��Ͻÿ�.
*/
select count(*), avg(salary),sum(salary)
from employees
group by department_id
having department_id='50';

select '50���μ�', count(*), round(avg(salary)),sum(salary)
from employees where department_id = '50'
group by department_id;
--having department_id='50';

/*
group by �� ������ having�� 
 -���������� �����ϴ� �÷��� �ƴ� �׷��Լ��� ���� 
    �������� ������ �÷��� ������ �߰��� �� ����Ѵ�.
    �ش� ������ WHERE�����߰��ϸ� ������ �߻��Ѵ�.
*/
/*
�ó�����] ������̺��� �� �μ����� �ٹ��ϰ� �ִ� ������ ��������
    ������� ��ձ޿��� ������ ����ϴ� �������� �ۼ��Ͻÿ�.
    ��, ������� 10�� �ʰ��ϴ� ���ڵ常 �����Ͻÿ�.
*/
/*
���� �μ��� �ٹ��ϴ��� �������� �ٸ� �� �Ӥ����Ƿ� �� ����������
group by ���� 2���� �÷��� ����ؾ� �Ѵ�. �� �μ��� �׷�ȭ ����
�ٽ� ���������� �׷�ȭ �Ѵ�.
*/3
SELECT DEPARTMENT_ID, job_id, count(first_name), avg(salary)
from employees
--where count(*)>10  --���⼭ �����߻�
group by department_id, job_id;
--having count(*)>10;
/*
�������� ������� ���������� �����ϴ� �÷��� �ƴϹǷ� where���� ������ ����.
�̷� ��� having���� ������ �־����.
ex) ��� �޿��� 3000�� ��� => ���������� ������� �����ϹǷ� having�� ���
                                ��, �׷��Լ��θ� ���� �� �ִ� ��������.
*/
SELECT DEPARTMENT_ID, job_id, count(first_name), avg(salary)
from employees
--where count(*)>10  --���⼭ �����߻�
group by department_id, job_id
having count()>10;
/**/
SELECT DEPARTMENT_ID, job_id, count(first_name), avg(salary)
from employees
--where count(*)>10  --���⼭ �����߻�
group by rollup(department_id, job_id)
having count()>10;

/******************
����] �������� ����� �����޿��� ����Ͻÿ�.
��,(������(manager)�� ���� ����� �����޿��� 3000�̸��� �׷�) �� ����.
����� �޿��� ������������ ����
********************/

select job_id, min(salary) from employees
where  manager_id is not null --and  salary =(min(salary) from employees)
group by job_id
having not min(salary)<3000 --min(salary)>=3000(����� ������ �� �������� �������忡 �����
order by min(salary) desc;

/*
 ���������� �޿��� ������������ �����϶�� ���û����� ������,
 ���� select�Ǵ� �׸��� �޿��� �ּҰ��̹Ƿ� order by ������ min(salary)�� ����ؾ� �Ѵ�.
 */
 
 --�ش繮���� hr������ employees ���̺� ����Ѵ�.
 /*
 1. ��ü ����� �޿��ְ��, ������, ��ձ޿����.
 �÷� ��Ī�� �Ʒ��� ����. ����� �������·� �ݿø�.
 �޿� ������ -> MinPay
 �޿� �ְ�� -> MaxPay
 �޿� ��� -. AvgPay
 */
 select
    Max(salary)"MaxPay", Min(salary) as MinPay, 
    trim(to_char(avg(salary),'999,000'))  Avgtochartrim,
    round(avg(salary)) avground,
    trunc(avg(salary)) avgtrunc,
    avg(salary) avgorigin,
    to_char(avg(salary),'999,000')  Avgtochar
from     employees;
 /*
 2. �� ������ �������� �޿��ְ��, ������ ,�Ѿ� �� ��վ��� ���.
 �÷��� ����Ī�� �Ʒ�����. �����ڴ� tochar�� ���ڸ����� �ĸ�.
 */
 select job_id,to_char(max(salary),'$999,999')"maxpay",
        to_char(min(salary) ,'$999,999') minpay,
        to_char(sum(salary),'$999,999') sumpay, 
        to_char(avg(salary),'$999,999') avgpay
        from employees
        group by job_id;
 /********
 3. count() �Լ�. ������ ���ϻ�� ���.
 ����) emplyees ���̺��� job_id ����.
 */
 select job_id, count(*)"�ο���" 
 from employees 
 group by job_id order by "�ο���";
 
 /*
 4. �޿��� 10000�޷� �̻��� �������� �������� �հ��ο��� ���
 */

select job_id, count(*)"������ �ο���" 
from employees
where salary>10000
group by job_id
order by "������ �ο���";

/**
5. �޿� �ְ�װ� �������� ������ ����Ͻÿ�.
*/

select max(salary)"�޿� �ְ��" , min(salary)"�޿� ������", 
        (max(salary)-min(salary)) "�޿� ����"
    from employees;    
/*
6. �� �μ��� ���� �μ���ȣ, �����, �μ� ���� ��� ����� ��ձ޿��� 
����Ͻÿ�. ��ձ޿��� �Ҽ��� ��°�ڸ��� �ݿø��Ͻÿ�.
*/
select department_id ,count(*) , round(avg(salary),2) from employees
group  by department_id;