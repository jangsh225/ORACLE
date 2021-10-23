select * from emp;
-- emp_id �� 202�� ����� �Ի��Ϻ��� ������ �Ի��� ������
select * from emp
where hire_date < (select hire_date from emp where emp_id='202')
order by hire_date desc;

-- �����÷� sub Query
-- dept_id ���� �ִ�޿�������, dept_id, salary
select emp_id, name, dept_id, salary from emp
where (dept_id, salary) in (select dept_id, max(salary) from emp group by dept_id);
-------------------------------------------------------------------
-- �μ� dept_id ���� �Ի��� hire_date �� ���� ������ ����� 
-- emp_id, name, dept_id, hire_date
-- dept_id ������ �������� ����
select emp_id, name, dept_id, hire_date from emp
where (dept_id, hire_date) in (select dept_id, min(hire_date) from emp group by dept_id)
order by dept_id;
-------------------------------------------------------------------
-- job_id ���� �ش����޿��� �ִ�޿���������
-- name, job_id, salary
-- salary �������� ����
select name, job_id, salary from emp
where (job_id, salary) in (select job_id, max(salary) from emp group by job_id)
order by salary desc;
-------------------------------------------------------------------
-- dept_id ���� ��ձ޿��� ���ϰ� �� �߿��� ��ձ޿��� ���� ���� �μ��� ��ձ޿����� ���� ������
-- name, dept_id, salary
-- salary ������  �������� ����
-- 50 : 3475.55555555555555555555555555556
select name, dept_id, salary from emp
where salary < all(select avg(salary) salary from emp group by dept_id)
order by salary desc; 
-------------------------------------------------------------------
-- ��ȣ���� sub Query
-- emp���� ������ �� �ڱ� �μ��� ��ձ޿����� ���ų� ���� ���
select name, dept_id, salary from emp a
where salary >= (select avg(salary) from emp b where a.dept_id = b.dept_id)
order by a.dept_id;
-------------------------------------------------------------------
select e.name, e.dept_id, d.dept_name from emp e, dept d where e.dept_id = d.dept_id;
-- Scalar sub Query
select e.name, (select d.dept_name from dept d where d.dept_id=e.dept_id) dept_name from emp e;
-- Main ������ ������ �� scalar sub query�� �ʿ��� ���� �����Ѵ�.
-- Scalar Sub Query�� �����ϱ� ���� ��ȿ�� �����Ͱ� ����ִ� ����� �޸𸮷� �ε�
-- Main Query���� �־��� ������ ������ �ʿ��� ���� �˻� �� �� ����� �Է°��� ��°����� 
-- �޸� ���� Query execution cache�� ����. ���⼭ �Է°��� Main Query���� �־��� ���̰�
-- ��°��� Scalar Sub Query ���� �� ���� ������̴�.
-- �� ���� �����ϴ� ĳ������ �����ϴ� �Ķ���ʹ� _query_execution_cache_max_size �̴�.
-- ���� ������ Main Query���� Scalar Sub Query�� ������ �ؽ��Լ��� �̿��ؼ� �ش簪�� 
-- ĳ���� �����ϴ��� ã�� ������ ��� ������� ����ϰ� ������ �ٽ� ����� �׼����ؼ� �ش簪�� ã�� �� �ٽ� �޸𸮿� ĳ����
-- Main Query ���� ������ �ݺ�
-------------------------------------------------------------------
-- �ֱ� �Ի��� �������� 10��
select * from 
    (select rownum rnum, v.* from e1 v)
where rnum <=10;

create view e1 as
select * from emp order by hire_date desc;
    
create view e2 as
select rownum rnum, v.* from e1 v;

select * from e2
where rnum between 21 and 30;