select * from emp;
-- emp_id 가 202인 사원의 입사일보다 이전에 입사한 사원명단
select * from emp
where hire_date < (select hire_date from emp where emp_id='202')
order by hire_date desc;

-- 다중컬럼 sub Query
-- dept_id 별로 최대급여수령자, dept_id, salary
select emp_id, name, dept_id, salary from emp
where (dept_id, salary) in (select dept_id, max(salary) from emp group by dept_id);
-------------------------------------------------------------------
-- 부서 dept_id 별로 입사일 hire_date 이 가장 오래된 사원의 
-- emp_id, name, dept_id, hire_date
-- dept_id 순으로 오름차순 정렬
select emp_id, name, dept_id, hire_date from emp
where (dept_id, hire_date) in (select dept_id, min(hire_date) from emp group by dept_id)
order by dept_id;
-------------------------------------------------------------------
-- job_id 별로 해당직급에서 최대급여수령자의
-- name, job_id, salary
-- salary 내림차순 정렬
select name, job_id, salary from emp
where (job_id, salary) in (select job_id, max(salary) from emp group by job_id)
order by salary desc;
-------------------------------------------------------------------
-- dept_id 별로 평균급여를 구하고 그 중에서 평균급여가 가장 적은 부서의 평균급여보다 적은 직원의
-- name, dept_id, salary
-- salary 순으로  내림차순 정렬
-- 50 : 3475.55555555555555555555555555556
select name, dept_id, salary from emp
where salary < all(select avg(salary) salary from emp group by dept_id)
order by salary desc; 
-------------------------------------------------------------------
-- 상호연관 sub Query
-- emp에서 직원들 중 자기 부서의 평균급여보다 같거나 많은 사람
select name, dept_id, salary from emp a
where salary >= (select avg(salary) from emp b where a.dept_id = b.dept_id)
order by a.dept_id;
-------------------------------------------------------------------
select e.name, e.dept_id, d.dept_name from emp e, dept d where e.dept_id = d.dept_id;
-- Scalar sub Query
select e.name, (select d.dept_name from dept d where d.dept_id=e.dept_id) dept_name from emp e;
-- Main 쿼리를 수행한 후 scalar sub query에 필요한 값을 제공한다.
-- Scalar Sub Query를 수행하기 위해 필효한 데이터가 들어있는 블록을 메모리로 로딩
-- Main Query에서 주어진 조건을 가지고 필요한 값을 검색 후 이 결과를 입력값과 출력값으로 
-- 메모리 내의 Query execution cache에 저장. 여기서 입력값은 Main Query에서 주어진 값이고
-- 출력값은 Scalar Sub Query 실행 후 나온 결과값이다.
-- 이 값을 저장하는 캐쉬값을 지정하는 파라미터는 _query_execution_cache_max_size 이다.
-- 다음 조건의 Main Query에서 Scalar Sub Query로 들어오면 해쉬함수를 이용해서 해당값이 
-- 캐쉬에 존재하는지 찾고 있으면 즉시 결과값을 출력하고 없으면 다시 블록을 액세스해서 해당값을 찾은 후 다시 메모리에 캐싱함
-- Main Query 끝날 때까지 반복
-------------------------------------------------------------------
-- 최근 입사일 기준으로 10명
select * from 
    (select rownum rnum, v.* from e1 v)
where rnum <=10;

create view e1 as
select * from emp order by hire_date desc;
    
create view e2 as
select rownum rnum, v.* from e1 v;

select * from e2
where rnum between 21 and 30;