CREATE VIEW EMP
AS SELECT 
    employee_id emp_id, --���    
    first_name||' '||last_name name, --�̸�
    email, --�̸���
    phone_number phone, --��ȭ
    hire_date, --�Ի���
    job_id, --����
    salary, --�޿�
    commission_pct com_pct, --�߰����� ����
    manager_id ma_id, --���ӻ��
    department_id dept_id --�μ���ȣ
FROM 
    employees
WITH READ ONLY;

------------------------------------------------------

CREATE VIEW DEPT
AS SELECT 
    department_id dept_id, --�μ���ȣ
    department_name dept_name, --�μ��̸�
    manager_id ma_id, --���ӻ��
    location_id loc_id --������ȣ
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
-- 30�� �μ��� ��� ������ ����ϼ��� 
select * from emp where dept_id = 30;
------------------------------------------------------
-- 100�� �μ��� �μ���� ��������� ����ϼ���(�����ȣ, �̸�, �μ���ȣ, �μ���)\
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
--job id �� 'IT_PROG'�� emp_id, emp_name, job title, salary '���翬��' ����ϼ��� (emp, jobs)
select e.emp_id, e.name, j.job_title, e.salary ���翬��
from emp e, jobs j
where e.job_id = j.job_id and j.job_id='IT_PROG';

select e.emp_id, e.name, j.job_title, e.salary ���翬��
from emp e join jobs j
on e.job_id = j.job_id and j.job_id='IT_PROG';
------------------------------------------------------
-- salary �޿��� $9000 �̻��� �����
-- �����ȣ, �̸�, �μ���, ��åid, salary
select e.emp_id, e.name, d.dept_name, e.job_id, e.salary
from emp e, dept d
where e.dept_id = d.dept_id and e.salary>=9000;

select e.emp_id, e.name, d.dept_name, e.job_id, e.salary
from emp e join dept d
on e.dept_id = d.dept_id and e.salary>=9000;
------------------------------------------------------
-- emp, dept, jobs 
select e.emp_id, e.name, d.dept_name, e.job_id, j.job_title, e.salary ����޿�
from emp e, dept d, jobs j
where e.dept_id = d.dept_id and e.job_id = j.job_id
order by e.emp_id;
------------------------------------------------------
-- com_pct not null�� ���
-- emp_id, name, salary �⺻�޿�, salary*com_pct ����, salary+salry*com_pct �ѱ޿� 
select 
emp_id, name, salary �⺻�޿�, salary*com_pct ����, salary+salary*com_pct �ѱ޿�
from emp
where com_pct is not null
order by emp_id;
------------------------------------------------------
-- com_pct null �� �ƴ� ���, com_pct null �̸� 0 NVL
select 
emp_id, name, salary �⺻�޿�, salary*NVL(com_pct, 0) ����, salary*(1+NVL(com_pct, 0)) �ѱ޿�
from emp
order by salary*(1+NVL(com_pct, 0)) desc;
------------------------------------------------------
-- �⺻SQL : DDL, DML, DCL, ������ �����˻�
-- ���SQL : �ε���Ȱ��, viewe Ȱ��, �������̺� �˻�(join, subquery, ���տ���(union))

-- ���̺� �����̽�
select table_name, tablespace_name 
from user_tables
where table_name = 'EMPLOYEES';

-- employees ���̺� first_name index ����
-- �ε��� �̸��� first_name_ix ����
-- �ε��� ���� Ȯ���� �� �ִ� ���� ����
CREATE INDEX FIRST_NAME_IX ON EMPLOYEES (FIRST_NAME);

SELECT * from user_indexes
where index_name = 'FIRST_NAME_IX';

select last_name from employees order by last_name;

--emp �̸��� Smith ���Ե� �����
select emp_id, name from emp
where name like '%Smith%';


