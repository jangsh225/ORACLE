select 
e.emp_id, e.name, d.dept_name
from emp e, dept d
where e.dept_id = d.dept_id;
--- ANSI 문법으로 query를 작성하세요 5점
select 
e.emp_id, e.name, d.dept_name
from emp e join dept d
on e.dept_id = d.dept_id;
-------------------------------------
--EMP, DEPT 2개의 VIEW를 JOIN하여 
--NAME에 ‘King’이 포함된 사람의 
--NAME, DEPT_NAME을 출력하세요
select 
e.name, d.dept_name
from emp e, dept d
where e.dept_id = d.dept_id and e.name like '%King%';
-------------------------------------
--EMP, DEPT, LOC 3개의 VIEW를 JOIN하여 
--EMP_ID, NAME, DEPT_NAME, CITY를 출력하세요. 
--정렬요소는 오름차순 EMP_ID입니다.
select 
e.emp_id, e.name, d.dept_name, l.city
from emp e, dept d, loc l
where e.dept_id = d.dept_id and d.loc_id = l.loc_id
order by e.emp_id;
-------------------------------------
--EMP, DEPT 개의 VIEW를 JOIN하여
--EMP_ID, NAME, DEPT_NAME을 출력하세요. 
--단. 부서명이 아직 없는 직원의 명단도 같이 출력하세요
--- Oracle 문법으로 query를 작성하세요 5점
select 
e.emp_id, e.name, d.dept_name
from emp e, dept d
where e.dept_id = d.dept_id(+);
--- ANSI 문법으로 query를 작성하세요 5점
select 
e.emp_id, e.name, d.dept_name
from emp e left outer join dept d
on e.dept_id = d.dept_id;
-------------------------------------
--EMP, DEPT 개의 VIEW를 JOIN하여
--EMP_ID, NAME, DEPT_NAME을 출력하세요. 
--단. 아직 직원이 없는 부서이름도 출력하세요
--- Oracle 문법으로 query를 작성하세요 5점
select 
e.emp_id, e.name, d.dept_id
from emp e, dept d
where e.dept_id(+) = d.dept_id;
--- ANSI 문법으로 query를 작성하세요 5점
select 
e.emp_id, e.name, d.dept_id
from emp e right outer join dept d
on e.dept_id = d.dept_id;
-------------------------------------
--EMP VIEW 에서 전체 급여의 평균 보다 많은 급여를 받는 직원 명단의
--EMP_ID, NAME, SAL을 출력하세요
select emp_id, name, sal
from emp
where sal > (select avg(sal) from emp);
-------------------------------------
--EMP VIEW 에서 전체직원 중에서 100번 부서의 직원중 급여를 가장적게 받는 사원 보다
--더 많은 급여를 받는 직원명단의
--EMP_ID, NAME, SAL 를 출력하세요
select emp_id, name, sal
from emp
where sal > any(select sal from emp where dept_id = 100);
-------------------------------------
--EMP 에서 부서별로 제일 많이 받는 급여자의 
--EMP_ID, NAME, SAL 를 출력하세요
select emp_id, name, sal from emp a
where sal = (select max(sal) from emp b where a.dept_id = b.dept_id); 

select emp_id, name, sal
from emp
where (dept_id, sal) in (select dept_id, max(sal) from emp group by dept_id); 
----------------------------------------------------
--EMP VIEW 에서 최근 입사일기준 10번째~20번째 사원의 명단을 출력하세요
--단, ruwnum을 활용하여 작성해주세요
select * from 
(select rownum rnum, e.* 
    from (select * from emp order by hire_date desc)e)
where rnum between 10 and 20;
-------------------------------------------------------
--EMP, DEPT VIEW에서 
--DEPT_NAME이 'IT‘ 와 'Sales' 인 사원의 
--EMP_ID, NAME, DEPT_NAME 을출력하세요 
--단, union을 적용하여 주세요.
select e.emp_id, e.name, d.dept_name
from emp e, dept d
where e.dept_id = d.dept_id and d.dept_name = 'IT'
union
select e.emp_id, e.name, d.dept_name
from emp e, dept d
where e.dept_id = d.dept_id and d.dept_name = 'Sales';
