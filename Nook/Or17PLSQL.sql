/******************************************************************************
���ϸ�: Or17PLSQL.sql
PL/SQL
����: ����Ŭ���� �����ϴ� ���α׷��� ���
*******************************************************************************/
--hr�������� �����մϴ�.
/*
PL/SQL(procedure Language)
    : �Ϲ� ���α׷��� ���� ������ �ִ� ��Ҹ� ��� ������ ������ DB������
     ó���ϱ� ���� ����ȭ�� ����̴�.
*/
--����1] PL/SQL ������
--ȭ��� ������ ����ϰ� ������ on���� ����. off�϶��� ��µ��� �ʴ´�.
set serveroutput on;

declare--����� �ַ� ��������
    cnt number;--����Ÿ�� ���� ����.
begin--�����: begin~end�� ���̿��� ����. �ڹ��� ����
    cnt :=10;
    cnt := cnt +1;
    dbms_output.put_line(cnt); --java�� println�� �����ϴ�.
end;
/
/*
 PL/SQL ������ ������ /�� �ٿ��� �ϴµ�, ���� ������
ȣ��Ʈ ȯ������ ���������� ���Ѵ�.
 ��, PL/SQL ������ ���� �ʿ��ϴ�.
 ȣ��Ʈ ȯ���̶� �������� �Է��ϱ� ���� SQL���¸� ���Ѵ�.
*/

--����2] �Ϲݺ��� �� into
/*
�ó�����] ������̺��� �����ȣ�� 120�� ����� �̸��� ����ó�� ����ϴ�
    PL/SQL���� �ۼ��Ͻÿ�.
*/
select * from employees where employee_id=120;

select concat(first_name||' ',lastname), phone_number
from employees where employee_id =120;

declare
--    empName varchar2(50);
    empName varchar2(60);
    empPhone varchar2(30);
    /*
    ����ο��� ������ ������ ���� ���̺� �����ÿ� �����ϰ� �����Ѵ�.
    => ������ �ڷ���(ũ��)
    ��, ������ ������ �÷��� Ÿ�԰� ũ�⸦ �����Ͽ� �������ִ°��� ����.
     �Ʒ� '�̸�' �� ��� �ΰ��� �÷��� ������ �����̹Ƿ� ���� �� �˳��� ũ���
    ������ �ִ°��� ����.
    */
begin
    /*
    ����� :  select ������ ������ ����� ����ο��� ������ ������
    1:1�� �����Ͽ� ���� �����Ѵ�. �� �� into�� ����Ѵ�.
    */
    select
        concat(concat(first_name,' '),last_name),
        phone_number
    into
        empName, empPhone
    from employees
    where employee_id=120;
    
    dbms_output.put_line(empName||' '||empPhone);
end;
/

--����3] ��������1(�ϳ��� �÷� ����)
/*
    �������� : Ư�� ���̺��� �÷��� �����ϴ� �����ν� ������ �ڷ����� ũ���
        �����ϰ� ���� �� ����Ѵ�.
      ����] ���̺��.�÷���%type
        => ���̺��� '�ϳ�'�� �÷��� �����Ѵ�.
*/
/*
�ó�����] �μ���ȣ 10����� �����ȣ,�޿�,�μ���ȣ�� �����ͼ� �Ʒ������� ������
ȭ��� ����ϴ� PL/SQL���� �ۼ��Ͻÿ�. 
    ��, ������ �������̺��� �ڷ����������ϴ� '��������'�� �����Ͻÿ�
*/
--�ó������� ���ǿ� �´� select ���� �ۼ��ؼ� Ȯ��
select employee_id,salary, department_id from employees
    where department_id=10;
    
declare
    --������̺��� Ư�� �÷��� Ÿ�԰� ũ�⸦ �״�� �����ϴ� ������ �����Ѵ�.
    empNo employees.employee_id%type;   --number(6,0)
    empSal employees.salary%type;       --number(8,2)
    deptID employees.department_id%type;--number(4,0)
begin
    --select�� ����� into�� ���ؼ� ������ ������ �Ҵ��Ѵ�.
    select employee_id, salary, department_id
        into empNo, empSal, deptId
    from employees
    where department_id=10;
    
    dbms_output.put_line(empNo||' '||EMPSal||' '||deptID);--���
end;
/

--����4] ��������2 (��ü�÷��� ����)
/*
�ó�����] �����ȣ�� 100�� ����� ���ڵ带 �����ͼ� emp_row������ 
    ��ü �÷��� ������ �� ȭ�鿡 ���� ������ ����Ͻÿ�.
  ��, emp_row�� ������̺��� ��ü�÷��� ������ �� �ִ� ���������� �����ؾ��Ѵ�.
  ������� : �����ȣ, �̸�, �̸���, �޿�
*/

select employee_id, first_name, email, salary from employees where employee_id=100;

declare
    /*
    ������̺� ��ü �÷��� �����ϴ� ���������� �����Ѵ�.
    �� �� ���̺�� �ڿ� %rowtype�� �ٿ� �����Ѵ�.
    */
    emp_row employees%rowtype;
begin 
    /*
    ���ϵ� ī�� *�� ���� ���� ��ü�÷��� ���� emp_row�� �Ѳ����� �����Ѵ�.
    */
    select *
        into emp_row
        from employees where employee_id=100;
    
  --emp_row ���� ��ü�÷��� ������ ����ǹǷ� ��½� ������.�÷��� ���·� ���.
        
    dbms_output.put_line(emp_row.employee_id||' '||
                        emp_row.first_name||' '||   
                        emp_row.email||' '||
                        emp_row.salary);
end;
/

--����5] ���պ���
/*
���պ��� 
    : class�� �����ϵ� �ʿ��� �ڷ����� ���� �ϳ��� �ڷ����� ���� �� 
        �����ϴ� ������ ���Ѵ�.
    ����]
        type ���պ����ڷ��� is record(
            �÷���1 �ڷ���(ũ��),
            �÷���2 ���̺��.�÷���%type
        );
    �տ��� ������ �ڷ����� ������� ������ �����Ѵ�.
    ���պ��� �ڷ����� ���� ���� �Ϲݺ����� �������� 2������ �����ؼ� ��밡��.
*/
/*
�ó�����] �����ȣ, �̸�(first_name+last_name), ���������� ������ �� �ִ� 
���պ����� ������ ��, 100�� ����� ������ ����ϴ� PL/SQL�� �ۼ��Ͻÿ�.
*/
select employee_id, first_name||' '||last_name, job_id
from employees where employee_id =100;

declare
    --3���� Ÿ���� �����Ҽ� �ִ� ���պ��� ����
    type emp_3type is record(
    emp_id employees.employee_id%type,
    emp_name varchar2(50),
    emp_job employees.job_id%type
    );
    /*�տ��� ������ ���պ��� �ڷ����� ���� ������ ���պ����� 3���� ����
    ������ �� �յ�. */
    record3 emp_3type; --�޼ҵ帶�� �̸�����"�ݵ�� �ʿ�"
begin
    select employee_id, first_name||' '||last_name, job_id
        into record3
    from employees where employee_id=100;
    dbms_output.put_line(record3.emp_id||' '||
                        record3.emp_name||' '||   
                        record3.emp_job);
end;
/

/*
��������
�Ʒ� ������ ���� PL/SQL���� �ۼ��Ͻÿ�.
1.���պ�������
    - �������̺� : employees
    - ���պ����ڷ����� �̸� : empTypes
            ���1 : emp_id -> �����ȣ
            ���2 : emp_name -> �������ü�̸�(�̸�+��)
            ���3 : emp_salary -> �޿�
            ���4 : emp_percent -> ���ʽ���
    ������ ������ �ڷ����� �̿��Ͽ� ���պ��� rec2�� ������ 
    �����ȣ 100���� ������ �Ҵ��Ѵ�.
 2.1�� ������ ����Ѵ�.
3.�� ������ �Ϸ����� ġȯ�����ڸ� ����Ͽ� 
    �����ȣ�� ����ڷκ��� �Է¹��� �� 
    �ش� ����� ������ ����Ҽ��ֵ��� �����Ͻÿ�.[����]
*/
declare
    type empTypes is record(
    emp_id employees.employee_id%type,
    emp_name varchar2(50),
    emp_salary employees.salary%type,
    emp_percent employees.commission_pct%type
    );
    rec2 empTypes;
begin
    select employee_id,first_name||' '||last_name, 
        salary,nvl(commission_pct,0)
        INTO REC2
    FROM EMPLOYEES  WHERE employee_id=100;  
        dbms_output.put_line('�����ȣ/�����/�޿�/���ʽ���');
        dbms_output.put_line(rec2.emp_id||' '||
                            rec2.emp_name||' '||
                            rec2.emp_salary||' '||
                            rec2.emp_percent);
end;
/

/*
ġȯ������ : PL/SQL������ ����ڷκ��� �����͸� �Է¹��� �� ����ϴ� �����ڷ�
�����տ� &�� �ٿ��ָ�ȴ�. ����� �Է�â�� ���.
*/
--�տ��� �ۼ��� PL/SQL�� ġȯ�����ڸ� �����Ͽ� ������ ����.

declare
    type empTypes is record(
    emp_id employees.employee_id%type,
    emp_name varchar2(50),
    emp_salary employees.salary%type,
    emp_percent employees.commission_pct%type
    );
    --���պ��� �ڷ����� ���� ���� ����.
    rec2 empTypes;
    --ġȯ�����ڸ� ���� �Է¹��� ���� �Ҵ��Ͽ� ���� ����.
    inputNum number(3);
begin
    select employee_id,first_name||' '||last_name, 
        salary,nvl(commission_pct,0)
        INTO REC2
    FROM EMPLOYEES  WHERE employee_id=&inputNum; --&�����ڿ� ���������� �Է¹���. 
        dbms_output.put_line('�����ȣ/�����/�޿�/���ʽ���');
        dbms_output.put_line(rec2.emp_id||' '||
                            rec2.emp_name||' '||
                            rec2.emp_salary||' '||
                            rec2.emp_percent);
end;
/


/*
���ε� ����
    : ȣ��Ʈ ȯ�濡�� ����� �����ν�  �� PL/SQL�����̴�.
    ȣ��Ʈȯ���̶� PL/SQL�� ���� ������ ������ �κ��� ���Ѵ�.
    �ܼ�(cmdâ)������ SQL> ���������Ʈ�� �ִ� ���¸� ���Ѵ�.
*/
set serveroutput on;
--ȣ��Ʈȯ�濡�� ���ε� ���� ����
var return_var number;
--PL/SQL�ۼ�
declare
    --����δ� �̿Ͱ��� �����ϼ��� ����
begin
    --���ε� ������ �Ϲݺ������� ������ ���� :(�ݷ�)�� �߰��ؾ� �Ѵ�.
    :return_var :=999;
    dbms_output.put_line(:return_var);
end;
/
--ȣ��Ʈȯ�濡�� ��½ÿ��� print�� ����Ѵ�.
--���� ����� �ȵȴٸ� cmd���� Ȯ���غ��� ���������� ��µȴ�.
print return_var;

/*
�ó�����] ������ ����� ���ڰ� Ȧ�� or ¦������ �Ǵ��ϴ� PL/SQL�� �ۼ��Ͻÿ�
*/
--if�� : Ȧ���� ¦���� �Ǵ��ϴ� if�� �ۼ�
declare
    --����ο��� ����Ÿ�� ���� ����
    num number;
begin
    num :=10;
    --10�� �Ҵ��� �� ¦������ �Ǵ��Ѵ�.
    if mod(num,2)=0 then
    --mod(����,����) : ������ ������ ���� �������� ��ȯ�ϴ� ����
        dbms_output.put_line(num||'�� ¦��');
    else 
        dbms_output.put_line(num||'�� Ȧ��');
    end if;
end;
/
--����]�� ������ ġȯ�����ڸ� ���� ���ڸ� �Է¹����� �ֵ��� �����Ͻÿ�         
declare
    --����ο��� ����Ÿ�� ���� ����
    num number;
begin
/*
ġȯ �����ڴ� �����, ����� ��𼭵� ����� �� �ִ�.
**/
    num := &num;
    --10�� �Ҵ��� �� ¦������ �Ǵ��Ѵ�.
    if mod(num,2)=0 then
    --mod(����,����) : ������ ������ ���� �������� ��ȯ�ϴ� ����
        dbms_output.put_line(num||'�� ¦��');
    else 
        dbms_output.put_line(num||'�� Ȧ��');
    end if;
end;
/        

--����8] ���(���ǹ�: if-elseif)
/*
�ó�����] �����ȣ�� ����ڷκ��� �Է¹��� �� �ش� ����� ��μ�����
�ٹ��ϴ����� ����ϴ� PL/SQL���� �ۼ��Ͻÿ�. ��, if~elsif���� ����Ͽ�
�����Ͻÿ�.
*/
declare  
    --ġȯ�����ڸ� ���� �����ȣ�� �Է¹���
    emp_id employees.employee_id%type := &emp_id;
    emp_name varchar2(50);
    emp_dept employees.department_id%type;
    dept_name varchar2(30) := '�μ���������';
    --�μ����� ����� ���ÿ� �ʱ�ȭ�Ѵ�. ��ġ�ϴ� ������ ���°��
    --�ʱⰪ���� ��µȴ�.
begin
    select employee_id, last_name, department_id
        into emp_id,emp_name,emp_dept
    from employees
    where employee_id = emp_id; -- �Է¹��� �����ȣ�� ������ ����
    /*
    �������� ������ ����� ��� java�� ���� else if�� ������� �ʰ�
    elsif�� ����ؾ� �Ѵ�. ���� �߰�ȣ ��� then�� end if;�� ���ȴ�.
    */
    if emp_dept = 50 then
        dept_name := 'Shipping';
    elsif emp_dept = 60 then
        dept_name := 'IT';
    elsif emp_dept = 70 then
        dept_name := 'Public Relations';
     elsif emp_dept = 80 then
        dept_name := 'Sales';
     elsif emp_dept = 90 then
        dept_name := 'Executive';
      elsif emp_dept = 100 then
        dept_name := 'Finance';
     end if;
     
     dbms_output.put_line('�����ȣ'||emp_id||'�� ����');
     dbms_output.put_line('�̸�:'||emp_name||', �μ���ȣ:'||emp_dept
                            ||', �μ���:'||dept_name);
end;
/
 
/*
case�� : java switch ���� ����� ���ǹ�
    ����]
        case ����
            when ��1 then '�Ҵ簪1'
            when ��2 then '�Ҵ簪2'
            when ��4 then '�Ҵ簪3'..
            ...��N
        end;    
**/        
/*
����9] ���(���ǹ� : case~when)
�ó�����] �տ��� if~elsif�� �ۼ��� PL/SQL���� case~when������ �����Ͻÿ�.
*/        
declare  
    emp_id employees.employee_id%type := &emp_id;
    emp_name varchar2(50);
    emp_dept employees.department_id%type;
    dept_name varchar2(30) := '�μ���������';
begin
    select employee_id, last_name, department_id
        into emp_id,emp_name,emp_dept
    from employees
    where employee_id = emp_id;        
    /*
    case~when���� if���� �ٸ����� �Ҵ��� ������ ���� ������ �� ���峻����
    ������ ������� �ʱ� �����̴�.------------����ġ��..----------
    */           
    dept_name :=
        case emp_dept
            when 50 then 'Shipping'
            when 60 then 'IT'
            when 70 then 'Public Relations'
            when 80 then 'Salse'
            when 90 then 'Executive'
            when 100 then 'Finance'
        end;
        
      dbms_output.put_line('�����ȣ'||emp_id||'�� ����');
      dbms_output.put_line('�̸�:'||emp_name||', �μ���ȣ:'||emp_dept
                            ||', �μ���:'||dept_name);  
                            
end;
/


-------------------------------------------------------------------------
--���(�ݺ���)
/*
�ݺ���1 : Basic Loop
    java�� do~while���� ���� ����üũ���� loop������ �� Ż�������� �ɶ�����
    �ݺ��Ѵ�. Ż��ÿ��� exit�� ����Ѵ�.
*/    
--����10] ���(�ݺ��� : basic loop)    

declare
    num number := 0;
begin
    --���� üũ���� ������ �����Ѵ�.
    loop
        --0~10���� ����Ѵ�.
        dbms_output.put_line(num);
        --���������� �����Կ����ڰ� �����Ƿ� �Ϲ����� �������
        --������ �������Ѿ� �Ѵ�.
        num := num+1;
        -- num�� 10�� �ʰ��ϸ� loop���� Ż���Ѵ�.
        --exit�� �ڹ��� break; �� ������ ������ �����Ѵ�.
        exit when (num>10);
    end loop;
end;
/

--����11] ���(�ݺ��� : basic loop)
/*
�ó�����] Basic loop������ 
    1���� 10������ ������ ���� ���ϴ� ���α׷��� �ۼ��Ͻÿ�.
*/
DECLARE
    i      NUMBER := 1;
        --�ݺ�����
    sumNum NUMBER := 0;
        --������
        --���������� sum ��� �Ұ�. �׷��Լ��� ���Ұ�.

BEGIN
    LOOP
        sumnum := sumnum + i;
        --i��ŭ�� ����
        i := i + 1;
        --1��ŭ�� ����
        EXIT WHEN ( i > 10 );
        --i�� 10 �Ѿ�� Ż��
    END LOOP;
    dbms_output.put_line('1~10������ ����:' || sumnum);
END;
/
/*
�ݺ���2 : while��
    Basic Loop�ʹ� �ٸ��� ������ ���� Ȯ���� �� �����Ѵ�.
    ��, ���ǿ� ���� �ʴ´ٸ� �ѹ��� ������� ���� �� �ִ�.
    �ݺ��� ������ �����Ƿ� Ư���� ���ƴ϶��  exit�� ������� �ʾƵ� �ȴ�.
*/        
--����12] ���(�ݺ��� : while)
DECLARE
    num1 NUMBER := 0;
BEGIN
    WHILE num1 < 11 LOOP
        dbms_output.put_line('�̹����ڴ�:' || num1);
        num1 := num1 + 1;
    END LOOP;
END;
/

--   ����13] ���(�ݺ��� : while) 
/*
�ó�����] while loop������ ������ ���� ����� ����Ͻÿ�.
*
**
***
****
*****
*/
DECLARE
    --*�� �����ؼ� ������ ������ ���� ����
    starstr VARCHAR2(100);
    i       NUMBER := 1;
    --�ݺ��� ���� ���� ����
--    j       NUMBER := 1;
BEGIN
    WHILE i <= 5 LOOP
--        WHILE j <= 5 LOOP
            starstr := starstr || '*';
--            EXIT WHEN ( j <= i );
--            j := j + 1;
            i:= i+1;
        dbms_output.put_line(starstr);

        END LOOP;

--        i := i + 1;
--        j := j + 1;
--    END LOOP;
END;
/

--����14] ���(�ݺ��� : while) 
/*
�ó�����] while loop������ 
    1���� 10������ ������ ���� ���ϴ� ���α׷��� �ۼ��Ͻÿ�. 
*/
declare 
    i number := 1;
    sumNum number := 0;
begin
    while i<=10 loop
        sumnum := sumNum+ i;
        i:=i+1;
        end loop;
        --���ٸ� EXIT��� �˾Ƽ� Ż��
        dbms_output.put_line('1~10������ ����:' || sumnum);
end;
/
/*
�ݺ��� FOR
    : �ݺ��� Ƚ���� �����Ͽ� ����ϴ� �ݺ���.
    �ݺ������� ������ �������� �ʾƵ� ���ϴ�.
    ���� �� ������ ������ �����(DECLARE)�� ������� �ʾƵ� �ȴ�.
*/
--����15] ���(�ݺ��� : for) 
DECLARE BEGIN
    FOR num2 IN 0..10 LOOP
        dbms_output.put_line('for�� ¯�ε�:' || num2);
    END LOOP;
END;
/

BEGIN
    FOR num2 IN REVERSE 0..10 LOOP
        dbms_output.put_line('for�� ¯�ε�:' || num2);
    END LOOP;
END;
/        

-- ����16] ���(�ݺ���:FOR)
/*
��������] FOR LOOP ������  �������� ����ϴ� ���α׷��� �ۼ��Ͻÿ�
*/
begin
    for dan in 2..9 loop
        dbms_output.put_line(dan|| '��');
        --�� ���
        for su in 1..9 loop
        dbms_output.put_line(dan||'*'||su||su||'='||(dan*su));
        --�������� ��� ����ϰ� �ٹٲ� ó��
        end loop;
    end loop;
end;
/
DECLARE
-- prinf�� �����Ƿ� Str�� ���� �������༭ printf�� ������ ����ؾ� �Ѵ�.
--�����ܿ��� �ϳ��� phrase(x*y=z)�� �����ϱ� ���� str.
    gugustr VARCHAR2(1000);
BEGIN
    FOR dan IN 2..9 LOOP
        FOR su IN 1..9 LOOP
        --�����ؼ� ����
            gugustr := gugustr
                       || dan|| '*'|| su || '='|| ( dan * su ) || ' ';
        END LOOP;
        dbms_output.put_line(gugustr);
        gugustr := '';
    END LOOP;
END;
/
/*
Ŀ��(Cursor)
    : select ���忡 ���� �������� ��ȯ�Ǵ� ��� �� �࿡ �����ϱ� ���� �ݺ���ü
    ���� ���]  
        Cursor Ŀ���� IS
            select ������. �� into���� ���� ���·� ����Ѵ�.
        
    Open Cursor
      :������ �����϶�� �ǹ�. 
        ��, Open�Ҷ� Cursor������� select������ ����Ǿ� ������� ��Եȴ�.
        Cursor�� �� ������� ù��° �࿡ ��ġ�ϰ� �ȴ�.
    Fetch ~ into~ 
      : ����¿� �ϳ��� ���� �о���̴� �۾����� ������� ����(Fetch)�Ŀ�
        Curosor�� ���������� �̵��Ѵ�.
    Close Cursor    
      : Ŀ�� �ݱ�� ������� �ڿ��� �ݳ��Ѵ�.
         select ������ ��� ó���� �� Cursor�� �ݾ��ش�.
    
    Cursor�� �Ӽ�
        %Found : ���� �ֱٿ� ����(Fetch)�� ���� Return�ϸ� true �ƴϸ� false.
        %NotFound : %Found�� �ݴ��� ���� ��ȯ�Ѵ�.    
        %RowCount : ���ݱ��� Return�� ���� ������ ��ȯ�Ѵ�.
*/
--����17] Cursor
/*
�ó�����] �μ����̺��� ���ڵ带 Cursor�� ���� ����ϴ� PL/SQL���� �ۼ��Ͻÿ�.
*/
declare 
--������ ��°�� �޴� V_dept ����
    v_dept departments%rowtype;
    /*
    Ŀ������ : �μ����̺��� ��� ���ڵ带 ��ȸ�ϴ� select������ 
        into���� ���� ���·� ����Ѵ�.
        ������ ������ cur1�� ����ȴ�.
    */    
    cursor cur1 is
        select department_id, department_name, location_id
        from departments;
begin
    /*
    �ش� �������� �����ؼ� �����(ResultSet)�� �����´�. 
    ������̶� ����(����)���� ������ �� ��ȯ�Ǵ� ���ڵ��� ����� ���Ѵ�.
    */
    open cur1;
    --basic ���������� ���� ������� ������ŭ �ݺ��Ͽ� �����Ѵ�.
    loop
        fetch cur1 into
            --fetch�� ����� ���������� ���� �����Ѵ�.
            --fetch�� ��ü�� �ϳ��� ���� ������ ���������� Ŀ���� �̵���.
            v_dept.department_id,
            v_dept.department_name,
            v_dept.location_id;
        
        exit when cur1%notfound;
        
        dbms_output.put_line(v_dept.department_id||' '||
                                v_dept.department_name||' '||
                                v_dept.location_id);
    end loop;
    dbms_output.put_line('����� ���� ����:'||cur1%rowcount);
    close cur1;
    --Ŀ���� �ڿ��ݳ�(�� ����)
end;
/
 
--����18] Cursor
/*
�ó�����] Cursor�� ����Ͽ� ������̺��� 
        Ŀ�̼��� null�� �ƴ� ����� �����ȣ, �̸�, �޿��� ����Ͻÿ�. 
        ��½ÿ��� �̸��� ������������ �����Ͻÿ�.
*/
select * from employees where commission_pct is not null;

declare 
    cursor curEMp is
        select employee_id, last_name, salary
        from employees
        where commission_pct is not null
        order by last_name asc;
        --������̕��� ��ü�÷��� �����ϴ� �������� ����
    varEmp employees%rowType;
begin
    open curEmp;
    
    loop 
        fetch curemp 
            into varemp.employee_id, varemp.last_name, varemp.salary;
        --������ ������� ������ ������ Ż��
        exit when curemp%notfound;
        dbms_output.put_line(varemp.employee_id||' '||
                                varemp.last_name||' '||
                                varemp.salary);
        end loop;
       dbms_output.put_line('����� ���� ����:'||curemp%rowcount);--�� �� ��
    close curemp;
    --Ŀ���ݱ�
end;
/
/*
�÷���(�迭)
    :�Ϲ� ���α׷��� ���� ����ϴ� �迭Ÿ���� 
       PL/SQL������ ���̺�Ÿ�����̶�� �Ѵ�.
     1,2���� �迭�� �����غ��� ���̺�(ǥ)�� ���� �����̱� �����̴�.
����
    -�����迭
    -Varray
    -��ø���̺�
1. �����迭(Associative Array)
    : key�� Value�� �ѽ����� ������ �÷������� JAVA�� �ؽøʰ� ���� �����̴�.
    KEY : �ڷ����� �ַ� ���ڸ� ����Ѵ�. 
        binary_interfrt, pls_interger�� �ַ� ����ϴµ� 
         numberŸ�Ժ��� ũ��� ������, ������꿡 ���� Ư¡�� ������.
    Value : �������� �ַ� ����ϰ� varchar2�� ���� �ȴ�.
    
    ����] 
        Type �����迭�ڷ��� is 
            TABLE of ���� Ÿ��
            index by Ű�� Ÿ��;
*/
--����19] �����迭(Associative Array)
/*
�ó�����] ������ ���ǿ� �´� �����迭�� ������ �� ���� �Ҵ��Ͻÿ�.
    �����迭 �ڷ��� �� : avType, �����ڷ���:������, Ű���ڷ���:������
    key : girl, boy
    value : Ʈ���̽�, ��ź�ҳ��
    ������ : var_array
*/
declare
    type avtype is  --avtype �̶�� �����迭(��) ����
        table of varchar2(30) --value�� type ����
        index by varchar2(10); -- key�� type ����
    var_array avtype; --�����迭 ���� var_array ����
begin
    var_array('girl') := 'Ʈ���̽�';
    var_array('boy') := '��ź�ҳ��';
    
    dbms_output.put_line(var_array('girl'));
    dbms_output.put_line(var_array('boy'));
end;
/


--����20] �����迭(Associative Array)
/*
�ó�����] 100�� �μ��� �ٹ��ϴ� ����� �̸��� �����ϴ� �����迭�� �����Ͻÿ�.   
key�� ����, value�� full_name ���� �����Ͻÿ�.
*/
select * from employees where department_id=100;

--fullname�� ���� ����
select first_name||' '|| last_name
    from employees where department_id=100;
---������ ������ ���� �������� �ټ����� ����Ǿ����Ƿ� cursor�� ����Ѵ�.
declare
        --Ŀ�� ����
    cursor emp_cur is
        select first_name||' '|| last_name from employees
        where department_id=100;
     --�����迭 �ڷ��� ����(KEY : ���� , value : ����)   
    Type nameAvtype is
        table of varchar2(30)
        index by binary_integer;
    --�ڷ��� ������� ��������
    names_arr nameavtype;
    --����� �̸��� �ε����� ����� ��������
    fname varchar2(50);
    idx number :=1;
    
begin
    --Ŀ�� ������ �������� �����Ͽ�  ����� ������ŭ �ݺ��Ͽ� ����� ����
    open emp_cur;
    loop
        fetch emp_cur into fname;
        --���⳻���� ������ loop Ż��
        exit when emp_cur%notfound;
        --�����迭 ������ ����̸��� �Է�
        names_arr(idx) := fname;
        --Ű�� ���� �ε����� ������Ų��.
        idx := idx+1;
    end Loop;
    close emp_cur;
    
    --�����迭. count : ���������� ����� ������ ������ ��ȯ�Ѵ�.
    for i in 1.. names_arr.count loop
        dbms_output.put_line(names_arr(i));
    end loop;
end;
/
/*
--����21] VArray(Variable Array)
    : �������̸� ���� �迭�ν� 
    �Ϲ� ���α׷��� ���� ����ϴ� �迭�� �����ϴ�.
     ũ�⿡ ������ �־ ������ �� ũ��(������ ����)�� �����ϸ�
    �̺��� ū �迭�� ���� �� ����.
    ����] 
        Type �迭Ÿ�Ը� IS
            array(�迭ũ��) of ���� Ÿ��;

*/
declare
    --Varray Ÿ�Լ���: ũ��� 5, ������ �����ʹ� ������
    type vaType is
        array(5) of varchar2(20);--ũ��5, ����Ÿ��
    v_arr vaType; --array ��������(add�� put���� �޼ҵ尡 ����)
    cnt number := 0;
begin
    --�����ڸ� ���� ���� �ʱ�ȭ. �� ���� 3���� �Ҵ�
    v_arr := vatype('First','second','third','','');
    --Basic �������� ���� �迭�� ���Ҹ� ����Ѵ�.(*�ε�����1���� �����Ѵ�.)
    loop
        cnt := cnt+1;
        --Ż�������� where��� if�� ����� ���� �ִ�.
        if cnt>5 then
            exit;
        end if; 
        -- �迭ó�� �ε����� ���� ����Ѵ�.
        dbms_output.put_line(v_arr(cnt));
    end loop;    
    --�迭�� ���� ���Ҵ�
    v_arr(3) := '�츮��';--��������
    v_arr(4) := 'JAVA';
    v_arr(5) := '�����ڴ�';
    
    -- for ���������� ����Ѵ�.
    for i in 1..5 loop
        dbms_output.put_line(v_arr(i));
    end loop;
end;
/

--����22]  VArray(Variable Array)
/*
�ó�����] 100�� �μ��� �ٹ��ϴ� ����� �����ȣ�� �����Ͽ� VArray�� ������ ��
    ����ϴ� PL/SQL�� �ۼ��Ͻÿ�.
*/
 select * from employees where department_id = 100;
 
 declare
    --VArray �ڷ��� ����. �迭�� ����� ���� ������̵�,�÷��� �����Ͽ� ����
    type vatype1 is
        array(6) of employees.employee_id%type;
    --�迭 ���� ���� �� �����ڸ� ���� �ʱ�ȭ�� �����Ѵ�.    
    va_one vatype1 := vatype1('','','','','','');
    cnt number :=1;
begin
    /*
    JAVA�� ������ for���� ����ϰ� 
    ������ ����� ������ŭ �ڵ����� �ݺ��ϴ� ���·� ���.
    select ���� employee_id�� ���� i�� �Ҵ�ǰ� �̸� ���� ������ �� �ִ�.
    */
    for i in (select employee_id from employees
        where department_id=100)
    loop
        va_one(cnt) := i.employee_id;
        cnt := cnt+1;
    end loop;
    
    --�迭�� ũ�⸸ŭ �ݺ��Ͽ� �� ���Ҹ� �����Ѵ�.
    for j in 1..va_one.count loop
        dbms_output.put_line(va_one(j));
    end loop;
end;
/
/*
3. ��ø ���̺�(Nested table)
    :Varray�� ����� ������ �迭�ν� �迭�� ũ�⸦ ������� �����Ƿ�
    �������� �迭�� ũ�Ⱑ �����ȴ�. ���⼭ ���ϴ� ���̺��� �ڷᰡ ����Ǵ�
    ���� ���̺��� �ƴ϶� �÷����� �� ������ �ǹ��Ѵ�.
    ����] type ��ø���̺� is
            table of ���� Ÿ��;
*/

--����23] ��ø���̺�(Nested Table) 
declare
    --��ø���̺��� �ڷ����� ������ �� ���� ����
    type nttype is
        table of varchar2(30);
    nt_array nttype;
begin
    --�����ڸ� ���� ���� �Ҵ��Ѵ�. �� �� ũ�� 4�� ��ø���̺��� �����ȴ�.
    nt_array :=nttype('ù��°','�ι�°','����°','');
    
    dbms_output.put_line(nt_array(1));
    dbms_output.put_line(nt_array(2));
    dbms_output.put_line(nt_array(3));
    nt_array(4) := '�׹�°���Ҵ�';
    dbms_output.put_line(nt_array(4));
    --�����߻�. ÷�ڰ� ������ �Ѿ����ϴ�.(�ڵ����� Ȯ����� �ʴ´�.)
    nt_array(5) := '�ټ���°��???�Ҵ�??';
    
    --ũ�⸦ Ȯ������ �� �����ڸ� ���� �迭�� ũ�⸦ �������� Ȯ���Ѵ�.
    --ũ�Ⱑ 7�� ��ø���̺�� Ȯ��ȴ�.
    nt_array := nttype('1a','2b','3c','4d','5e','6f','7g');
    
    for i in 1..7 loop
        dbms_output.put_line(nt_array(i));
    end loop;
end;
/

--����24] ��ø���̺�(Nested Table) 
/*
�ó�����] ��ø���̺�� for���� ���� 
    ������̺��� ��ü ���ڵ��� �����ȣ�� �̸��� ����Ͻÿ�.
*/
select employee_id, first_name from employees;

declare
    /*
    ��ø���̺��� �ڷ��� ���� �� �������� 
        -������̺� ��ü �÷��� �����ϴ� ���������� �����̹Ƿ�
        �ϳ��� ���ڵ带 ������ �� �ִ� ���·� ����ȴ�.
        
    */
    type nttype is
        table of employees%rowtype;
    nt_array nttype;
begin
    nt_array :=nttype();
        /*
        ������̺��� ���ڵ� �� ��ŭ �ݺ��ϸ鼭 ���ڵ带 �ϴϾ� ���� rec��
        �����Ѵ�. Ŀ��ó�� �����ϴ� for���� ���·� JAVa�� Ȯ�� for��ó��
        ����� �� �ִ�.
        */
    for rec in(select * from employees) loop
        --��ø���̺��� ���κ��� Ȯ���ϸ鼭 null�� �����Ѵ�.
        nt_array.extend;
        --������ �ε������� �������� �������ε������� �����Ѵ�.
        nt_array(nt_array.last) := rec;
    end loop;
    
    for i in nt_array.first..nt_array.last loop
    
        dbms_output.put_line(nt_array(i).employee_id||'>'
                            ||nt_array(i).first_name);
    end loop;
    dbms_output.put_line(nt_array.count||'���� ��');
end;
/

