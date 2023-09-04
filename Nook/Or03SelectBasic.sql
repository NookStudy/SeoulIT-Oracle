/**********************************
���ϸ�: Or03SelectBasic.sql
ó������ �����غ��� ���Ǿ�(SQL�� or Query��)
�����ڵ� ���̿����� '����' �̶�� ǥ���ϱ⵵ �մϴ�.
����:  select, where �� ���� �⺻���� DQL�� ����غ���. 
***********************************/
--HR�������� ����
/******
*SQL Developer ���� �ּ�����ϱ�
--*    �������ּ�: �ڹٿ� ����./*    */
--*    ���δ����ּ�: -- ���๮�� . ������ 2���� �������� ����Ѵ�.
--***********/

--select�� : ���̺� ����� ���ڵ带 ��ȸ�ϴ� SQL������ DQL���� �ش��Ѵ�.
/*
����]
    select �÷�1, �÷�2,... Ȥ��*(�ƽ�Ÿ)
        from ���̺��
        where ����1 and ����2 or ����3
        oder by �������÷� asc(��������), desc(��������);<-��������. ctrl+enter:����
*/
--������̺� ����� ��緹�ڵ�(��)�� ������� ��� �÷�(��)�� ��ȸ�ϱ�
--������̺� �������ڴ� ����
--(�������� ��ҹ��ڸ� �������� �ʴ´�.)
select * from employees;
SELECT * FROM EMPLOYEES;

/*
�÷����� �����ؼ� ��ȸ�ϰ� ���� �÷��� ��ȸ�ϱ�
=> ���, �̸�,�̸���,�μ���ȣ�� ��ȸ
*/
SELECT employee_id, first_name,last_name,email,department_id
    from employees; --�ϳ��� �������� ������ �����ݷ��� �ݵ�� ����ؾ���.
    
--���̺��� ������ �÷��� �ڷ��� �� ũ�⸦ ����Ѵ�.
--��, ���̺��� ��Ű���� �� �� �ִ�.
desc employees;
/*
�̸�             ��?       ����           
-------------- -------- ------------ 
EMPLOYEE_ID    NOT NULL NUMBER(6)    
FIRST_NAME              VARCHAR2(20) 
LAST_NAME      NOT NULL VARCHAR2(25) 
EMAIL          NOT NULL VARCHAR2(25) 
PHONE_NUMBER            VARCHAR2(20) 
HIRE_DATE      NOT NULL DATE         
JOB_ID         NOT NULL VARCHAR2(10) 
SALARY                  NUMBER(8,2)  
COMMISSION_PCT          NUMBER(2,2)  ��, �Ҽ� 2°�ڸ�����
MANAGER_ID              NUMBER(6)    
DEPARTMENT_ID           NUMBER(4)    
*/
--as�� ������ �� �ִ�.
-- �÷��� �׸��� �ٲ㼭 ����Ʈ �� �� �ִ�.
select employee_Id"������̵�",first_name "�̸�", last_name "��"
    from employEes where firSt_naMe = 'William';
/*
����Ŭ��  �⺻������ ��ҹ��ڸ� �������� �ʴ´�.
���Ǿ��� ��� ��ҹ��� ���о��� ����Ҽ� �ִ�.
*/
--��, �����ʹ� ��ҹ��� ������.(***�߿�***)
--alias �����ڴ� ���������̼�. ������ �ҷ��� ���� �̱� �����̼�.
SELECT EMPLOYEE_ID"������̵�",first_name"�̸�",last_name"��" 
    FROM Employees WHERE first_name = 'William';

--��, ���ڵ��� ��� ��ҹ��ڸ� �����Ѵ�. 
--���� �Ʒ� SQL���� �����ϸ� �ƹ��� ����� ������ �ʴ´�.(**�߿�**)
select employee_id"��� ���̵�", first_name"�̸�" , last_name"��"
    from employees where first_name = 'WILLIAM';

/*
where ���� �̿��ؼ� ���ǿ� �´� ���ڵ� �����ϱ�
->last name �� Smith�� ���ڵ带 �����Ͻÿ�
*/
select * from employees where last_name='Smith';
/*
where ���� 2���̻��� ������ �ʿ��� �� and Ȥ�� or�� ����� �� �ִ�.
-> last_name�� Smith, �޿��� 8000�� ����� �����϶�.
*/
select * from employees where last_name='Smith' and Salary='8000';
select * from employees where (Salary='8000' and  last_name='Smith') or (salary='2600' or last_name='Taylor');

--�÷��� �������� ��� �̱������̼����� ���Ѵ�. ������ ��� �����Ѵ�.

select *from employees where last_name ='Smith' and salary=8000;
--�����߻�. �÷��� �������� ��� �̱� �����̼��� ������ ������ �߻��Ѵ�.
select *from employees where last_name=Smith and salary=8000;
--�÷��� �������϶��� �̱������̼� ������ �⺻������, ������ �������.
select *from employees where last_name ='Smith' and salary='8000';
/*
�񱳿����ڸ� ���� ������ �ۼ�
    : �̻�, ���Ͽ� ���� ���ǿ� >, <=�� ���� �񱳿����ڸ� ����� �� �ִ�.
    ��¥�� ��� ����, ���Ŀ� ���� ���ǵ� �����ϴ�.
*/
--�޿��� 5000�̸� ����� ������ �����Ͻÿ�.
SELECT * from employees where salary < 5000;
--�Ի����� 04�� 01�� 01������ ��� ������ �����Ͻÿ�.
Select * From Employees Where Hire_Date > '04/01/01';

/*in ������
    : or �����ڿ� ���� �ϳ��� �÷��� �������� ������ ������ �ɰ������ ���.
    => �޿��� 4200,6400,8000�� ����� �����Ͻÿ�*/
--���1. or���. �̶� �÷����� �ݺ������� ����ؾ��Ѵ�.
select * from employees where salary=4200 or salary=6400 or salary=8000;
--���2. in�� ����ϸ� �÷����� �ѹ��� ����ϸ� �ȴ�.
select * from employees where salary in(4200,6400,8000);
/*
not ������
    : �ش� ������ �ƴ� ���ڵ带 ����.
    -> �μ���ȣ�� 50�� �ƴ� ��������� ��ȸ�ϴ� SQL���� �ۼ��Ͻÿ�.
*/
select * from employees where department_id <> 50;
select * from employees where not(department_id = 50);
/*
between and ������
    : �÷��� ������ ������ �˻��Ҷ� ����Ѵ�.
    => �޿��� 4000~8000������ ����� �����Ͻÿ�.
*/
--���1.
select *from employees where salary >=4000 and salary<=8000;
--���2
select *from employees where salary between 4000 and 8000;
--select *from employees where salary in(between 4000 and 8000,between 2000 and 3000);���Ұ�

/*
distinct
    : �÷����� �ߺ��Ǵ� ���ڵ带 �����Ҷ� ����Ѵ�.
    Ư�� �������� select ���� �� �ϳ��� �÷����� �ߺ��Ǵ� ���� �ִ°�� 
    �ߺ����� ������ �� ����� ����� �� �ִ�.
    =>������ ���̵� �ߺ��� ������ �� ����Ͻÿ�.
*/
select job_id  from employees;
--��ü����� ���� ������
select distinct job_id  from employees ;
--�������� ���

/*
like ������
    : Ư�� Ű���带 ���� ���ڿ��� �˻��Ҵ� ����Ѵ�.
    ����] �÷��� like '%�˻���%'
    ���ϵ� ī�� ����.
        %: ��繮�� Ȥ�� ���ڿ��� ��ü�Ѵ�.
            ex) D�� ���۵Ǵ� �ܾ� : D& -> da, dea, daewoo,
                Z�� ������ �ܾ� : %Z -> aZ, adxZ
                C�� ���Ե� �ܾ� : %C% -> aCb, abCd, Vitamin-C
        _: ����ٴ� �ϳ��� ���ڸ� ��ü�Ѵ�.
            ex) D�� �����ϴ� 3���� �ܾ� : D__ -> Dae, Dad
                Z�� ������ 3���� �ܾ� : __Z -> edZ, kaZ
                A�� �߰��� ���� 3���� �ܾ� : _A_ -> dAd, gAg;
            
*/            
--first name �� 'D'�� �����ϴ� ������ �˻��Ͻÿ�.
select * from employees where first_name like 'D%';
--first_name �� ����° ���ڰ� a�� ������ �����Ͻÿ�.
select *from employees where first_name like '__a%';
--last name ���� y�� ������ ������ �˻��Ͻÿ�
select *from employees where last_name like '%y';
--��ȭ��ȣ�� 1344�� ���Ե� ���� ��ü�� �����Ͻÿ�.
select * from employees where phone_number like '%1344%';

/*
���ڵ� �����ϱ�(sorting)
    �������� ���� : order by �÷��� asc(Ȥ�� ��������)
    �������� ���� : order by �÷��� desc
    
    2���̻��� �÷����� �����ؾ� �� ��� �ĸ�(,)�� �����ؼ� �����Ѵ�.
    ��, �̶� ���� �Է��� �÷����� ���ĵ� ���¿��� �ι�° �÷��� ���ĵȴ�.
*/
/*
������� ���̺��� �޿��� ���� �������� ���� ������ ����ǵ��� �����Ͽ� ��ȸ�϶�.
����� �÷� : first_name , salary, email,phone_number
*/
select first_name, salary,  phone_number from employees
    order by salary asc;
select first_name, salary,  phone_number from employees
    order by salary ;
/*
�μ���ȣ�� ������������ ������ �� 
�ش� �μ����� �����޿��� �޴� ������ ���� ��µǵ��� �ϴ� SQL�� �ۼ��Ͻÿ�
����׸� : �����ȣ, �̸�, ��, �޿� �μ���ȣ
*/
select employee_id "�����ȣ",  first_name "�̸�",last_name"��", salary "����",department_id "�μ���ȣ" 
    from employees
    order by department_id desc, salary asc;
/*
is null Ȥ�� is not null
    :���� null �̰ų� null�� �ƴ� ���ڵ� ��������
    �÷��� null���� ����ϴ� ��� ���� �Է����� ������ null���� �Ǵµ� �̸� ������� select�Ҷ� ����Ѵ�.
    */
--���ʽ����� ���� ����� ��ȸ�Ͻÿ�    
select * from employees where commission_pct is null;    
--��������̸鼭 �޿��� 8000�̻��� ����� ��ȸ�Ͻÿ�.
select * from employees where commission_pct is not null and salary>=8000;
/**********************************
��������(scott �������� �����մϴ�.)
*************************************/
/*
1. ���� �����ڸ� �̿��Ͽ� ��� ����� ���ؼ� $300�� �޿��λ��� ����� �� 
�̸�, �޿�, �λ�� �޿��� ����Ͻÿ�.
*/
select * from emp ;
select ename, sal, sal+300"Risesalary" from emp;
select ename, sal, (sal+300)"Risesalary" from emp;

select ename, sal, sal+300"Risesalary" from emp
    where sal between 1000 and 5000 AND  job= 'CLERK'
    order by sal desc; 
/*
2. ����� �̸�, �޿�, ������ ������ ���� �ͺ��� ���������� ���
������ ���޿�12�� ���� �� 100�� ���ؼ� ����Ͻÿ�.
*/
select ename, sal, sal*12+100 "����" from emp
    order by sal desc;
--���Ľ� ���������� �����ϴ� �÷����� ����ϴ°� �⺻�̴�.
--���������� �������� ���� �÷��̶�� ���� �״�θ� order by ���� ����Ѵ�.
select ename, sal, sal*12+100 "����" from emp
    order by sal*12+100 desc;
select ename, sal, sal*12+100 "����" from emp
    order by "����" desc;
--Alias�� ����� �÷����ε� order by ����� �����Ѵ�.    
/*
�޿��� 2000�� �Ѵ� ����� �̸��� �޿��� ������������ �����Ͽ� ����Ͻÿ�;
*/
select ename, sal from emp
    where sal>2000
    order by ename desc, sal desc;
/*
4. �����ȣ�� 7782�� ����� �̸��� �μ���ȣ�� ����Ͻÿ�.
*/
select ename, deptno from emp
    where empno = 7782;
    
/*
�޿��� 2000���� 3000���̿� ���Ե��� �ʴ� ����� �̸��� �޿��� ����Ͻÿ�.
*/
select ename, sal from emp
    where not (sal between 2000 and 3000);
--    ���ϰ�����
select ename, sal from emp
    where sal>3000 or  sal<2000;
/*
6.�Ի����� 81�� 2��20�Ϻ��� 81�� 5��1�� ������ ����� �̸�, ������,�Ի����� ���
*/
select ename,job,hiredate from emp
    where hiredate between '81/02/20' and '81/05/01' ;
select ename,job,hiredate from emp    
    where hiredate>='81/02/20' and hiredate<='81/05/01' ;
 /*
7.�μ���ȣ�� 20�� 30�� ���� ����� �̸��� �μ���ȣ�� ����ϵ�
�̸��� (�������� ���� �����Ͻÿ�.
*/
select ename, deptno from emp
    where deptno in(20,30)
    order by ename desc;
--    ���ϰ�� ���
select ename, deptno from emp
    where deptno= 20 or deptno=30
    order by ename desc;    
/*
8. ����� �޿��� 2000���� 3000 �����̰� �μ���ȣ�� 20,30
����� �̸�, �޿� , �μ���ȣ ��� �̸��� (����) ���
*/
select ename,sal,deptno from emp
    where (sal between 2000 and 3000) and deptno in(20,30)
    order by ename asc;
--���ϰ�� ���
select ename,sal,deptno from emp
    where (sal between 2000 and 3000) and (deptno=20 or deptno=30)
    order by ename asc;
/*
9. 1981�⵵�� �Ի��� ����� �̸��� �Ի��� ���. like �� wildcard���
*/
select ename, hiredate from emp
    where hiredate like '81%';
    
/*
10.�����ڰ� ���� ����� �̸��� �������� ����Ͻÿ�.
*/
select ename, job from emp
    where mgr is null;
/*
11. Ŀ�̼��� ���� �� �ִ� �ڰ��� �Ǵ� ����� �̸�, �޿�, Ŀ�̼���
����ϵ� �޿� �� Ŀ�̼��� �������� ���������Ͽ� ���.
*/
select ename, sal, comm from emp
    WHERE COMM IS NOT NULL
    ORDER BY sal desc, comm desc;
/*
12.�̸��� ����° ���ڰ� R�� ����� �̸��� ǥ���Ͻÿ�.
*/
select ename from emp
    where ename like '__R%';
/*
13. �̸��� A�� E�� ��� �����ϰ� �ִ� ����� �̸��� ǥ���Ͻÿ�.
*/
select ename from emp
    where ename like '%A%' and ename like '%E%';
/*
�Ʒ��� ���� ��� E �ڿ� A�� ������ ����
*/
select ename from emp
    where ename like '%A%E%';
--//�䷸�� ���� �����ϴ�    
select ename from emp
    where ename like '%A%E%' or ename like '%E%A%';    
/*
14. ��������  �繫��(clerk) �̰ų� �Ǵ� �������(salesman)�̸鼭
�޿��� 1600, 900 , 1300�� �ƴ� �����
�̸�, ������, �޿��� ����Ͻÿ�
*/
select ename, job, sal from emp
    where job in ('CLERK','SALESMAN') AND sal not in(1600,900,1300);
/*
15.comm�� 500�̻��� ����� �̸��� �޿� �� Ŀ�̼� ���
*/
select ename, sal, comm from emp
    where comm>=500;
    

    
        


