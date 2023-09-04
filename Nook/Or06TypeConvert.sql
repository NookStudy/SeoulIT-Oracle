/**********************************
���ϸ�: Or06.sql
����ȯ �Լ�/ ��Ÿ�Լ�
����: 
***********************************/
--HR����
/*
sysdate : ���糯¥�� �ð��� �ʴ����� ��ȯ���ش�. 
    �ַ� �Խ����̳� ȸ�����Կ��� ���ο� �Խù��� ������ �Է��� ��¥�� ǥ���ϱ����� ���ȴ�.
*/
select sysdate from dual;
/*
��¥���� : ����Ŭ�� ��ҹ��ڸ� �������� �����Ƿ�, ���Ĺ��� ���� �������� �ʴ´�.
���� mm�� MM�� ������ ����� ����Ѵ�.
*/
select to_char(sysdate,'yyyy/mm/dd') from dual;
select to_char(sysdate,'YY-MM-DD') from dual;

--���� ��¥�� "������ 0000�� 00�� 00�� �Դϴ�." �� ���� ���·� ����Ͻÿ�
select to_char(sysdate,'������ yyyy�� MM�� dd�� �Դϴ�.') "�����ɱ�?" from dual;
--�����߻�. ��¥���� ������
select to_char(sysdate,'yyyy/MM//dd') "�����ɱ�?" from dual;

/*
-(������) /(������) ���� ���ڴ� �ν����� ���ϹǷ� ���Ĺ��ڸ� ������ ������ ���ڿ���
"(���������̼�)���� ��������Ѵ�. ���Ĺ��ڸ� ���δ°� �ƴԿ� �����ؾ� �Ѵ�.
*/
select to_char(sysdate,'"������ "yyyy"�� "MM"�� "DD"�� �Դϴ�"') "�̰Եȴ�" from dual;

--�����̳� �⵵�� ǥ���ϴ� ���Ĺ��ڵ�
select 
    to_char(sysdate,'day')"����(ȭ����)",
    to_char(sysdate,'dy')"����(ȭ)",
    to_char(sysdate,'mon')" ��(6��)",
    to_char(sysdate,'mm')" ��(04)",
    to_char(sysdate,'month')" ��",
    to_char(sysdate,'yy')"���ڸ��⵵",
    to_char(sysdate,'dd')"���� ���ڷ� ǥ��",
    to_char(sysdate,'ddd')"1���� ���°��"
from dual;    
/*
�ó�����] ������̺��� ����� �Ի����� ������ ���� ����� �� �ֵ���
    ������ �����Ͽ� �������� �ۼ��Ͻÿ�.
        ���] 0000�� 00�� 00�� 0����
*/
select first_name,last_name, hire_date,
    to_char(hire_date,'yyyy"�� "mm"�� "dd"�� "day') "�Ի���"
 from employees;
 select first_name,last_name, hire_date,
    to_char(hire_date,'yyyy"�� "mm"�� "dd"�� "day') "�Ի���"
 from employees order by "�Ի���";
 /*
 �ð� ���� : ������ �ð��� 00:00:00 ���·� ǥ���ϱ�
    �Ǵ� ���ڿ� �ð��� ���ÿ� ǥ���� ���� �ִ�.
 */
 select
    to_char(sysdate,'HH:MI:SS'),
    to_char(sysdate,'hh:mi:ss'),
    to_char(sysdate,'hh24:mi:ss'),
    to_char(sysdate,'yyyy-mm-dd hh:mi:ss')
from dual;
--�ڹٿ����� MM mm�� ���� ��, ������ ���е����� sql�� ��ҹ��� ������ �����Ƿ� ���� mi����

/*
��������
    0: ������ �ڸ����� ��Ÿ���� �ڸ����� ���� �ʴ� ��� 0���� �ڸ��� ä���.
    9: 0�� ����������, �ڸ����� �����ʴ� ��� �������� ä���.
*/
select
    to_char(123,'0000'),    -- ���� �ڸ����տ� 0���� ä��
    to_char(123,'9999'),   -- �Ǿտ� �������� ä���� ����
    trim(to_char(123,'9999')) --�� ���� ������ ���ŵƴ�.
from dual;    

--���ڿ� 3�ڸ����� �ĸ�(,)ǥ���ϱ�
/*
�ڸ����� Ȯ���� ����ȴٸ� 0�� ����ϰ�, 
�ڸ����� �ٸ��κп����� 9�� ����Ͽ� ������ �����Ѵ�.
��� ������ trim()�Լ��� �̿��Ͽ� �����ϸ� �ȴ�.
*/        
select  
    12345,
    to_char(12345,'000,000'),to_char(12345,'999,999'),
--    ltrim(to_char(12345,'999,999'),ltrim(to_char(12345,'990,000')),
    ltrim(to_char(12345,'999,999')), ltrim(to_char(12345,'990,000')) from dual;
-- ��ȭǥ�� : L => �� ���� �´� ��ȭǥ��. �츮����� ��(������ �ü�����)
select to_char(1000000,'L9,999,000') from dual;
/*
���� ��ȯ �Լ�
    to_number() : �����������͸� ���������� ��ȯ�Ѵ�.
*/    
--�ΰ��� ���ڰ� ���ڷ� ��ȯ�Ǿ� ������ ����� ����Ѵ�.
select to_number('123')+to_number('456') from dual; --�ٲ� ������
select to_number('123a')+to_number('456') from dual;
-- �����ε� ���ڸ� �ִ°͸� �ٲܼ� �ִ�.

/*
to_date()
    : ���ڿ� �����͸� ��¥�������� ��ȯ�ؼ� ������ش�.
        �⺻������ ��/��/�� ������ �����ȴ�.
*/
select
    to_date('2023-06-16') "��¥ �⺻����1",
    to_date('20230616') "��¥ �⺻����2",
    to_date('2023/06/16') "��¥ �⺻����3"
    
from dual;
--���ο� ������ ���ڿ� ��¥ �� �Է��ϸ� �⺻�������� �����.
--select to_char(yyyy-mm-dd, from hire_date) from employees;
/*
����] '2023-06-16 14:16:21' �� ���� ������ ���ڿ��� ��¥�� �ν��� �� �ֵ���
�������� �ۼ��Ͻÿ�
*/
--��¥ ������ �ν����� ���ϹǷ� ������ �߻��Ѵ�.
select to_date('2023-06-16 14:16:21') from dual;
--���1. ���ڿ��� �߶� ����Ѵ�.
select to_date(substr('2023-06-16',1,10) )from dual;
--���ڿ��� ���� ���� �����Ѵٸ� ��¥�������� �ν��� �� �ִ�.
--select to_date(substr(1,10))||' '||to_date(substr(11,20)) "���ڿ� �ڸ���" from dual;
--���2 : ��¥�� �ð� ������ Ȱ���Ѵ�.
select 
    to_date('2023-06-16 14:26:21','yyyy-mm-dd hh24:mi:ss') from dual;
    --����� ���°� �ƴϸ� ������ �� �־���� �ϴµ� �ϱ����ۿ� �ȳ���.
/*
����] ���ڿ� '2021/05/05' �� ��������� ��ȯ�Լ��� ���� ���.
 �� , ���ڿ��� ���Ƿ� ������ �� ����.
 */
 select 
    to_date('2021/12/25') "1�ܰ�: ��¥����Ȯ��",
    to_char(sysdate,'day') "2�ܰ�: ���ϼ���Ȯ��",
    to_char(to_date('2021/12/25'),'day') "3�ܰ�: ����"
    from dual;
/*
����2] ���ڿ� '2021��01��01��'�� � �������� ��ȯ�Լ��� ���� ���.
    ��, ���ڿ��� ���Ƿ� ����Ұ�
*/
select 
--    to_date('2021��01��01��','yyyy"��"mm"��"dd"��"') from dual;
    to_char(to_date('2021��01��01��','yyyy"��"mm"��"dd"��"'),'day')
from dual;
/*
nul() : null���� �ٸ� �����ͷ� �����ϴ� �Լ�
    ����] nul(�÷���, ��ü�� ��)
*/
---null���� ������ ó���� �ʿ��ϴ�
select salary+commission_pct from employees;
--null���ִ°��� ��ġ�� null�� �Ǿ����.
select first_name, commission_pct, salary+nvl(commission_pct,0)
from employees;
--null���� 0���� �ٲ��ص� ��Ģ����.

/*
decode() : java�� switch���� ����ϰ� Ư������ �ش��ϴ� ��¹��� �ִ°�� ���.
    ����] decode(�÷���,
                ��1, ���1,
                ��2, ���2, ��3,���3 .....
                �⺻��)
    *�������� �ڵ尪�� ���ڿ��� ��ȯ�Ͽ� ����� �� ���� ����Ѵ�.
*/
select
    first_name, last_name, department_id, 
    decode (department_id, 
            10,'Administration', 
            20,'Marketing',
            30,'Purchasing',
            40,'Human Resources',
            50,'Shipping',
            60,'IT',
            70,'Public Relations',
            80,'Sales',
            90,'Executive',
            100,'Finance',
            110,'Accounting','�μ��� Ȯ�ξȉ�') as  Department_name from employees;    
/*
case() : java�� if~else���� ����� ������ �ϴ� �Լ�
    ����] case when ����1 then ��1
                when ����2 then ��2
                ///
                else �⺻��
            end
*/
/*
�ó�����] ������̺��� �� �μ���ȣ�� �ش��ϴ� �μ����� ����ϴ� ���� by case
*/
select first_name,last_name,department_id,
    case
        /*when ���� then ��*/
        when department_id = 10 then 'administration'   --�濵������
        when department_id = 20 then 'Marketing'        --��������
        when department_id = 30 then 'Purchasing'       --������
        when department_id = 40 then 'Human Resources'  --�λ���
        when department_id = 50 then 'Shipping'         --������
        when department_id = 60 then 'IT'               --IT
        when department_id = 70 then 'Public Relations' --ȫ����
        when department_id = 80 then 'Sales'            --������
        when department_id = 90 then 'Executive'        --�濵
        when department_id = 100 then 'Finance'         --�繫
        when department_id = 110 then 'Accounting'      --ȸ����
        else'�μ��� ����'
    end team_name
    from employees
    order by team_name asc;
/****************************
��������
******************************************************/
--scott�������� ����˴ϴ�.
/*
1. substr()�Լ��� ����Ͽ� ������� �Ի��� �⵵�� �Ի��� �޸� ����Ͻÿ�.
*/
select * from emp;
select
    ename,
    substr(hiredate,1,5)"�Ի���2"
from emp;
--2. substr()�Լ� �̿��Ͽ� 4���� �Ի��� ��� ���
--���������.
select * from emp
--where substr(hiredate,4,2)=04; ����
where substr(hiredate,4,2)='04';
--where to_char(hiredate,dd)=04;   
   
--   3. mod(0�Լ��� ����Ͽ� �����ȣ�� ¦���� ����� ����ض�

select * from emp where mod(empno,2)=0;--mod == %in java;
-- �Ի����� ������ 2�ڸ�yy,���� ����mon���� ǥ���ϰ� ������ ���dy�� ���
select hiredate,
    to_char(hiredate,'yy')"�Ի�⵵",
    to_char(hiredate,'mon')"�Ի��",
    to_char(hiredate,'dy')"�Ի����"
from emp;    
select to_char(hiredate,'yy') || ' '||
    to_char(hiredate,'mon')|| ' '||
    to_char(hiredate,'dy') "�Ի��,��, ����"
from emp;    

/*
5. ���� ��ĥ�� �������� ����Ͻÿ�. ���� ��¥���� ���� 1�췯1���� �� ����� ���.
to_date�� ����Ͽ� ������ ���� ��ġ���Ѷ�.
��, ��¥�� ���´�' 01-01-2020' ���� �Ѵ�.
wmr sysdate - '01-01-2020'�̿� ���� ������ �����ؾ� �Ѵ�.
*/
--sysdate - to_date('01-01-2023) �̿Ͱ��� �ϸ� ������ ���ϴ�.
select
    trunc(sysdate - to_date('23/01/01')) "�⺻��¥ ���Ļ��",
    to_date('01-01-2023','dd-mm-yyyy') "��¥ ��������",
    trunc(sysdate - to_date('01-01-2023','dd-mm-yyyy')) "��¥ ����"
from dual;    
/*
6. ������� �Ŵ��� ����� ����ϵ� ����� ���� ����� ���ؼ��� 
null�� ��� 0���� ����Ͻÿ�
*/

select ename, nvl(Mgr,0)"�Ŵ��� ���" from emp;

/*
7.decode�Լ��� ���޿� ���� �޿��� �λ��ض�.
clerk�� 200 salseman �� 180 mgr�� 150 president�� 100
*/
select ename,sal, JOB,
    decode(job,
            'CLERK', sal+200,
            UPPER('salesman'),sal+180,
            'MANAGER', SAL+150,
            'PRESIDENT', SAL+100,
            SAL)
            "�λ�� �޿�"
FROM EMP            
ORDER BY JOB, SAL; 
            
   
   
   
   
   
   
   
   
   
   
   
   
    