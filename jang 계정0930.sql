alter table board rename column bno to no;

insert into board(no, subject, content, writer, created_date)
values (2, '����2', '����2', 'guest2', sysdate);

select * from board;

insert into board --�÷��� �������� ������ ���� �÷� ������ �־�� �Ѵ�.
values (3, '����3', '����3', 'guest3', sysdate);

insert into board 
values (4, '����2', '����2', 'guest2');

insert into board(no, subject, content, writer, created_date)
values (5, '����5', '����5', 'guest5', sysdate);

delete from board; -- ���̺� ���� ��� �����Ͱ� ����

insert into board(no, subject, content, writer, created_date)
values (SEQ_BOARD.nextval,'����3','����3','�ۼ���3',sysdate);
select * from board;
select seq_board.currval from dual;

select seq_board.nextval from dual;

commit;



