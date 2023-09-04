/**********************************
���ϸ�: Or07Date.sql
��¥�Լ�
����: ��, ��,��,��,��,���� �������� ��¥������ �����ϰų� 
    ��¥�� ����� �� Ȱ���ϴ� �Լ���
***********************************/
--HR����

/*
months_between() : ���糯¥�� ���س��� ������ �������� ��ȯ�Ѵ�.
    ����] months_between(���糯¥, ���س�¥[���ų�¥]);
*/

select
    months_between(sysdate, '2023-01-01') "�⺻��¥ ����",
    months_between(sysdate,
        to_date('2023�� 01�� 01��','yyyy"��" mm"��"dd"��"')) "to_date ���",
     ceil(months_between(sysdate,
        to_date('2023�� 01�� 01��','yyyy"��" mm"��"dd"��"'))) "�Ҽ��� �ø�",
    add_months(sysdate,04)    
from dual;    

/*
����]employees ���̺� �Էµ� �������� �ټӰ������� ����Ͽ� ����Ͻÿ�.
    ��, �ټӰ������� ������������ �����Ͻÿ�.
*/
select
    first_name,hire_date,
    months_between(sysdate,hire_date) "�ټӰ�����1",
    trunc(months_between(sysdate,hire_date),1) "�ټӰ�����2"
from employees
order by "�ټӰ�����2" asc;
-- orderby trunc(months_between(sysdate,hire_date),1) asc;
/*
select ����� �����ϱ� ���� oreder by�� ����� �� �÷����� ���Ͱ��� 
2���� ���·� ����� �� �ִ�.
��� 1 : ������ ���Ե� �÷� �״�� ���
��� 2 : ��Ī ���.
* /   
/*
next_day() : ���糯¥�� �������� ���ڷ� 
    �־��� ���Ͽ� �ش��ϴ� �̷��� ��¥�� ��ȯ�ϴ� �Լ�
    ����] next_day(���糯¥,'������')
    =>������ �������� �����ϱ��?
*/

select to_char(sysdate,'yyyy-mm-dd') "���ó�¥",
    next_daY(sysdate,'������') "���� ������",
    to_char(next_daY(sysdate,'������'),'yyyy-mm-dd') "��¥ ���� ����"
FROM DUAL;    

/*
last_day() :�ش���� ������ ��¥�� ��ȯ�Ѵ�.
*/
select last_day('22-04-03') from dual;--22�� 4���� �������� 30��
select last_day('22-02-03') ,           --28�� ���
     last_day('20-02-03') from dual;    --29�� ���(����)
     
--�÷��� dateŸ���� ��� ������ ��¥ ������ �����ϴ�.
select sysdate "����", sysdate+1 "����", sysdate-1 "����",
        sysdate+15"������"
from dual;
