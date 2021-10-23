create table board_test(
bno number primary key,
subject varchar2(20) not null,
content varchar2(20char) not null,
writer varchar2(20) default 'guest',
read_count number CHECK (read_count >= 0) 
);
--subject -> title
alter table board_test rename column 
subject to title;
-- column(�Ӽ�) �߰�
alter table board_test add read_count number default 0;
alter table board_test add created_date varchar2(20) not null;
alter table board_test modify created_date timestamp;
alter table board_test modify content varchar2(10 char);

desc board_test;

insert into board_test
values(seq_bno.nextval, '�����ٶ󸶹�', '�����ٶ󸶹ٻ������', '�ۼ���', 0, sysdate);

select * from board_test;

truncate table board_test;

drop table board_test;
--�ý��� ����
select * from dba_sys_privs where grantee = 'DBTEST';
select * from dba_sys_privs where grantee = 'CONNECT';

--������� ROLE Ȯ��
select * from dba_role_privs where grantee = 'DBTEST';