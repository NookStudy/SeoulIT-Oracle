/******************************************************************************
���ϸ�: Or13Constraint.sql
��������
����: ���̺� ������ �ʿ��� �������� �������ǿ� ���� �н��Ѵ�.
*******************************************************************************/
---study����
/***
primary key : �⺻Ű
    - ���� ���Ἲ�� �����ϱ� ���� ��������
    - �ϳ��� ���̺� �ϳ��� �⺻Ű�� ������ �� �ִ�.    
    - �⺻Ű�� ������ �÷��� �ߺ��� ���̳� Null���� �Է��� �� ����.
    - �ַ� ���ڵ� �ϳ��� Ư���ϱ� ���� ���ȴ�.
**/
/*
����1] �ζ��� ��� : �÷� ������ ������ ���������� ����Ѵ�.
    create table ���̺��(
        �÷��� �ڷ���(ũ��) [constraint �����] priamry key
        );
    *[]���ȣ �κ��� ���� �����ϰ�, ������ ������� �ý����� �ڵ����� �ο�.
*/
create table tb_primary1(
    idx number(10) primary key,
    user_id varchar2(30),
    user_name varchar2(50)
    );
desc tb_primary1

/*
���� ���� �� ���̺� ��� Ȯ���ϱ�
tab: ���� ������ ������ ���̺��� ����� Ȯ���� �� �ִ�.
user_cons_columns : ���̺� ������ �������ǰ� �÷����� ������ ������ �����Ѵ�.
user_constraints : ���̺� ������ ���������� ���� ���� ������ �����Ѵ�.
* �̿Ͱ��� ���� �����̳� ��, ���ν������� ������ �����ϰ� �ִ�
    �ý��� ���̺��� "������ ����" �̶�� �Ѵ�.
*/
select * from tab;
select * from user_cons_columns; 
select * from user_constraints;

--���ڵ� �Է�
insert into tb_primary1 (idx,user_id,user_name)
values(1,'hapjeong1','����');
insert into tb_primary1 (idx,user_id,user_name)
values(2,'seoulit','�п�');
insert into tb_primary1 (idx,user_id,user_name)
values(2,'seoulit','�����߻�');
--primary key�� idx�� �ߺ��Ǿ� ����
/*
���Ἲ �������� ����� ������ �߻��Ѵ�.
PK(primary key)�� ������ �÷� idx���� �ߺ����� �Էµ� �� ����.
*/
insert into tb_primary1 (idx,user_id,user_name)
values(3,'white','ȭ��Ʈ');
insert into tb_primary1 (idx,user_id,user_name)
values('','black','��');
--pk�� ������ �÷����� null���� �Է��� �� ����.
select * from tb_primary1;

update tb_primary1 set idx=2 where user_name='ȭ��Ʈ';
/*
update���� ���������� idx���� �̹� �����ϴ� 2�� ���������Ƿ�
���� ���� ����� ������ �߻��Ѵ�.
*/
/*
����2] �ƿ����� ���
    create table ���̺��(
    �÷��� �ڷ���(ũ��) [constraint �����] primary key (�÷���)
    );
*/
create table tb_primary2(
    idx number(10), 
    user_id varchar2(30),
    user_name varchar2(50),
    constraint my_pk1 primary key(user_id)
    );
desc tb_primary2;

select * from user_cons_columns; 
select * from user_constraints;

insert into tb_primary2 values(1,'white','ȭ��Ʈ');
update tb_primary2 set user_name ='ȭ��Ʈ1' where idx=1;
select * from tb_primary2;
insert into tb_primary2 values(2,'white','ȭ��Ʈ2');

/*
����3] ���̺��� ������ �� altert������ �������� �߰�
alter table ���̺� �� add constraint ����� primary key (�÷�);
*/
create table tb_primary3(
    idx number(10), 
    user_id varchar2(30),
    user_name varchar2(50)
    );
desc tb_primary3;    
/*
���̺��� ������ �� alter����� ���� ���������� �ο��� �� �ִ�.
������� ��� ������ �����ϴ�.
*/
alter table tb_primary3 add constraint tb_primary3_pk primary key (user_name); 
--������ �������� �������� Ȯ���ϱ�
select * from user_cons_columns; 
select * from user_constraints;
--���������� ���̺��� ������� �ϹǷ� ���̺��� �����Ǹ� ���� �����ȴ�.
drop table tb_primary3;
--Ȯ�ν� �����뿡 ���°��� Ȯ���� �� �ִ�.
select * from user_cons_columns; 
purge recyclebin;

--PK�� ���̺�� �ϳ��� ������ �� �ִ�. ���� �ش� ������ ������ �߻��Ѵ�.
create table tb_primary4(
idx number(10) primary key, 
    user_id varchar2(30) primary key,
    user_name varchar2(50)
    );
/*
unique : ����ũ
    - ���� �ߺ��� ������� �ʴ� ������������ 
    - ����, ���ڴ� �ߺ��� ������� �ʴ´�.
    -��, null���� ���ؼ��� �ߺ��� ����Ѵ�.
    -unique�� ���밹�� ������ ����.
*/
create table tb_unique(
    idx number(10) unique not null, 
    name varchar2(30),
    telephone varchar2(20),
    nickname varchar2(30),
    unique(telephone,nickname)
    );
    /**
        2�� �̻��� �÷��� ���ļ� �����Ѵ�. �� ��� ������ ������������ 
        unique�� �����ȴ�.
    **/
--���ڵ� �Է�    
desc tb_unique;
insert into tb_unique (idx,name,telephone,nickname) 
    values(1  ,'���̸�','010-1111-1111','���座��');
insert into tb_unique (idx,name,telephone,nickname) 
    values(2,'����','010-2222-2222','');
insert into tb_unique (idx,name,telephone,nickname) 
    values(3,'����','010-3332-2222',''); 
--unique�� �ߺ��� ������� �ʴ� �������������� ,null�� ������ �Է��� �� �ִ�.    
update tb_unique set telephone='' where idx=3;    
select * from tb_unique;  

insert into tb_unique (idx,name,telephone,nickname) 
    values(1,'����','010-3333-3333','');
--idx�� �ߺ��� ���� �ԷµǹǷ� ������ �߻��Ѵ�.    
insert into tb_unique values(4,'���켺','010-4444-4444','��ȭ���');
insert into tb_unique values(5,'������','010-5555-5555','��ȭ���');
insert into tb_unique values(6,'Ȳ����','010-4444-4444','��ȭ���');
insert into tb_unique values(7     ,'Ȳ����','010-7666-6666','��ȭ���');
--not null�̹Ƿ� idx���� ������ ������� �ʴ´�.
/*
telephone�� nickname�� ������ ��������� �����Ǿ����Ƿ� �ΰ��� �÷��� 
���ÿ� ������ ���� ������ ��찡 �ƴ϶�� �ߺ��� ���� ���ȴ�.
�� 4���� 5���� ���δٸ� �����ͷ� �ν��ϹǷ� �Էµǰ�, 4���� 6����
    ������ �����ͷ� �ν��Ͽ� �ԷºҰ�
*/
delete from tb_unique where idx=7;
delete from tb_unique where nickname='��ȭ���';

select *from tb_unique;
select * from user_cons_columns;


/*
Foreign Key : �ܷ�Ű,����Ű
    - �ܷ�Ű�� ���� ���Ἲ�� �����ϱ� ���� ���� ��������
        ���� ���̺��� �ܷ�Ű�� �����Ǿ� �ִٸ� �ڽ����̺� ��������
        �����Ұ�� �θ����̺��� ���ڵ�� ������ �� ����.
        
    ����1]  �ζ��ι��
    create table ���̺��(
        �÷��� �ڷ��� [constraint �����]
         references �θ����̺��(������ �÷���)
         );
*/
create table tb_foreign1 (
    f_idx number(10) primary key,
    f_name varchar2(50),
    /*
    �ڽ� ���̺��� tb_foreign1���� �θ����̺��� tb_primary2�� �������̵��÷���
    �����ϴ� ���̺��� �����Ѵ�.
    */
    f_id varchar2(30) constraint tn_foreign_fk1
        references tb_primary2(user_id)
    );
alter table tb_foreign1 rename constraint tn_foreign_fk1 to tb_foreign_fk1;
desc tb_foreign1;
select * from user_cons_columns;
--�ڽ����̺��� ���ڵ尡 ���� ����
select *from tb_foreign1;

insert into tb_foreign1 values(1,'ȫ�浿','gildong');
--�θ� ���̺� user_id ='ȫ�浿' �����Ƿ� ����
insert into tb_foreign1 values(2,'ȭ��Ʈ','white');
--�θ� ���̺� 'ȭ��Ʈ' �����ϱ�~
/**
    �ڽ����̺��� �����ϴ� ���ڵ尡 �����Ƿ�, 
        �θ����̺��� ���ڵ带 �����Ҽ� ����.
    �� ���, �ݵ�� �ڽ� ���̺��� ���ڵ� ���� ������ �� �θ����̺��� ���ڵ带
    �����ؾ� �Ѵ�.
**/
select * from tb_primary2;
update tb_primary2 set user_id = 'ȭ��' where idx=1;
--�ڽķ��ڵ尡 �������� ����� Ű ���� �Ұ�.


delete from tb_primary2 where user_id='white';
--�ڽ��� �־ ������
delete from tb_foreign1 where f_id='white';
delete from tb_primary2 where user_id='white';
--�ڽĸ��� �����ؾ� �Ѵ�.
--��� ���ڵ� ���� �Ϸ�
select * from tb_primary2;
select * from tb_foreign1;

/*
    2���� ���̺��� �ܷ�Ű(������)�� �����Ǿ� �ִ� ���
    �θ����̺��� ������ ���ڵ尡 ������ �ڽ����̺� insert �� �� ����.
    �ڽ����̺��� �θ� �����ϴ� ���ڵ尡 �������� 
        �θ����̺��� ���ڵ带 delete�� �� ����.
    �θ� �־�� �ڽĻ���. �ڽ��� ����� �θ���� (stack����?)   
**/
/*-
����2] �ƿ����� ���
    create table ���̺��(
    �÷��� �ڷ���,
    [constraint �����] foreign key(�÷���)
        references �θ����̺�(������ �÷�)
    );
**/
create table tb_foreign2(
    f_id number primary key,
    f_name varchar2(30),
    f_date date,
    foreign key(f_id) references tb_primary1 (idx)
    );
select * from tb_primary1;    
select* from user_cons_columns;    
/*
������ �������� �������� Ȯ�̽��� �÷���
P primary key
R reference integrity �� foreign key
C check Ȥ�� not null
U unique

**/

/*
����3] ���̺� ���� �� alter������ �ܷ�Ű �������� �߰�
    alter table ���̺�� add constraint �����  
            foreign key (�÷���) references(�÷���)
*/
create table tb_foreign3(
    idx number primary key,
    f_name varchar2(30),
    f_idx number(10)
    );
    
alter table tb_foreign3 add foreign key (f_idx) references tb_primary1 (idx);     
desc tb_foreign3;
select * from user_cons_columns;

/*
    �ϳ��� �θ����̺� �� �̻��� �ڽ����̺��� �ܷ�Ű ���� ����
**/

/**
�ܷ�Ű �����ɼ�
[on delete cascade]
    : �θ� ���ڵ� ������ �ڽķ��ڵ���� ���� �����ȴ�.
    ����]
        �÷��� �ڷ��� references �θ����̺�(pk�÷�)
            on deleted cascade;
[on delete set null]    
    : �θ� ���ڵ� ������ �ڽķ��ڵ尪�� null�� ����
    ����]
        �÷��� �ڷ��� references �θ����̺�(pk�÷�)
            on delete set null
*�ǹ����� ���԰Խù��� ���� ȸ���� �� �Խñ��� �ϰ������λ����ؾ��� ��
����� �� �ִ� �ɼ��̴�. ��, �ڽ����̺��� ��� ���ڵ尡 �����ǹǷ� ��뿡 ����.
*/

create table tb_primary4(
    user_id varchar2(30) primary key,
    user_name varchar2(100)
    );
select * from tab;
create table tb_foreign4(
    f_idx number(10) primary key,
    f_name varchar2(30),
    user_id varchar2(30) constraint tb_foreign4_fk
        references tb_primary4 (user_id)
            on delete cascade
    );
/*
    �ܷ�Ű�� ������ ��� �ݵ�� �θ����̺� ���ڵ带 ���� �Է��� ��
    �ڽ� ���̺� �Է��ؾ��Ѵ�.
*/
insert into tb_primary4 values ( 'student','�Ʒû�1');
insert into tb_foreign4 values (1,'����1�Դϴ�.','student');
insert into tb_foreign4 values (2,'����2�Դϴ�.','student');
insert into tb_foreign4 values (3,'����3�Դϴ�.','student');
insert into tb_foreign4 values (4,'����4�Դϴ�.','student');
insert into tb_foreign4 values (5,'����5�Դϴ�.','student');
insert into tb_foreign4 values (6,'����6�Դϴ�.','student');
insert into tb_foreign4 values (7,'����7�Դϴ�.','student');

insert into tb_foreign4 values (8,'��??����??','teacher');
--�θ�Ű�� �����Ƿ� ���ڵ带 ������ �� ����.!
select* from Tb_foreign4;
select* from Tb_primary4;

select * from tab;

/*
   �θ� ���̺��� ���ڵ带 ���� �� ��� on delete cascade �ɼǿ� ����
    �ڽ��ʱ��� ��� ���ڵ尡 �����ȴ�. ���� �ش�ɼ��� �������� ���·� 
    �ܷ�Ű�� �����ߴٸ� ���ڵ�� �������� �ʰ� ������ �߻���.
*/    
delete from tb_primary4 where user_id='student';
--�θ�,�ڽ����̺��� ��� ���ڵ尡 �����ȴ�.

---------------------------------------------------
create table tb_primary5(
    user_id varchar2(30) primary key,
    user_name varchar2(100)
    );
create table tb_foreign5(
    f_idx number(10) primary key,
    f_name varchar2(30),
    user_id varchar2(30) constraint tb_foreign5_fk
        references tb_primary5 (user_id)
            on delete set null
    );
insert into tb_primary5 values ( 'student','�Ʒû�1');
insert into tb_foreign5 values (1,'����1�Դϴ�.','student');
insert into tb_foreign5 values (2,'����2�Դϴ�.','student');
insert into tb_foreign5 values (3,'����3�Դϴ�.','student');
insert into tb_foreign5 values (4,'����4�Դϴ�.','student');
insert into tb_foreign5 values (5,'����5�Դϴ�.','student');
insert into tb_foreign5 values (6,'����6�Դϴ�.','student');
insert into tb_foreign5 values (7,'����7�Դϴ�.','student');    
select * from tb_primary5;
select * from tb_foreign5;
/*
 on delete set null �ɼ����� �ڽ����̺��� ���ڵ�� �������� �ʰ�,
 ����Ű �κи� null������ ���ߵȴ�. ���� �� �̻� ������ �� ���� ���ڵ�� 
 �����Ѵ�.
**/
delete from tb_primary5 where user_id='student';
select * from tb_primary5;
--�θ� ���̺��� ���ڵ�� ����
select * from tb_foreign5;
--�ڽ� ���̺��� ���ڵ�� �����ִ�. but �����÷��� null�� ����ȴ�.
/*
not null :  null���� ������� �ʴ� ��������
    ����]
        create table ���̺��(
            �÷��� �ڷ��� not null,
            �÷��� �ڷ��� null <- null �� ����Ѵٴ� �ǹ̷� �ۼ�������
                                �̷��� ������� �ʴ´�. null�� �������
                                ������ �ڵ����� ����Ѵٴ� �ǹ̰� �ȴ�.
            );                    

**/
create table tb_not_null(
    m_idx number(10) primary key,  --pk�̹Ƿ� not null
    m_id varchar2(20) not null, --not null
    m_pw varchar2(30) null, --null ��� (�Ϲ������� �̷��� ������)
    m_name varchar2(40) --null ���(�̿Ͱ��� ���)
    );
desc tb_not_null;

insert into tb_not_null values (10,'hong1','1111','ȫ�浿');
insert into tb_not_null values (20,'hong2','2222','');
insert into tb_not_null values (30,'hong3','','');
--m.id�� nn���� �����Ǿ����Ƿ� null���� ������ �� ���� ������ �߻��Ѵ�.
insert into tb_not_null values (40,'','','');

insert into tb_not_null values (50,'   ','5555','���浿');
--�Է¼��� space�� �����̹Ƿ� �Էµȴ�.
insert into tb_not_null (m_id,m_pw,m_name) values ('hong6','6666','���浿');
--�����߻�. pk���� null���� �Է��� �� ����. 
--  �÷��� ������� ������ null�� �Էµȴ�.

select *from tb_not_null;
/*
default : insert �� �ƹ��� ���� �Է����� �ʾ��� �� �ڵ����� ���ԵǴ� 
�����͸� ������ �� �ִ�.
*/
create table tb_default(
    id varchar2(30) not null,
    pw varchar2(50) default 'gwer'
    );
insert into tb_default values ('aaaa','1234');
insert into tb_default values ('bbbb');--�÷� ��ü�� �Է����� �ʾ� �ԷºҰ�
insert into tb_default values ('cccc','');
insert into tb_default values ('dddd',' ');--space(����) �Էµ�.
insert into tb_default values ('eeee',default); --default�� �Է�

select *from tb_default;
/*
    default ���� �Է��Ϸ��� insert������ �÷���ü�� ���ܽ�Ű�ų� 
    default Ű���带 ����ؾ� �Ѵ�.
    */
    select *from tb_default;
/*
check : domain(�ڷ���) ���Ἲ�� �����ϱ� ���� ������������ 
    �ش� �÷��� �߸��� �����Ͱ� �Էµ��� �ʵ��� �����ϴ� ���������̴�.
    */
--M,F(male,female)�� �Է��� ����ϴ� check ��������    
create table tb_check1(
    gender char(1) not null
            constraint check_gender
            check (gender in ('M','F'))
    );
insert into tb_check1 values('M');    
insert into tb_check1 values('F');    
--check �������� ����� �����߻�
insert into tb_check1 values('T');    
--�Էµ� �����Ͱ� �÷����Ǻ��� ũ�Ƿ� ���� �߻�
insert into tb_check1 values('����');    

--10������ ���� �Է��� �� �ִ� check �������� ����
create table tb_check2(
    sale_count number not null
    check(sale_count <=10)
);
alter table tb_check2 modify sale_count number check(sale_count<=10);
insert into tb_check2 values(9);    
insert into tb_check2 values(10);    
insert into tb_check2 values(11);    
--�������� ����� �Է½���
desc tb_check2;
select * from user_constraints where table_name = 'TB_CHECK2';
alter table tb_CHECK2
drop constraint SYS_C008426;

