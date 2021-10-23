create table class (
    cno number primary key, 
    cname varchar2(20) not null,
    room varchar2(20) not null,
    teacher varchar2(20) 
);

create table student(
    sno number primary key,
    name VARCHAR2(20) not null,
    phone varchar2(20) not null,
    addr varchar2(20),
    cno number
);

create SEQUENCE seq_sno increment by 1 start with 1;
create SEQUENCE seq_cno increment by 1 start with 1;

--fk �����ϴ� ���
alter table student add constraint class_fk FOREIGN key(cno) references class(cno);

------------------------------------------
-- ���� ���� ���� ��� �л� ���
-- oracle
select s.sno, s.name, c.cname, c.teacher
from student s, class c 
where s.cno = c.cno;
------------------------------------------
--ANSI
select s.sno, s.name, c.cname, c.teacher
from student s join class c 
on s.cno = c.cno;
-----------------------------------------
insert into student(sno, name, phone, addr)
values(seq_sno.nextval, '���¿�', '010-200-2000', '����');
commit;
------------------------------------------
-- ANSI left outer join 
-- ������û�� 18�� ��ܰ� ������û���� ���� 2�� ���
-- ��´���� ���ʿ� �ִ� student row ���� ��� ����� �˴ϴ�.
-- �������ǿ� �ش����� ���� row �� class ������ null�� ǥ��ȴ�.
select 
s.sno, s.name ,s.phone, c.cname, c.teacher
from student s left outer join class c
on c.cno=s.cno -- 18��, 2���� null��
order by s.sno;
------------------------------------------
-- ANSI right outer join
-- ����ǿ� �ش��ϴ� ����� �� ��� 18���� ���
-- ����ǿ� �ش����� ���� java, c�� ���, student ������ null�� ǥ��
select 
s.sno, s.name ,s.phone, c.cname, c.teacher
from student s right outer join class c
on c.cno=s.cno 
order by s.sno;
------------------------------------------
-- ANSI full outer join
-- ����ǿ� �ش��ϴ� ����� �� ��� 18���� ���
-- ����ǿ� �ش����� ���� java, c�� ���, student ������ null�� ǥ��
-- ����ǿ� �ش����� ���� �̱���, ���¿��� ���, class ������ null�� ǥ��
select 
s.sno, s.name ,s.phone, c.cname, c.teacher
from student s full outer join class c
on c.cno=s.cno 
order by s.sno;
------------------------------------------
-- ORACLE left outer join 
-- ������û�� 18�� ��ܰ� ������û���� ���� 2�� ���
-- ��´���� ���ʿ� �ִ� student row ���� ��� ����� �˴ϴ�.
-- �������ǿ� �ش����� ���� row �� class ������ null�� ǥ��ȴ�.
select 
s.sno, s.name ,s.phone, c.cname, c.teacher
from student s , class c
where s.cno = c.cno(+) -- (+): outer join 
order by s.sno;
------------------------------------------
-- ORACLE right outer join 
-- ����ǿ� �ش��ϴ� ����� �� ��� 18���� ���
-- ����ǿ� �ش����� ���� java, c�� ���, student ������ null�� ǥ��
select 
s.sno, s.name ,s.phone, c.cname, c.teacher
from student s , class c
where s.cno(+) = c.cno -- (+): outer join 
order by s.sno;
------------------------------------------
-- ORACLE full outer join 
-- ����ǿ� �ش��ϴ� ����� �� ��� 18���� ���
-- ����ǿ� �ش����� ���� java, c�� ���, student ������ null�� ǥ��
-- �������ǿ� �ش����� ���� row �� class ������ null�� ǥ��ȴ�.
select 
s.sno, s.name ,s.phone, c.cname, c.teacher
from student s , class c
where s.cno = c.cno(+) -- left join
union -- full ���� union 
select 
s.sno, s.name ,s.phone, c.cname, c.teacher
from student s , class c
where s.cno(+) = c.cno; -- right join

-------------------------------------
-- join ����
-------------------------------------
-- �������� ���� ���� �л� ��� (�й�, �̸�, ��������, ����)
select 
s.sno, s.name ,c.cname, c.teacher
from student s , class c
where s.cno = c.cno and c.cname='��������';

-- ��������� �������� �л����(�й�, �̸�, addr, ��������, ����)
select s.sno, s.name, s.addr, c.cname, c.teacher
from student s, class c
where s.cno = c.cno and s.addr='���';

-- �������� �����ο� cno 1
select cno, count(*) �����ο� 
from student
where cno=1
group by cno;
---------------------------------
-- �Ϲ����ǹ��� where ���� ���, �׷��Լ��� ���Ե� ��� having�� ���
-- where���� �׷��Լ��� ���Ե� ������ ����ϸ� �����߻�
select cno, count(cno)
from student
group by cno
having count(cno) !=0
order by cno;

select cno, count(cno)
from student
group by cno
having cno is not null
order by cno;

-- select ���� ��Ÿ���� �÷� ���� ���ƾ� �մϴ�
-- �� �÷��� ������ Ÿ���� ��ġ �Ͽ����մϴ�.
select sno, name, cname from student, class where student.cno = class.cno and cname = '��������'
union
select sno, name, cname from student, class where student.cno = class.cno and cname='������'
order by cname;

select sno, name, addr from student where addr ='���'
union
select sno, name, addr from student where addr ='����'
order by addr
;





