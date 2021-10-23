alter table board rename column bno to no;

insert into board(no, subject, content, writer, created_date)
values (2, '제목2', '내용2', 'guest2', sysdate);

select * from board;

insert into board --컬럼명 생략가능 무조건 값을 컬럼 순으로 넣어야 한다.
values (3, '제목3', '내용3', 'guest3', sysdate);

insert into board 
values (4, '제목2', '내용2', 'guest2');

insert into board(no, subject, content, writer, created_date)
values (5, '제목5', '내용5', 'guest5', sysdate);

delete from board; -- 테이블 안의 모든 데이터가 삭제

insert into board(no, subject, content, writer, created_date)
values (SEQ_BOARD.nextval,'제목3','내용3','작성자3',sysdate);
select * from board;
select seq_board.currval from dual;

select seq_board.nextval from dual;

commit;



