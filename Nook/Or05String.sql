/**********************************
���ϸ�: Or05String.sql
���ڿ� ó���Լ�
����: ���ڿ��� ���� ��ҹ��ڸ� ��ȯ�ϰų� ���ڿ��� ���̸� ��ȯ�ϴµ�
    ���ڿ��� �����ϴ� �Լ�
***********************************/
--HR����

/*
concat(���ڿ�1,���ڿ�2)
    :���ڿ�1�� ���ڿ�2�� �����ؼ� ����ϴ� �Լ�
    ����1 : select concat('���ڿ�1','���ڿ�2') from dual;
    ����2 : select '���ڿ�1' ||'���ڿ�2'
    || <- vertical bar
*/
select concat('Good ' ,'morning') as "��ħ�λ�" from dual;
select concat('Good ' ,'morning') "��ħ�λ�" from dual;
select 'Good '||'morning' from dual;
select first_name||' '||last_name "Full name" from employees;

select 'Oracle ' ||'21C '||'Good..!!'  from dual;
--=> �� SQL���� concat()���� ����
select concat(concat('Oracle ','21C '),'Good..!!')from dual;
--conacat�� �ΰ��ۿ� ��ġ�� ���ؼ� ��ɾ �ߺ����� ���;���

/*
�ó�����] ������̺��� ����� �̸��� �����ؼ� �Ʒ��� ���� ����Ͻÿ�
    ��³���: first+last name, �޿�, �μ���ȣ
*/
-- step1 : �̸��� �����ؼ� ��������� ���Ⱑ �ȵż� �������� ��������.
select concat(first_name,last_name) Full_name,salary "�޿�",Department_id "�μ���ȣ"
from employees;
--step2 : �����̽� �߰��� ���� concat�� �ߺ����. �̸� ���̿� ������ ������ ��.
select concat(concat(first_name,' '),last_name) as "Full name",salary "�޿�",Department_id "�μ���ȣ"
from employees;
--step3 : 2���� �Լ��� ����ϴ� �ͺ��� ||vertical bar��  �̿��ϸ� �����ϰ� ǥ���ȴ�.
--    �����÷����� alias�� �̿��Ͽ� ��Ī�� �ο��Ѵ�.
select first_name||' '||last_name as Fullname,salary "�޿�",Department_id "�μ���ȣ"
from employees;

/*
initcap(���ڿ�(
    :���ڿ��� ù���ڸ� �빮�ڷ� ��ȯ�ϴ� �Լ�.
    ��, ù���ڸ� �ν��ϴ� ������ ������ ����.
    -���鹮�� ������ ������ ù���ڸ� �빮�ڷ� ��ȯ�Ѵ�.
    -���ĺ��� ���ڸ� ������ ������ ���� ������ ������ ù���� ���ڸ� �빮�ڷ� ��ȯ.
    -�빮�ڷ� �ִ��� �ҹ��ڷ� ��ȯ�Ѵ�.
*/   
select initcap('hi hello �ȳ�mynameis nook') from dual;
--ù���ڸ� �빮�ڷ� ����.
select initcap('good/bad morning')from dual; --Good/Bad Morning
--������ ���� ���ڵ� �빮�ڷ� ����(�������� ����ó��)

select initcap('naver6say*good��bye') from dual; --Naver6say*Good��Bye
--�ѱ�, Ư������ ���� ��� �빮�ڷ� �ٲ�. ���ڵڴ� �ȹٲ�.

/*
�ó�����] ������̺��� first_name�� john�� ����� ã�� �����Ͻÿ�.
*/
select * from employees where first_name = 'john'; --��ҹ��� �����ؼ� �ȳ���.
--�̷� ������(�̿Ͱ��� �����ϸ�) �ۼ��� ����� ������ �ʴ´�.
--���� �Լ� �̿�/�빮�� ������ �̸��� ����ؾ� �Ѵ�.
select * from employees where first_name = initcap('john');
select * from employees where first_name = 'John';

/*
��ҹ��� �����ϱ�
lower() : �ҹ��ڷ� ������.
upper() : �빮�ڷ� ������.
*/
-- ���Ͱ��� john�� �˻��ϱ� ���� ������ ���� Ȱ���� ���� �ִ�.
-- �÷���ü�� �빮�� Ȥ�� �ҹ��ڷ� ������ �� �����Ѵ�.
select lower('Good'), upper('bad') from dual;
select * from employees where lower(first_name) = 'john';
select * from employees where upper(first_name) = 'JOHN';
select * from employees where initcap(upper(first_name)) = 'John';
select initcap('jOHN') from dual;

/*
lpad(),rpad() 
    : ���ڿ��� ����, �������� Ư���� ��ȣ�� ä�� �� ����Ѵ�.
    ����]  lpad('���ڿ�', '��ü�ڸ���','ä�﹮�ڿ�')
        => ��ü�ڸ������� ���ڿ��� ���̸�ŭ�� ä���ִ� �Լ�.
            rpad�� �������� ä����.
*/    
select
    'good', lpad('good',7,'#'), rpad('good',7,'#'), lpad('good',7)
    -- [good]    [###good]          [good###]             [   good]
    from dual;
-- �������� �����ϰ�, ���� Ȥ�� ���ڸ� �˴� ä�������� �ִ�!
select rpad(first_name,10,'*') from employees;--���� ©��
select rpad(first_name,12,'*') from employees;
--�̸� ��ü�� 12�ڷ� �����Ͽ� �̸��� ������ ������ �κ��� *�� ä���.
select rpad(first_name,12) , rpad(last_name,12) from employees;
select rpad(first_name,12) || rpad(last_name,12) as Fullname from employees;

/*
�ó�����] ������̺��� first_name�� ù���ڸ� ������ ������ �κ��� 
    *�� ����ŷ ó���ϴ� �������� �ۼ��Ͻÿ�.
*/
--substr(���ڿ� Ȥ�� �÷�, �����ε���, ����) : �����ε������� ���̸�ŭ �߶󳽴�.
select substr('abcdefg',1,1) from dual; --���� �ε���, ����
select substr(first_name,1,1) from employees;
--���ڿ��� ���̸� 10���� ���� �� ���� �κ��� *�� ä���.
select rpad('Ellen',10,'*') from dual;
--length(���ڿ� Ȥ�� �÷���) : �ش� ���ڿ��� ���̸� ��ȯ�Ѵ�.
select
    first_name, rpad(substr(first_name,1,1), length(first_name),'*')"����ŷ"
    --length�� �������ν� ��Ʈ�� ���̸�ŭ *�� ä��� �ִ�.
    from employees;

/*
trim() : ������ ������ �� ����Ѵ�.
    ����] trim([leading | trailling | both] ������ ����
        - leading : ���ʿ��� ������
        - trailing : �����ʿ��� ������;
        - both : ���ʿ��� ������. �������� ������ both�� default;
        [����1] ���� ���� ���ڸ� ���ŵǰ�, �߰��� �ִ� ���ڴ� ���ŵ��� �ʴ´�.
        [����2]  '����'�� ������ �� �ְ�, '���ڿ�'�� ������ �� ����. �����߻�.
*/
select 
    ' ���������׽�Ʈ ' as trim1,
    trim(' ���������׽�Ʈ    ') trim2, --������ ���� ���� ���ŵ�
    trim('��' from '�ٶ��㰡 ������ ž�ϴ�') trim3, -- ������ '��'����
    trim(both '��' from '�ٶ��㰡 ������ ž�ϴ�') trim4, --both�� default�� 3,4����
    trim(leading '��' from '�ٶ��㰡 ������ ž�ϴ�') trim5, --������ �����
    trim(trailing '��' from '�ٶ��㰡 ������ ž�ϴ�') trim6 --������ �����
    from dual;
--trim()�� �߰��� ���ڴ� ������ �� ����, ���� ���� ���ڸ� ������ �� �ִ�.

select 
    trim('�ٶ���' from '�ٶ��㰡 ������ ž�ٰ� ��������� �̤�') TrimError
from dual;
--trim()�� �ϳ��� ���ڸ� �����Ҽ� �ִ�. ���ڿ��� ������ϸ� ����!
/*
ltrim(), rtrim() :L[eft]Trim, R[ight]Trim
    : ����, ���� '����' Ȥ�� '���ڿ�'�� ������ �� ����Ѵ�.
    *Trim�� ���ڿ��� ������ �� ������, LTRiM, RTRIM�� ���ڿ����� ������ �� �ִ�.
*/
select 
    ltrim('    ������������  ') as ltrim,
    ltrim('    ������������  ','����') ltrim2, --������ ������ ������ �����Ҽ� ����.
    ltrim('������������  ','����') ltrim3,
    ltrim('������������  ') ltrim4,-- ������ ������ ������  �׳� �д�.
    rtrim('    ������������','����')rtrim1,
    rtrim('������������     ','����')rtrim2,--������ ������ ������ ������ �� ����.
    rtrim('������������','����')rtrim2--�߰� ���ڴ� ������ �� ����.
 from dual;   
/*
substr() : ���ڿ����� �����ε������� ���̸�ŭ �߶� ���ڿ��� ����Ѵ�.
    ����] substr(�÷�, �����ε���, ����)
    
    ����1] ����Ŭ�� �ε����� 1���� �����Ѵ�.
    ����2] '����'�� �ش��ϴ� ���ڰ� ������ ���ڿ��� �������� �ǹ��Ѵ�.
    ����3] �����ε����� ������ ���������� �·� �ε����� �����Ѵ�.
*/    
select substr('good morning john',8,4) from dual;
--8���� �����ؼ� 4�������� �߶��. ���:rnin
select substr('good morning john',8) from dual;
/*
replace() : ���ڿ��� �ٸ� ���ڿ��� ��ü�� �� ���ȴ�.
    ���� �������� ���ڿ��� ��ü�Ѵٸ� ���ڿ��� �����Ǵ� ����� �ȴ�.
    ����] replace(�÷��� �Ǵ� ���ڿ�, '������ ����� ����' , '������ ����')
    
    *trim(),ltrim(),rtrim() �Լ��� ����� replace()�Լ� �ϳ��� ��ü�� �� �ִ�.
    trim()�� ���� replace()�� �ξ� �� ���󵵰� ����.
*/
--���ڿ� ����
select replace('good morning john','morning','evening') from dual;

select replace('good morning john','john','') replace from dual; --�ǳ��� ������ ��.
select trim(replace('good morning john','john','')) replace from dual;

select trim('   good morning john    ') "��������" from dual;
select replace('   good morning john    ','    ','') "��������" from dual;
select replace(' good morning john ',' ','') "��������" from dual;--������������

--102�� ����� ���ڵ带 ������� ���ڿ� ������ �غ���.
select first_name, last_name, 
    ltrim(first_name, 'L')"����L����",
    Rtrim(first_name, 'ex')"����ex����",
    replace(last_name, ' ','') "�߰� ��������",
    replace(last_name, 'De','Dea')"�̸�����"
from employees
where employee_id = 102;
/*
instri() : �ش� ���ڿ����� Ư�����ڰ� ��ġ�� �ε������� ��ȯ�Ѵ�.
instring
    ����1] instr(�÷���or���ڿ�,'ã������') from dual;
        : ���ڿ��� ó������ ���ڸ� ã�Ƽ� �ε������� ��ȯ�Ѵ�.
    ����2] instr(�÷���or���ڿ�,'ã������',Ž�������ε���,���° ����)
        : Ž���� �ε������� ���ڸ� ã�´�. ��, ã�� ������ ���°�� �ִ� ��������
            ������ �� �ִ�.
        *Ž���� ������ �ε����� ������ ��� �������� �������� ã�Եȴ�.    
*/
SElect instr('good morning john','n')from dual;
--n�� �߰ߵ� ù��° �ε��� ��ȯ
SElect instr('good morning john','n',1,2)from dual;
--1���� �˻��ϱ� �����ؼ� n�� �߰ߵ� �ι�°�� �ִ� �ε����� ��ȯ.
SElect instr('good morning john','h',8,1)from dual;
--�ε��� 8���� �˻��ؼ� h�� �߰ߵ� ù��° �ε���(ó������ cnt) ��ȯ.



