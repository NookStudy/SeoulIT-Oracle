/******************************************************************************
���ϸ�: Or14Sequence&Index.sql
������ & �ε���
����: ���̺��� �⺻Ű �ʵ忡 �������� �Ϸù�ȣ�� �ο��ϴ� ��������
    �˻��ӵ��� ����ų �� �ִ� �ε���
*******************************************************************************/
--study �������� �����մϴ�.

/*
������
    - ���̺��� �÷�(�ʵ�)�� �ߺ����� �ʴ� �������� �Ϸù�ȣ�� �ο��Ѵ�.
    - �������� ���̺� ���� �� ������ ������ �Ѵ�.
        ��, �������� ���̺�� ���������� ����ǰ� �����ȴ�.
        
[������ ��������]
create sequence ��������
    [increment by N] -> ����ġ ����
    [Start with N] -> ���۰� ����
    [Minvalue n | NoMinvalue] -> ������ �ּҰ� ���� : ����Ʈ1
    [Maxvalue n | NoMaxvalue] -> ������ �ִ밪 ���� : ����Ʈ1.0000E+28
    [Cycle | No Cycle] 
        ->   �ִ� �ּҰ��� ������ ��� ó������ �ٽ� �������� ���θ� ����
                 (Cycle�� �����ϸ� �ִ밪���� ������ �ٽ� ���۰����� ����۵�)
    [Cache | NoCache] 
        -> cache�޸𸮿� ����Ŭ ������ ���������� �Ҵ��ϴ� ���θ� ����        

���ǻ���
    1. start with �� minvalue���� �������� ������ �� ����. �� start with ����
      minvalue�� ���ų� Ŀ���Ѵ�.
    2. nocycle�� �����ϰ� �������� ��� ���� �� maxvalue�� �������� �ʰ��ϸ�
        ������ �߻��Ѵ�.
    3. primary key�� cycle�ɼ��� ���� �����ϸ� �ȵȴ�.    
*/
drop table tb_goods;
drop sequence seq_serial_num;
create table tb_goods(
    g_idx number(10) primary key,
    g_namej varchar2(30)
);    
alter table tb_goods rename column g_namej to g_name;

insert into tb_goods values (1,'gana chocolate');
insert into tb_goods values (1,'saewoo GGang');--�Է½���(������������)

--������ ����
create sequence seq_serial_num
    increment by 1      --����ġ1
    start with 100  --�ʱⰪ : 100
    MINVALUE    99  --�ּҰ� : 99
    MAXVALUE    110 --�ִ밪 : 110
    cycle           -- �ִ밪 ���޽� ���۰����� ��������� ����: YES
    nocache;        -- ĳ�ø޸� ��� ���� :no
--������ �������� ������ ������ Ȯ���ϱ�    
select * from user_sequences;

/*
������ ���� �� ���ʽ���� ������ �߻��մϴ�.
nextval�� ���� ������ �� �����ؾ� �������� ��µȴ�.
*/
select seq_serial_num.currval from dual;
--����
select seq_serial_num.nextval from dual;
/*
���� �Է��� �������� ��ȯ�Ѵ�. �����Ҷ����� �������� �Ѿ��.
*/

insert into tb_goods values(seq_serial_num.nextval,'�ܲʹ��1');
insert into tb_goods values(seq_serial_num.nextval,'�ܲʹ��2');
insert into tb_goods values(seq_serial_num.nextval,'�ܲʹ��3');
insert into tb_goods values(seq_serial_num.nextval,'�ܲʹ��4');
insert into tb_goods values(seq_serial_num.nextval,'�ܲʹ��5');
insert into tb_goods values(seq_serial_num.nextval,'�ܲʹ��6');
insert into tb_goods values(seq_serial_num.nextval,'�ܲʹ��7');
insert into tb_goods values(seq_serial_num.nextval,'�ܲʹ��8');
insert into tb_goods values(seq_serial_num.nextval,'�ܲʹ��9');
insert into tb_goods values(seq_serial_num.nextval,'�ܲʹ��10');
insert into tb_goods values(seq_serial_num.nextval,'�ܲʹ��11');
insert into tb_goods values(seq_serial_num.nextval,'�ܲʹ��12');
/*
    �������� cycle �ɼǿ� ���� �ִ밪�� �����ϸ� �ٽ� ó������ 
    �Ϸù�ȣ�� �����ǹǷ� ���Ἲ �������ǿ� ����ȴ�.
      ��, �⺻Ű�� ����� �������� cycle�ɼ��� ����ϸ� �ȵȴ�.
*/
insert into tb_goods values(seq_serial_num.nextval,'�ܲʹ��13');
--���Ἲ���� �������ǿ� �ɷ�����! 101������ ������~

--delete tb_goods;
select * from tb_goods;

select seq_serial_num.currval from dual;
--���� �������� ��ȯ
/*
������ ���� 
    : start with �� �������� �ʽ��ϴ�.(�ʱⰪ �����Ұ�)
**/
alter sequence seq_serial_num
    increment by 10 
    MINVALUE    1  
    noMAXVALUE     
    nocycle 
    nocache; 
--���� �� ������ �������� Ȯ���Ѵ�.    
select * from user_sequences;
--����ġ�� 10���� ����Ȱ��� Ȯ���Ѵ�.
select seq_serial_num.nextval from dual;

drop sequence seq_serial_num;
select * from user_sequences;--nothing~

---�Ϲ����� ������ ������ �Ʒ��� ���� �ϸ�ȴ�.
create sequence seq_serial_num
    start with 100
    increment by 1     
    MINVALUE    1  
    noMAXVALUE     
    nocycle          
    nocache;
--���� �Ϲ����� ������

/*
�ε���(index)
    -���� �˻��ӵ��� ����ų �� �ִ� ��ü
    - �ε����� �����(create index) Ȥ�� �ڵ���(primary key,unique)
    ���� ������ �� �ִ�.
    -�÷��� ���� �ε����� ������ ���̺� ��ü�� �˻��ϰ� �ȴ�.
    -��, �ε����� ������ ������ ����Ű�� ���� �����̴�.
    -�ε����� �Ʒ��� ���� ��쿡 �����Ѵ�.
        1.where �����̳� join ���ǿ� ���� ����ϴ� �÷�
        2. �������� ���� �����ϴ� �÷�
        3. ���� null���� �����ϴ� �÷�
**/
desc tb_goods;
select * from tb_goods;
delete from tb_goods where g_idx =1;

--�ε��� �����ϱ�. Ư�� ���̺��� �÷��� �����Ͽ� �����Ѵ�.
create index tb_goods_name_idx on tb_goods(g_name);
--������ �ε��� Ȯ���ϱ�
/*
    ������ �������� Ȯ���ϸ� 
    PK Ȥ�� unique�� ������ �÷��� �ڵ����� index�� �����ǹǷ� 
    �̹� ������ �ε����� ���� Ȯ�εȴ�.
**/
select * from user_ind_columns;

/**
Ư�� ���̺��� �ε��� Ȯ��
    : �����ͻ����� ��Ͻ� �빮�ڷ� �ԷµǹǷ� upper()�� ���� ��ȯ�Լ��� ���
     Ȥ�� ��� Capital�� �Է�.
*/
select *from user_ind_columns where table_name = 'TB_GOODS';
select * from user_constraints where table_name = 'TB_PRIMARY5';

--������ ���� ���ڵ尡 �ִٰ� �������� �� �˻��ӵ��� ����� �ִ�.
select * from tb_goods where g_name like '%��%';

--�ε��� ����
drop index tb_goods_name_idx;
--�ε��� ���� : ������ �Ұ��� �ϴ�. ���� �� �ٽ� �����ؾ� �Ѵ�.