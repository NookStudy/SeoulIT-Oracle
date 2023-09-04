/******************************************************************************
���ϸ�: Or18SubProgram.sql
SubProgram
����: �������ν���, �Լ� �׸��� ���ν����� ������ Ʈ���Ÿ� �н�
*******************************************************************************/
--hr�������� �����մϴ�.

/*
�������α׷�(Sub Program)
    -PL/SQL������ ���ν����� �Լ���� ���ڸ� ������ �������α׷��� �ִ�.
    -select�� �����ؼ� �ٸ� DML���� �̿��Ͽ� ���α׷������� ��Ҹ� ����
    ��밡���ϴ�.
    -Ʈ���Ŵ� ���ν����� �������� Ư�� ���̺��� ���ڵ��� ��ȭ�� �������
    �ڵ����� ����ȴ�.
    -�Լ��� �������� �Ϻκ����� ����ϱ� ���� �����Ѵ�. �� �ܺ� ���α׷�����
    ȣ���ϴ� ���� ���� ����.
    - ���ν����� �ܺ����α׷����� ȣ���ϱ� ���� �����Ѵ�. ���� java,jsp���
    ������ ȣ��� ������ ������ ������ �� �ִ�.
*/

/*
1. �������ν���(Stored Pocedure)
    -���ν����� return���� ���´�� out �Ķ���͸� ���� ���� ��ȯ�Ѵ�.
    -���ȼ��� ���� �� �ְ�, ��Ʈ��ũ�� ���ϸ� ���� �� �ִ�.
    ����]
        Create [or replace] procedure ���ν�����
            [(�Ű����� in �ڷ���)]
            is[��������]
            begin
                ���๮��;
            end;
            *�Ķ���� ������ �ڷ����� ����ϰ�, ũ��� ������� �ʴ´�.
*/
--����1] 100�� ����� �޿��� �����ͼ� ����ϴ� ���ν��� ����
    --���� ù �����̶�� �Ʒ� ������ �����ؾ� ����Ʈ��;
    set serveroutput on;
    
    create procedure pcd_emp_salary 
    is
        /*PL/SQL�� declare ���� ������ ������������ ���ν����� �Լ��� is������
            ������ �����Ѵ�. ���� ������ �ʿ���ٸ� ������ �� �ִ�.
            ������̺��� �޿� �÷��� �����ϴ� ���������� �����Ѵ�.*/
        v_salary employees.salary%type;
    begin
    --100�� ����� �޿��� into�� �̿��ؼ� ������ �Ҵ��Ѵ�..
        select salary into v_salary
        from employees
        where employee_id=100;
        dbms_output.put_line('�����ȣ100�� �޿���:'
            ||v_salary||'�Դϴ�');
    end;
    /
drop procedure pcd_emp_salary;
--������ �������� Ȯ���Ѵ�. ����� �빮�ڷ� ��ȯ�ǹǷ� ��ȯ�Լ� ����
select * from user_source where name like upper('%pcd_emp_salary%');
execute pcd_emp_salary;
--���ν����� ������ ȣ��Ʈȯ�濡�� execute����� �̿��Ѵ�.

        
--����2] IN�Ķ���� ����Ͽ� ���ν��� ����        
/*
�ó�����] ����� �̸��� �Ű������� �޾Ƽ� ������̺��� ���ڵ带 ��ȸ����
�ش����� �޿��� ����ϴ� ���ν����� ���� �� �����Ͻÿ�.
�ش� ������ in�Ķ���͸� ������ ó���Ѵ�.
����̸�(first_name) : Bruce, Neena
*/
--���ν��� ������ in�Ķ���͸� �����Ѵ�. ������̺��� ����� �÷��� �����ϴ�
--���������� ����
create procedure pcd_in_param_salary
    (param_name in employees.first_name%type)
is
    /*
    ������ is ���� �����ϰ�, �ʿ���� ����� �̼���.
    */
    valSalary number(10);
begin
    /*
    ���Ķ���ͷ� ���޵� ������� �������� �޿��� ���� �� ������ �Ҵ��Ѵ�.
    �ϳ��� ����� ��µǹǷ� into�� select������ ����� �� �ִ�.
    */
    select salary into valSalary
    from employees where first_name = param_name;
    
    --�̸�,�޿� ���(out)
    dbms_output.put_line(param_name||'�� �޿��� '||valSalary||'�Դϴ�');
end;
/
--����� �̸��� �Ķ���ͷ� �����Ͽ� ���ν��� ȣ��
--drop procedure pcd_in_param_salary;
execute pcd_in_param_salary('Bruce');
execute pcd_in_param_salary('Neena');
    
-- ����3] OUT�Ķ���� ����Ͽ� ���ν��� ����
/*
�ó�����] �� ������ �����ϰ� ������� �Ű������� ���޹޾Ƽ� �޿��� ��ȸ�ϴ�
���ν����� �����Ͻÿ�. ��, �޿��� out�Ķ���͸� ����Ͽ� ��ȯ�� ����Ͻÿ�.
*/
/*
�ΰ��� ������ �Ķ���͸� �����Ѵ�. �Ϲݺ���, �������� ���� ����ߴ�.
�Ķ������ �뵵�� ���� in,out�� ���� ����Ѵ�. �Ķ���͸� ������ ���� 
ũ��� ������� �ʴ´�.
*/
create or replace procedure pcd_out_param_salary(
        param_name in varchar2,
        param_salary out employees.salary%type)
is
    /*
    select�� ����� out �Ķ���Ϳ� ������ ���̹Ƿ�
     ������ ������ �ʿ����� �ʱ� ������ is���� ����д�.
    �̿� ���� ���������� ������ �� �ִ�.
    */

begin
    /*
    in �Ķ���ʹ� where���� �������� ����ϰ�
    select�� ����� into������ out�Ķ���Ϳ� �����Ѵ�.
    */
    select salary into param_salary
    from employees where first_name = param_name;
end;
/
--ȣ��Ʈ ȯ�濡�� ���ε� ������ �����Ѵ�. var �Ǵ� variable �Ѵ� ��밡��.
var v_salary varchar2(30);
/*
���ν��� ȣ��� ������ �Ķ���͸� �����Ѵ�. Ư�� ���ε� ������ :�� �ٿ����Ѵ�.
Out �Ķ������ param_salary�� ����� ���� V_salary�� ���޵ȴ�.
*/
--���ν��� ���� �� out�Ķ���͸� ���� ���޵� ���� ����Ѵ�.
execute pcd_out_param_salary('Matthew',:v_salary);
execute pcd_out_param_salary('Bruce',:v_salary);

print v_salary;
/*
�ó�����] 
�����ȣ�� �޿��� �Ű������� ���޹޾� �ش����� �޿��� �����ϰ�, 
���� ������ ���� ������ ��ȯ�޾Ƽ� ����ϴ� ���ν����� �ۼ��Ͻÿ�
*/    
--�ǽ��� ���� employees���̺��� ���ڵ���� �����Ѵ�.
create table zcopy_employees
as 
    select * from employees;
select * from zcopy_employees;
--����Ǿ����� Ȯ���Ѵ�.

--in �Ķ���ʹ� �����ȣ�� �޿��� �ۿ��� ���� procedure�� �����Ѵ�.
--out �Ķ���ʹ� ����� ���� ������ ��ȯ�޴´�.
create or replace procedure pcd_update_salary
    (
        p_empid in number,
        p_salary in number,
        rCount out number
    )
is
    --�ΰ����� ���� ������ �ʿ�����Ƿ� ����.
begin
    --���� ������Ʈ�� ó���ϴ� ���������� in�Ķ���͸� ���� ���� �����Ѵ�.
    update zcopy_employees  
        set salary = p_salary
        where employee_id = p_empid;
    /*
    SQL%notfound : �������� �� ����� ���� ���� ��� true�� ��ȯ�Ѵ�.
    SQL%found : �ݴ�. ��������� ����� ���� ������ true
    SQL%rowcount : ���� ���� �� ����� ���� ������ ��ȯ.
    */    
    if SQL%notfound then
        dbms_output.put_line(p_empid||'��(��) ���� ����Դϴ�.');
    else
        dbms_output.put_line(SQL%rowcount||'���� �ڷᰡ ��������');
     
        --���� ����� ���� ������ ��ȯ�Ͽ� out�Ķ���Ϳ� �����Ѵ�.
        rCount:= sql%rowcount;
    end if;
    
    
    /*
    ���ڵ��� ��ȭ�� �ִ� ������ ������ ��� �ݵ�� commit�ؾ� 
     ���� ���̺� ����Ǿ� oracle �ܺο��� Ȯ���� �� �ִ�.
    */
    commit;
end;
/
var outstr number;
execute pcd_update_salary(103,6000,:outstr);
execute pcd_update_salary(110,6000,:outstr);
print outstr;
--procedure ������ ���� ���ε� ����(bind variable) ����

variable r_count number;
--100�� ����� �̸��� �޿��� Ȯ���Ѵ�. : Steve 24000
select first_name, salary from zcopy_employees where employee_id =100;
--procedure ����. ���ε� �������� �ݵ�� (:)�� �ٿ��� �Ѵ�.
execute pcd_update_salary (100, 30000, :r_count);

--update�� ����� ���� ����Ȯ��
print r_count;
--update�� ���� Ȯ��. ���: Steven 30000
select first_name, salary from zcopy_employees where employee_id =100;

------------------------------------------------------------------------------
/*
2.�Լ�
    -����ڰ� PL/SQL���� ����Ͽ� ����Ŭ���� �����ϴ� �����Լ��� ���� �����
    ������ ���̴�.
    -�Լ��� In�Ķ���͸� ����� �� �ְ�, �ݵ�� ��ȯ�� ���� �ڷ����� ����ؾ�
    �Ѵ�.
    -���ν����� �������� ������� ���� �� ������, �Լ��� �ݵ�� �ϳ��� ����
    ��ȯ�ؾ� �Ѵ�.
    -�Լ��� �������� �Ϻκ����� ���ȴ�.
    * �Ķ������ ��ȯŸ���� ����� �� ũ��� ������� �ʴ´�.
    ����]
        Create [Or Replace] Function �Լ��� [(
    	�Ű�����1 [In] �ڷ���,
    	�Ű�����2 In �ڷ���
            )]
        Return �ڷ���
        Is
            [��������]
        Begin
           	�Լ� ���� ����.....;
        End;

*/
/*
�ó�����] 
2���� ������ ���޹޾Ƽ� �� ���������� ������ 
���ؼ� ����� ��ȯ�ϴ� �Լ��� �����Ͻÿ�.
���࿹) 2, 7 -> 2+3+4+5+6+7 = ??
*/
--�Լ��� in�Ķ���͸� �����Ƿ� in�� �ַ� �����Ѵ�.
CREATE OR replace function calsumbetween(
    num1 in number,
    num2 in number
)
return
    --�Լ��� �ݵ�� ��ȯ���� �����Ƿ� ��ȯŸ���� ����ؾ��Ѵ�.(�ʼ�)
    number 
IS
    --��ȯ������ ����� ���� ���� (����: �ʿ���ٸ� ���� �����ϴ�)      
    sumnum NUMBER;
BEGIN
    sumnum := 0;
    --for ���������� ���ڻ����� ���� ����� �� ��ȯ�Ѵ�.
    FOR i IN num1..num2 LOOP
        --�����ϴ� ���� i�� sumnum�� �����ؼ� �����ش�.
        sumnum := sumnum + i;
    END LOOP;
    --������� ��ȯ�Ѵ�.
    RETURN sumnum;
END;
/
--������1 : �������� �Ϻη� ����Ѵ�.
select calsumbetween(1,10) from dual;
--������2 : ���ε庯���� ���� ���������� �ַ� ���������� ����Ѵ�.
var hapText varchar2(30);
execute :hapText :=calsumbetween(1,100);
print hapText;

---������ �������� Ȯ���ϱ�
select * from user_source where name= upper('calsumbetween');

/*
��������] 
����] �ֹι�ȣ�� ���޹޾Ƽ� ������ �Ǵ��ϴ� �Լ��� �����Ͻÿ�.
999999-1000000 -> '����' ��ȯ
999999-2000000 -> '����' ��ȯ
��, 2000�� ���� ����ڴ� 3�� ����, 4�� ������.
�Լ��� : findGender()

��Ʈ
select substr('999999-1000000',8,1) from dual;
select substr('999999-2000000',8,1) from dual;

����Ȯ��
select findGender('999999-1000000') from dual; 
select findGender('999999-4000000') from dual;

**/
----------------------------------------------------------------------NOOK
set serveroutput on;


CREATE OR REPLACE FUNCTION findgender (
    jumin VARCHAR2
) RETURN VARCHAR2 IS
    gender VARCHAR2(20);
BEGIN
    IF substr(jumin, 8, 1) = '1' OR substr(jumin, 8, 1) = '3' THEN
        select '����' into gender from dual;
    ELSIF substr(jumin, 8, 1) = '2' OR substr(jumin, 8, 1) = '4' THEN
        select '����' into gender from dual;
    ELSE
       select 'Ʋ��' into gender from dual;
    END IF;
    return gender;
END;
/
select findgender('123456-4234567') from dual;

drop function findgender;
var genderidentify varchar2(20);
select findgender('123456-3234567') into genderidentify from dual;
dbms_output.put_line(genderidentify);
set serveroutput on;
declare
jumintest varchar2(30) :='123456-1234567';
subjumin varchar2(1);
begin
select substr(jumintest,8,1) into subjumin from dual;
dbms_output.put_line(subjumin);
end;
/
select substr('999999-1000000',8,1) from dual;
------------------------------------------------------------------------------


select substr('999999-1000000',8,1) from dual;
--�ش� �Լ��� �ֹι�ȣ�� �������·� �޾Ƽ� ������ �Ǵ��Ѵ�.
--�Լ�(function)�� in�Ķ���͸� �����Ƿ� in�� �����ϴ� ���� ����.
create or replace function findgender(juminNum varchar2)
--�Լ��� �ݵ�� ��ȯŸ���� ����ؾ� �Ѵ�. ���� �Ǵ� �� '����' Ȥ��'����'��
--��ȯ�ϹǷ� ���������� �����Ѵ�.
return varchar2
is 
    --�����������夲����
    gendertxt varchar2(1);
    --���� ������ ��ȯ���� ����
    returnval varchar2(10);
begin
    --���1
    --�������� ����� ����� into�� ���� ������ ����
    select substr(juminNum,8,1) into gendertxt from dual;
    
    --���2 : substr�� �������
    gendertxt:=substr(juminNum,8,1);
    
    IF GENDERTXT ='1' THEN
        RETURNVAL :='����';
    elsif gendertxt ='2' then
        returnval := '����';
    elsif gendertxt ='3' then
        returnval := '����';
    elsif gendertxt ='4' then
        returnval := '����'; 
    else
        returnval :='����';
    end if;
    --�Լ��� �ݵ�� ��ȯ���� ������.
    return returnval;
end;
/

select findgender('990909-100000') from dual;
select findgender('990909-500000') from dual;
select findgender('990909-500000') from dual;
        
/*
�ó�����] ����� �̸�(FIRST_NAME)�� �Ű������� ���޹޾Ƽ� 
�μ���(DEPARTMENT_NAME)�� ��ȯ�ϴ� �Լ��� �ۼ��Ͻÿ�.
�Լ��� : FUNC_DEPARTnMAE;
*/        
--1�ܰ� :Nancy�� �μ����� ����ϱ� ���� inner join�� �ۼ�
select first_name, last_name, department_id, department_name
from employees inner join departments using (department_id)
where upper(first_name) = 'NANCY';

--2�ܰ� �Լ��ۼ�
CREATE OR REPLACE FUNCTION FUNC_DEPARTNAME(F_NAME Employees.first_name%type)
return varchar2
is
    departname departments.department_name%type;
begin
    select department_name into departname
    from employees inner join departments using (department_id)
    where upper(first_name) = upper(f_name);
    return departname;
end;
/
select func_departname('NANCY') from dual;
select func_departname('diana') from dual;

/*
3.Ʈ����(Trigger)
    : �ڵ����� ����Ǵ� ���ν����� ���� ������ �Ұ����ϴ�.
    �ַ� ���̺� �Էµ� ���ڵ��� ��ȭ�� ���� �� �ڵ����� �����Ѵ�.
*/
--Ʈ���� �ǽ��� ���� HR�������� �Ʒ� ���̺��� �����Ѵ�.
--���̺��� ���ڵ���� ��� �����Ѵ�.
create table trigger_dept_orginal
as
select * from departments;
    
select * from tab;
--���̺��� ��Ű��(����)�� �����Ѵ�. where���� false���� ������ ���ڵ�� �̼���
create table trigger_dept_backup
as
select * from departments where 1=0;
/*
����1] trig_dept_backup
�ó�����] ���̺� ���ο� �����Ͱ� �ԷµǸ� �ش� �����͸� ������̺� �����ϴ�
Ʈ���Ÿ� �ۼ��غ���.
*/
create or replace trigger trig_dept_backup
    after -->> Ÿ�̹� : after => �̺�Ʈ �߻���, before =>�̺�Ʈ �߻���
    Insert-- �̺�Ʈ : insert/update/delete �� ���� ��������� �߻�
    on trigger_dept_orginal --Ʈ���Ÿ� ������ ���̺��
    for each row
    /*
        �� ���� Ʈ���� �����Ѵ�. �� �ϳ��� ���� ��ȭ�� ������ Ʈ���Ű� ����.
        ���� ����(���̺�)���� Ʈ���ŷ� �����ϰ� �ʹٸ� �ش� ������ �����ϸ��.
        �� ���� ������ �ѹ� ���� �� �� Ʈ���ŵ� �� �ѹ��� ����ȴ�.
    */
begin
    --insert �̺�Ʈ�� �߻��Ǹ� true�� ��ȯ�Ͽ� if ���� ����ȴ�.
    if inserting then
        dbms_output.put_line('insert Ʈ���� �߻���');
        /*
        ���ο� ���ڵ尡 �ԷµǾ����Ƿ� �ӽ����̺� :new�� ����ǰ�
        �ش� ���ڵ带 ���� backup���̺� �Է��Ҽ� �ִ�.
        �̿� ���� �ӽ����̺��� Ʈ���ſ����� ����� �� �ִ�.
        */
        insert into trigger_dept_backup
        values(
            :new.department_id,
            :new.department_name,
            :new.manager_id,
            :new.location_id
        );
    end if;
end;
/
set serveroutput on;
insert into trigger_dept_orginal values(101,'������',10,100);
insert into trigger_dept_orginal values(102,'������',20,100);
insert into trigger_dept_orginal values(103,'������',30,100);
select * from trigger_dept_orginal;
select * from trigger_dept_backup;

--����2] trig_dept_delete
/*
�ó�����]  ���ڵ尡 �����Ǹ� ������̺��� ���ڵ嵵 ����
�����Ǵ� Ʈ���Ÿ� �ۼ��غ���.

*/
create or replace trigger trig_dept_delete
    /*
    trigger_dept_orginal���� ����Ʈ �߻��� Ʈ���� �߻�
    */
    after
    delete
    on trigger_dept_orginal
    for each row
begin
    dbms_output.put_line('delete Ʈ���� �߻���');
    /*
    ���ڵ尡 ������ ���Ŀ� �̺�Ʈ�� �߻��Ǿ� Ʈ���Ű� ȣ��ǹǷ� 
    :old �ӽ����̺��� ����Ѵ�.
    */
    
    if deleting then
        delete from trigger_dept_backup
            where department_id = :old.department_id;
    end if;
end;
/

delete from trigger_dept_orginal where department_id=101;

select * from trigger_dept_orginal;
select * from trigger_dept_backup;


--����3] trigger_update_test
/*
for each row �ɼǿ� ���� Ʈ���� ����Ƚ��
*/

create or replace trigger trigger_update_test
    after 
    update
    on trigger_dept_orginal
    for each row
begin
    if updating then
        INSERT into trigger_dept_backup
    values(
        :old.department_id,
        :old.department_name,
        :old.manager_id,
        :old.location_id
        );
    end if;
end;
/

select * from trigger_dept_orginal where
    department_id>=10 and department_id<=50;
update trigger_dept_orginal set department_name='5�� ������Ʈ'
where department_id>=10 and department_id<=50;
--�������̺��� 5���� ���ڵ尡 ������Ʈ�ǹǷ�, ������̺��� 5���� �Է�.
--����� Ʈ���Ŵ� ����� ���� ������ŭ ����ȴ�.
select * from trigger_dept_orginal;
select * from trigger_dept_backup;

/*
���� 2 : �������� ���̺� ������Ʈ ���� ���̺�(����) ������ �߻��Ǵ� Ʈ���Ż���.

*/

create or replace trigger tirgger_update_test2
    after
    update
    on trigger_dept_orginal
    /* for each row */
    /*
    �������� ���̺��� ���ڵ带 ������Ʈ �� ���� ���̺������ Ʈ���Ű�
    ����ǹǷ� ����Ǵ� ������ ������� ������ �ѹ��� Ʈ���� ����
    */
    begin
    if updating then--������Ʈ �̺�Ʈ�� �����Ǹ� backup���̺� ���ڵ� �Է�.
        dbms_output.put_line('update Ʈ���� �߻�');
        insert into trigger_dept_backup
        values(
        /*
        ���̺�(����) ���� Ʈ���ſ����� �ӽ����̺��� ����� �� ����.
        :old.department_id,
        :old.department_name,
        :old.manager_id,
        :old.location_id
        */
        999, to_char(sysdate,'yyyy-mm-dd hh24:mi:ss'),99,99
        );
    END IF;
END;
/
--���� ����(5�� ���ڵ�)
select * from trigger_dept_orginal where
    department_id>=10 and department_id<=50;
update trigger_dept_orginal set department_name='5�� ������Ʈ2'
where department_id>=10 and department_id<=50;
--5���� ���ڵ� ��������Ʈ ������,���̺���� �����̹Ƿ� 1�����Է�.
where department_id>=10 and department_id<=50;
select * from trigger_dept_orginal;
select * from trigger_dept_backup;
--Ʈ���� �����ϱ�.
drop trigger tirgger_update_test2;
drop trigger trigger_update_test;