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

--fk 지정하는 방법
alter table student add constraint class_fk FOREIGN key(cno) references class(cno);

------------------------------------------
-- 현재 수강 중인 모든 학생 명단
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
values(seq_sno.nextval, '차승원', '010-200-2000', '강남');
commit;
------------------------------------------
-- ANSI left outer join 
-- 수강신청한 18명 명단과 수강신청하지 않은 2명도 출력
-- 출력대상이 왼쪽에 있는 student row 정보 모두 출력이 됩니다.
-- 조인조건에 해당하지 않은 row 는 class 정보는 null로 표기된다.
select 
s.sno, s.name ,s.phone, c.cname, c.teacher
from student s left outer join class c
on c.cno=s.cno -- 18명, 2명은 null로
order by s.sno;
------------------------------------------
-- ANSI right outer join
-- 등가조건에 해당하는 명단은 다 출력 18명은 출력
-- 등가조건에 해당하지 않은 java, c언어도 출력, student 정보는 null로 표기
select 
s.sno, s.name ,s.phone, c.cname, c.teacher
from student s right outer join class c
on c.cno=s.cno 
order by s.sno;
------------------------------------------
-- ANSI full outer join
-- 등가조건에 해당하는 명단은 다 출력 18명은 출력
-- 등가조건에 해당하지 않은 java, c언어도 출력, student 정보는 null로 표기
-- 등가조건에 해당하지 않은 이광수, 차승원도 출력, class 정보는 null로 표기
select 
s.sno, s.name ,s.phone, c.cname, c.teacher
from student s full outer join class c
on c.cno=s.cno 
order by s.sno;
------------------------------------------
-- ORACLE left outer join 
-- 수강신청한 18명 명단과 수강신청하지 않은 2명도 출력
-- 출력대상이 왼쪽에 있는 student row 정보 모두 출력이 됩니다.
-- 조인조건에 해당하지 않은 row 는 class 정보는 null로 표기된다.
select 
s.sno, s.name ,s.phone, c.cname, c.teacher
from student s , class c
where s.cno = c.cno(+) -- (+): outer join 
order by s.sno;
------------------------------------------
-- ORACLE right outer join 
-- 등가조건에 해당하는 명단은 다 출력 18명은 출력
-- 등가조건에 해당하지 않은 java, c언어도 출력, student 정보는 null로 표기
select 
s.sno, s.name ,s.phone, c.cname, c.teacher
from student s , class c
where s.cno(+) = c.cno -- (+): outer join 
order by s.sno;
------------------------------------------
-- ORACLE full outer join 
-- 등가조건에 해당하는 명단은 다 출력 18명은 출력
-- 등가조건에 해당하지 않은 java, c언어도 출력, student 정보는 null로 표기
-- 조인조건에 해당하지 않은 row 는 class 정보는 null로 표기된다.
select 
s.sno, s.name ,s.phone, c.cname, c.teacher
from student s , class c
where s.cno = c.cno(+) -- left join
union -- full 조인 union 
select 
s.sno, s.name ,s.phone, c.cname, c.teacher
from student s , class c
where s.cno(+) = c.cno; -- right join

-------------------------------------
-- join 연습
-------------------------------------
-- 웹개발자 수강 중인 학생 명단 (학번, 이름, 수강과목, 강사)
select 
s.sno, s.name ,c.cname, c.teacher
from student s , class c
where s.cno = c.cno and c.cname='웹개발자';

-- 노원지역에 거주중인 학생명단(학번, 이름, addr, 수강과목, 강사)
select s.sno, s.name, s.addr, c.cname, c.teacher
from student s, class c
where s.cno = c.cno and s.addr='노원';

-- 웹개발자 수강인원 cno 1
select cno, count(*) 수강인원 
from student
where cno=1
group by cno;
---------------------------------
-- 일반조건문은 where 절에 기술, 그룹함수가 포함된 경우 having절 기술
-- where절에 그룹함수가 포함된 조건을 기술하면 에러발생
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

-- select 문에 나타나는 컬럼 수도 같아야 합니다
-- 각 컬럼의 데이터 타입이 일치 하여야합니다.
select sno, name, cname from student, class where student.cno = class.cno and cname = '웹개발자'
union
select sno, name, cname from student, class where student.cno = class.cno and cname='디자인'
order by cname;

select sno, name, addr from student where addr ='노원'
union
select sno, name, addr from student where addr ='강남'
order by addr
;





