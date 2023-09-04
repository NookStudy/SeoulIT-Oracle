/******************************************************************************
���ϸ�: Or11join.sql
���̺� ����
����: �ΰ� �̻��� ���̺��� ���ÿ� �����Ͽ� 
        �����͸� �����;� �� �� ����ϴ� SQL��
*******************************************************************************/
--HR����
/***
1] inner join (��������)
    -���� ���� ���Ǵ� ���ι����� ���̺��� ���������� ��� �����ϴ�
    ���ڵ带 �˻��� �� ����Ѵ�.
    - �Ϲ������� �⺻Ű(Primary key)�� �ܷ�Ű(foreign key)�� ����Ͽ� 
    join�ϴ� ��찡 ��κ��̴�.
    -�ΰ��� ���̺� �̸��� �÷��� �����ϸ� "���̺��.�÷���"���·� ���.
    -��Ī�� ���� "��Ī.�÷���" ���·� �������.
    
����1(ǥ�ع��)
    select �÷�1,�÷�2,...
    from ���̺�1 inner join ���̺�2
        on ���̺�1.�⺻Ű�÷� = ���̺�2. �ܷ�Ű�÷�
    where ����1 and ����2...;    
**/
/*
�ó�����] ������̺�� �μ����̺��� �����Ͽ� �� ������ 
    ��μ����� �ٹ��ϴ��� ����Ͻÿ�. �� ǥ�ع������ �ۼ�.
    ��°�� : ������̵�, �̸�1, �̸�2, �̸���, �μ���ȣ, �μ���
*/
desc employees;
--ù��° �������� ������ �߻��Ѵ�.
/*
ORA-00918 : ���� ���ǰ� �ָ��մϴ�.
00918.00000 - "column ambigously defined"
department_id�� join�� ���� ���̺� �����ϴ� �÷��̹Ƿ�
� ���̺��� ������ ������� �����ؾ� �ȴ�.
*/
select 
    employee_id, first_name, last_name, email, department_id, department_name
from 
    employees inner join departments
ON
    Employees.department_id = departments.department_id;
    --���� ���ǰ� �ָ��� ��� �÷��տ� ���̺���� �߰��Ѵ�.
--ANSIǥ���̶� ���ư��� �ʴ´�! �� �ƴ϶� �÷������� �ָ��ؼ� ����.
select 
    employee_id, first_name, last_name, email, 
    employees.department_id,  --clarify
    department_name
from 
    employees inner join departments
ON
    Employees.department_id = departments.department_id;    
--���� ���̺���� ��Ȯ�� ����.    
    
--as(�˸��ƽ�)�� ���� ���̺� ��Ī�ο� �� ������ ����ȭ.
select 
    employee_id, first_name, last_name, email, 
    emp.department_id,  --clarify
    department_name
from 
    employees emp inner join departments dep
ON
    Emp.department_id = dep.department_id;
/*
���� ��������� �Ҽӵ� �μ��� ���� 1���� ������ ������ ��ΰ� ��µ�.
��, inner join�� ������ ���̺��� ���ʸ�� �����Ǵ� ���ڵ常 �������� ��.
*/
select 
    employee_id, first_name, last_name, email, 
    emp.department_id,  --clarify
    department_name
from 
    employees emp full outer join departments dep
ON
    Emp.department_id = dep.department_id
where dep.department_id is not null; --or  dep.department_id is null;

--3�� �̻��� ���̺� �����ϱ�
/*
�ó�����] seattle�� ��ġ�� �μ����� �ٹ��ϴ� ������ ������ ����ϴ� ������ �ۼ�.
    �� ǥ�ع������.
    ��°��] ����̸�, �̸���, �μ����̵�, �μ���, ���������̵�,
        ��������, �ٹ�����
    �� ��°���� ���� ���̺� �����Ѵ�. 
    ������̺� : ����̸�, �̸���, �μ����̵�, ���������̵�
    �μ����̺� : �μ����̵�(����), �μ���, �����Ϸù�ȣ(����), etc
    ���������̺� : ��������, ���������̵�(����),etc
    ���� ���̺� : �����Ϸù�ȣ(����),  �ٹ��μ�, etc
    */
--1.���� ���̺��� ���� ���ڵ� Ȯ���ϱ� -> �����Ϸù�ȣ 1700Ȯ��
select *from locations where lower(city)='seattle';
--2. ���� �Ϸù�ȣ�� �������� �μ����̺�� ����
select * from departments where location_id =1700;
--3. �μ� �Ϸù�ȣ�� ���� ������̺��� ���ڵ� Ȯ���ϱ� ->6�� Ȯ��
select * from employees where department_id=30;
--4. ������ ������ Ȯ���ϱ�
select * from jobs where job_id='PU_MAN';
select * from jobs where job_id='PU_CLERK';

select dep.location_id, first_name, email, dep.department_id, 
    department_name, emp.job_id, job_title, city, state_province
from locations L 
    inner join departments dep on L.location_id=dep.location_id
    inner join employees emp on dep.department_id=emp.department_id
    inner join jobs J on emp.job_id=J.job_id
where lower(city) = 'seattle';    --lower�� �ھ�����...Seattle��

/*
����2] ����Ŭ ���
    select �÷�1, �÷�2,....
    from ���̺�1, ���̺�2...
    where ���̺�1.�⺻Ű�÷�=���̺�2.�ܷ�Ű�÷�
        and ����1 and ����2....
*/
/*
�ó�����]������̺�� �μ����̺��� �����Ͽ� �� ������ 
    ��μ����� �ٹ��ϴ��� ����Ͻÿ�. �� ����Ŭ������� �ۼ�.
    ��°�� : ������̵�, �̸�1, �̸�2, �̸���, �μ���ȣ, �μ���
*/

select employee_id, first_name, last_name , email, 
    emp.department_id as D_ID, department_name
from employees emp, departments dep
--where emp.department_id = dep.department_id;
Where Emp.Department_Id= Dep.Department_Id;
/*
�ó�����] seattle�� ��ġ�� �μ����� �ٹ��ϴ� ������ ������ ����ϴ� ������ �ۼ�.
    �� ����Ŭ�������.
    ��°��] ����̸�, �̸���, �μ����̵�, �μ���, ���������̵�,
        ��������, �ٹ�����
    �� ��°���� ���� ���̺� �����Ѵ�. 
    ������̺� : ����̸�, �̸���, �μ����̵�, ���������̵�
    �μ����̺� : �μ����̵�(����), �μ���, �����Ϸù�ȣ(����), etc
    ���������̺� : ��������, ���������̵�(����),etc
    ���� ���̺� : �����Ϸù�ȣ(����),  �ٹ��μ�, etc
*/
select first_name, email, E.department_id, department_name, 
    J.job_id, job_title, city, state_province
from locations L, departments D, employees E, jobs J
where L.location_id=D.location_id and
    D.department_id = E.department_id and
    J.job_id = E.job_id and
    city=initcap('seattle');
/*
2] outer join(�ܺ�����)
   -outer join �� inner join���� �޸� 
      �� ���̺� ���������� ��Ȯ�� ��ġ���� �ʾƵ� ������ �Ǵ� ���̺���
      ���ڵ带 �����ϴ� join����̴�.
   -outer join�� ����� ���� �ݵ�� outer ���� ������ �Ǵ� ���̺��� �����ϰ�
      �������� �ۼ��ؾ� �Ѵ�.
    -> left(���� ���̺�), right(������ ���̺�), full(���� ���̺�)

���� 1(ǥ�ع��)
    select �÷�1, �÷�2,...
    from ���̺� 1 
            left[right,full] outer join ���̺�2
                on ���̺�1.�⺻Ű = ���̺�2.�ܷ�Ű
    where ����1 and ����2 or....
*/    
/*
�ó�����] ��ü������ �����ȣ, �̸�, �μ����̵�, �μ���, ������ 
    �ܺ����� left�� ���� ����Ͻÿ�
*/          
--�������� ���� inner join ���� �ٸ��� 107���� �����.
--�μ��� �������� ������� ����Ǳ� �����ε�, �̶� ���ڵ忡 �μ����̵� �����Ƿ�
--null���� ��µȴ�.
select employee_id, first_name, emp.department_id , department_name, city
    from employees  emp
        right outer join departments dep
            on emp.department_id=dep.department_id
--        left outer join locations L
        left outer join locations L
            on dep.location_id = L.location_id;
    --employees�� �������� left�� emplyee, right�� right�����̺��� �������� 
    --  �������� ��ĥ�� �����̴�.
/*
����2 (����Ŭ���)
    select �÷�1, �÷�2,....
    from ���̺�1, ���̺�2
    where
        ���̺�1.�⺻Ű=���̺�2.����Ű(+)
        and ����1 or ����2 ...;
=>����Ŭ ������� ����ÿ��� outer join ��������(+)�� �ٿ��ش�.
=> ���ǰ�� ���� ���̺��� �����̵ȴ�.
=> ������ �Ǵ� ���̺��� �����Ҷ��� ���̺��� ��ġ�� �Ű��ش�.
    (+)�� �ű��� �ʴ´�.
*/
select emplyee_id, first_name, E.department_id, department_name, city
from Employees E, departments D, locations L
where
    E.department_id= D.department_id(+)
    D.location_id = L.location_id (+) ;
/*
��������] 2007�� �Ի��� ��ȸ. ��, �μ��� ��ġ�����ʾ����� <�μ����� ���>
��, ǥ�ع������ �ۼ�.
��� : ���, �̸�, ��, �μ���
*/
select employee_id, first_name, last_name, nvl(department_name,'�μ�����')
from employees E
    left outer join departments D
        on E.department_id = D.department_id
where to_char(hire_date,'yyyy') = 2007;        

--���� ������ Ȯ��
select first_name,hire_date,to_char(hire_date,'yyyy') from employees;
--07�� �Ի��� ����
--���1: like�� �̿��Ͽ� 07�� �����ϴ� ���ڵ� ����
select first_name,hire_date from employees where hire_date like'07%';
--���2: to_char�� ��¥���� ������ ���ڵ� ���
select first_name,hire_date from employees where to_char(hire_date,'yyyy')='2007';
--�ܺ�����
select employee_id, first_name, last_name, nvl(E.department_id,'<�μ� ����>')
from employees E
    left outer join departments D 
        on E.department_id = D.department_id
where to_char(hire_date,'yyyy')=2007;

select employee_id, first_name, last_name, nvl(department_name,'�μ�����')
from employees E
    left outer join departments D
        on E.department_id = D.department_id
where to_char(hire_date,'yyyy') = 2007; 


/*
��������] 2007�� �Ի��� ��ȸ. ��, �μ��� ��ġ�����ʾ����� <�μ����� ���>
��, ����Ŭ��ķ� �ۼ�.
��� : ���, �̸�, ��, �μ���
*/
select employee_id, first_name, last_name, nvl(department_name,'�μ�����')
from employees E, departments D
where E.department_id = D.department_id (+)  and
    to_char(hire_date,'yyyy') = 2007; 

/*
���� ����.
����]
select
    ��Ī1. �÷�, ��Ī2.�÷�...
from 
    ���̺�A ��Ī1, ���̺�A ��Ī2
where
    ��Ī1.�÷�=��Ī2.�÷�;
*/        

/*
�ó�����] ������̺��� �� ����� �Ŵ��� ���̵�� �Ŵ����̸��� ����Ͻÿ�.
��, �̸��� first_name �� last_name�� �ϳ��� �����ؼ� ���.
*/
/*
���⼭�� ������夷�� ���̺� empClerk�� �Ŵ��������� ���̺� empManager��
��Ī���� ������ �� where���� �������� ������ ����Ѵ�.
�Ŵ����� ����̱� ������ 
���������  �Ŵ������̵�� �Ŵ������忡���� ������̵� �ȴ�.
*/
select 
    empClerk.employee_id "�����ȣ", 
    concat(empClerk.first_name||' ', empClerk.last_name) "����̸�",
    empManager.employee_id "�Ŵ��������ȣ", 
    empManager.first_name||' '|| empManager.last_name "�Ŵ����̸�"
from
    employees empClerk, employees empManager
where
--    empClerk.manager_id=empManager.employee_id;
    empClerk.manager_id=empManager.employee_id;
    
    
--Nook �Ѹ��� �Ŵ����� ����� ������ �ִ��� �˰����.
select 
    count(empClerk.first_name) "�Ŵ��� �� �ο���",
    empManager.employee_id "�Ŵ��������ȣ", 
    empManager.first_name||' '|| empManager.last_name "�Ŵ����̸�"
from
    employees empClerk, employees empManager
where
    empClerk.manager_id=empManager.employee_id
group by empManager.manager_id    ;


    
    
/*
�ó�����] self join�� ����Ͽ� "Kimberely/ Grant " ������� 
    �Ի����� ���� ����� �̸��� �Ի��� ���
    ��¸�� : first_name,last_name,hire_date
*/
--1.kimberely ����Ȯ��
select * from employees where upper(first_name) = 'KIMBERELY';
--2. 07/05/24 ���� �Ի��� ����� ���ڵ� ���
select * from employees where hire_date > '07/05/24' order by hire_date asc;
--3. self join���� ������ ��ġ��
select
    Clerk.first_name,Clerk.last_name, Clerk.hire_date
from employees Kimberely, employees Clerk 
where
    Kimberely.hire_date <= Clerk.hire_date
     and  Kimberely.first_name='Kimberely' --and Kimberely.last_name ='Grant'
     --Ŵ������ �θ��̸� ��Ʈ���ӵ� Ȯ�����־�� ��.
     --Ŵ������ ������... ���̸� ������;
    order by hire_date;
    
/*
using : join������ �ַ� ����ϴ� on���� ��ü�� �� �ִ� ����
    ����] on ���̺�1.�÷� = ���̺�2.�÷�
    ==> using(�÷�)
*/
/*
�ó�����] seattle�� ��ġ�� �μ����� �ٹ��ϴ� ������ ������ ����ϴ� �������ۼ�.
��, using ����� ��.
*/
select location_id, first_name, email, department_id, 
    department_name, job_id, job_title, city, state_province
from locations L 
    inner join departments  using(location_id)
    inner join employees  using(department_id)
    inner join jobs  using(job_id)
where lower(city) = 'seattle';

--using �������� select ���� ���̺� ��Ī�� ���̸� ����
--using���� ���� �÷��� ������ ���̺� ���ÿ� �����ϴ� �÷��̶�� ��������.
-- �˾Ƽ� ������.
-- ���:using�� ���̺��� ��Ī �� on���� ����. simple�ϰ� join�������ۼ�����.

/*
����]2005�� �Ի������� California(State_province)/
    south san Francisco(city)���� �ٹ��ϴ� ������� ������ ���.
    ��, ǥ�ع�İ� using���
    
    ��°��] �����ȣ, �̸�, ��, �޿�, �μ���, �����ڵ�, ������(country_name),
        �޿��� 3�ڸ����� �ĸ�ǥ��
        ����] �������� countries�� �ִ�.
*/

------------------------------------------------Nook ��°������ ������
select * 
from employees
    inner join departments using (department_id)
    inner join locations using(location_id)
where lower(state_province) = 'california' and 
        lower(city) = 'south san francisco'and
        to_char(hire_date,'yyyy')=2005;
----------------------------------------------------Nook ��°������ Ȯ����
select employee_id, first_name,last_name,
    '  '||trim(to_char(salary,'999,999,990')),
    department_name, country_id,  country_name 
from employees
    inner join departments using (department_id)
    inner join locations using(location_id)
    inner join countries using(country_id)
where lower(state_province) = 'california' and 
        lower(city) = 'south san francisco'and
        to_char(hire_date,'yyyy')=2005;
----------------------------------------------------



--1.2005�� �Ի���
select first_name, hire_date,substr(hire_date,1,2) from employees;
select * from employees where substr(hire_date,1,2)=05 ;
--2.south san francisco�� ��ġ�� �μ�Ȯ��
select * from locations where city='South San Francisco';
        --location_id 1500�ΰ� Ȯ��
select * from departments where location_id =1500;
        --department_id �� 50�� ���� Ȯ��
--3. ������ Ȯ���� ������ ���� ������ �ۼ�
Select * 
from 
    employees 
where 
    department_id=50 and
    substr(hire_date,1,2)='05';
--50�� �μ�(Shipping)���� �ٹ��ϸ鼭 �Ի���� 2005���� ��� ���� : 12��
--4.join ������ �ۼ��ϱ�
select 
    employee_id, first_name||' '||last_name "name", 
    ' '|| trim(to_char(salary,'$990,000'))as"salary",
    ' '||department_name"dep_name",' '||country_id"countryid", country_name
from employees
    inner join departments using(department_id)
    inner join locations using(location_id)
    inner join countries using(country_id)
where 
    substr(hire_date,1,2)=05 and 
    lower(city)= 'south san francisco' and     
    lower(state_province) ='california';
-------------------------------------------------------��������
---------------------------------------------------
---------��������
/*
1. inner join ����� ����Ŭ����� ����Ͽ� first_name �� Janette �� 
����� �μ�ID�� �μ����� ����Ͻÿ�.
��¸��] �μ�ID, �μ���
*/
select E.department_id, department_name 
from employees  E
    inner join departments D on E.department_id = D.department_id
where lower(first_name) = 'janette'    ;
    


/*
2. inner join ����� SQLǥ�� ����� ����Ͽ� ����̸��� �Բ� �� ����� 
�Ҽӵ� �μ���� ���ø��� ����Ͻÿ�
��¸��] ����̸�, �μ���, ���ø�
*/
select first_name||' '||last_name "name" , E.department_id, city
from employees E
    inner join departments D on E.department_id= D.department_id
    inner join locations L on D.location_id = L.location_id;    


/*
3. ����� �̸�(FIRST_NAME)�� 'A'�� ���Ե� ������� �̸��� �μ����� 
����Ͻÿ�.
��¸��] ����̸�, �μ���
*/ 
select first_name, department_name
from employees 
    inner join departments using (department_id)
where first_name like '%A%';    


/*
4. ��city : Toronto / state_province : Ontario�� ���� �ٹ��ϴ� ��� 
����� �̸�, ������, �μ���ȣ �� �μ����� ����Ͻÿ�.
��¸��] �̸�, ������, �μ�ID, �μ���
*/
select first_name , job_title, department_id, department_name
from employees
    inner join departments using(department_id)
    inner join locations using(location_id)
    inner join jobs using(job_id)
where lower(city) = 'toronto' and lower(state_province) ='ontario';

/*
5. Equi Join�� ����Ͽ� Ŀ�̼�(COMMISSION_PCT)�� �޴� ��� 
����� �̸�, �μ���, ���ø��� ����Ͻÿ�. 
��¸��] ����̸�, �μ�ID, �μ���, ���ø�
*/
select first_name,department_id, department_name, city
from employees
    inner join departments using(department_id)
    inner join locations using(location_id)
    where commission_pct is not null;

/*
6. inner join�� using �����ڸ� ����Ͽ� 50�� �μ�(DEPARTMENT_ID)�� 
���ϴ� ��� ������(JOB_ID)�� �������(distinct)�� �μ��� ���ø�(CITY)�� 
�����Ͽ� ����Ͻÿ�.
��¸��] ������ID, �μ�ID, �μ���, ���ø�
*/
--using�� ������ �ΰ��� ���̺� ������ �̸��� �÷��� �ִ°��� �����ϰ� 
--����ϹǷ� ���̺��� ��Ī�� ������� �ʴ´�.
select distinct job_id,department_id,department_name,city
from employees
    inner join departments using(department_id)
    inner join locations using(location_id)
where department_id =50;    

/*
7. ������ID�� FI_ACCOUNT�� ������� �޴����� �������� ����Ͻÿ�. 
��, ���ڵ尡 �ߺ��ȴٸ� �ߺ��� �����Ͻÿ�. 
��¸��] �̸�, ��, ������ID, �޿�
*/

select distinct man.first_name, man.last_name, emp.job_id, man.salary
from employees emp , employees man, jobs J
where emp.manager_id = man.employee_id and emp.job_id = J.job_id
    and J.job_id = 'FI_ACCOUNT';
    
    


/*
8. �� �μ��� �޴����� �������� ����Ͻÿ�. ��°���� �μ���ȣ�� 
�������� �����Ͻÿ�.
��¸��] �μ���ȣ, �μ���, �̸�, ��, �޿�, ������ID
�� departments ���̺� �� �μ��� �޴����� �ֽ��ϴ�.
*/

select emp.department_id, --emp.department_name, 
    mg.first_name,mg.last_name, mg.salary,
    distinct mg.job_id
from employees emp
    inner join employees mg on emp.manager_id = mg.employee_id
--    inner join departments D on D.department_id = emp.department_id
--group by emp.job_id
order by emp.department_id asc;
    


/*
9. ���������� Sales Manager�� ������� �Ի�⵵�� 
�Ի�⵵(hire_date)�� ��� �޿��� ����Ͻÿ�. ��½� �⵵�� �������� 
�������� �����Ͻÿ�. 
����׸� : �Ի�⵵, ��ձ޿�
*/
select to_char(hire_date,'YYYY') "�Ի�⵵",
    to_char(avg(salary),'$999,999')"��ձ޿�"
    from employees
    group by to_char(hire_date,'YYYY')
    order by "�Ի�⵵";
