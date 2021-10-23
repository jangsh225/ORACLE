CREATE VIEW EMP
AS SELECT 
    employee_id emp_id, --사번    
    first_name||' '||last_name name, --이름
    email, --이메일
    phone_number phone, --전화
    hire_date, --입사일
    job_id, --직급
    salary, --급여
    commission_pct com_pct, --추가수당 비율
    manager_id ma_id, --직속상관
    department_id dept_id --부서번호
FROM 
    employees
WITH READ ONLY;

------------------------------------------------------

CREATE VIEW DEPT
AS SELECT 
    department_id dept_id, --부서번호
    department_name dept_name, --부서이름
    manager_id ma_id, --직속상관
    location_id loc_id --지역번호
FROM 
    departments
WITH READ ONLY;

------------------------------------------------------
select * from emp;
select * from dept;

select dept_id, count(*) 
from emp 
group by dept_id;
------------------------------------------------------
-- 30번 부서의 사원 정보를 출력하세요 
select * from emp where dept_id = 30;
------------------------------------------------------
-- 100번 부서의 부서명과 사원정보를 출력하세요(사원번호, 이름, 부서번호, 부서명)\
-- ORACLE
SELECT e.emp_id, e.name, e.dept_id, d.dept_name
from emp e, dept d
where e.dept_id = d.dept_id and e.dept_id=100;
-- ANSI
SELECT e.emp_id, e.name, e.dept_id, d.dept_name
from emp e join dept d
on e.dept_id = d.dept_id and e.dept_id=100;
------------------------------------------------------
select job_id, count(*)
from emp
group by job_id;
------------------------------------------------------
--job id 가 'IT_PROG'인 emp_id, emp_name, job title, salary '현재연봉' 출력하세요 (emp, jobs)
select e.emp_id, e.name, j.job_title, e.salary 현재연봉
from emp e, jobs j
where e.job_id = j.job_id and j.job_id='IT_PROG';

select e.emp_id, e.name, j.job_title, e.salary 현재연봉
from emp e join jobs j
on e.job_id = j.job_id and j.job_id='IT_PROG';
------------------------------------------------------
-- salary 급여가 $9000 이상인 사람의
-- 사원번호, 이름, 부서명, 직책id, salary
select e.emp_id, e.name, d.dept_name, e.job_id, e.salary
from emp e, dept d
where e.dept_id = d.dept_id and e.salary>=9000;

select e.emp_id, e.name, d.dept_name, e.job_id, e.salary
from emp e join dept d
on e.dept_id = d.dept_id and e.salary>=9000;
------------------------------------------------------
-- emp, dept, jobs 
select e.emp_id, e.name, d.dept_name, e.job_id, j.job_title, e.salary 현재급여
from emp e, dept d, jobs j
where e.dept_id = d.dept_id and e.job_id = j.job_id
order by e.emp_id;
------------------------------------------------------
-- com_pct not null인 사람
-- emp_id, name, salary 기본급여, salary*com_pct 수당, salary+salry*com_pct 총급여 
select 
emp_id, name, salary 기본급여, salary*com_pct 수당, salary+salary*com_pct 총급여
from emp
where com_pct is not null
order by emp_id;
------------------------------------------------------
-- com_pct null 이 아닌 사람, com_pct null 이면 0 NVL
select 
emp_id, name, salary 기본급여, salary*NVL(com_pct, 0) 수당, salary*(1+NVL(com_pct, 0)) 총급여
from emp
order by salary*(1+NVL(com_pct, 0)) desc;
------------------------------------------------------
-- 기본SQL : DDL, DML, DCL, 데이터 사전검색
-- 고급SQL : 인덱스활용, viewe 활용, 다중테이블 검색(join, subquery, 집합연산(union))

-- 테이블 스페이스
select table_name, tablespace_name 
from user_tables
where table_name = 'EMPLOYEES';

-- employees 테이블에 first_name index 생성
-- 인덱스 이름은 first_name_ix 적용
-- 인덱스 적용 확인할 수 있는 쿼리 실행
CREATE INDEX FIRST_NAME_IX ON EMPLOYEES (FIRST_NAME);

SELECT * from user_indexes
where index_name = 'FIRST_NAME_IX';

select last_name from employees order by last_name;

--emp 이름에 Smith 포함된 사람은
select emp_id, name from emp
where name like '%Smith%';


