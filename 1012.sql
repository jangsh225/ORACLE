select 
e.emp_id, e.name, d.dept_name
from emp e, dept d
where e.dept_id = d.dept_id;
--- ANSI �������� query�� �ۼ��ϼ��� 5��
select 
e.emp_id, e.name, d.dept_name
from emp e join dept d
on e.dept_id = d.dept_id;
-------------------------------------
--EMP, DEPT 2���� VIEW�� JOIN�Ͽ� 
--NAME�� ��King���� ���Ե� ����� 
--NAME, DEPT_NAME�� ����ϼ���
select 
e.name, d.dept_name
from emp e, dept d
where e.dept_id = d.dept_id and e.name like '%King%';
-------------------------------------
--EMP, DEPT, LOC 3���� VIEW�� JOIN�Ͽ� 
--EMP_ID, NAME, DEPT_NAME, CITY�� ����ϼ���. 
--���Ŀ�Ҵ� �������� EMP_ID�Դϴ�.
select 
e.emp_id, e.name, d.dept_name, l.city
from emp e, dept d, loc l
where e.dept_id = d.dept_id and d.loc_id = l.loc_id
order by e.emp_id;
-------------------------------------
--EMP, DEPT ���� VIEW�� JOIN�Ͽ�
--EMP_ID, NAME, DEPT_NAME�� ����ϼ���. 
--��. �μ����� ���� ���� ������ ��ܵ� ���� ����ϼ���
--- Oracle �������� query�� �ۼ��ϼ��� 5��
select 
e.emp_id, e.name, d.dept_name
from emp e, dept d
where e.dept_id = d.dept_id(+);
--- ANSI �������� query�� �ۼ��ϼ��� 5��
select 
e.emp_id, e.name, d.dept_name
from emp e left outer join dept d
on e.dept_id = d.dept_id;
-------------------------------------
--EMP, DEPT ���� VIEW�� JOIN�Ͽ�
--EMP_ID, NAME, DEPT_NAME�� ����ϼ���. 
--��. ���� ������ ���� �μ��̸��� ����ϼ���
--- Oracle �������� query�� �ۼ��ϼ��� 5��
select 
e.emp_id, e.name, d.dept_id
from emp e, dept d
where e.dept_id(+) = d.dept_id;
--- ANSI �������� query�� �ۼ��ϼ��� 5��
select 
e.emp_id, e.name, d.dept_id
from emp e right outer join dept d
on e.dept_id = d.dept_id;
-------------------------------------
--EMP VIEW ���� ��ü �޿��� ��� ���� ���� �޿��� �޴� ���� �����
--EMP_ID, NAME, SAL�� ����ϼ���
select emp_id, name, sal
from emp
where sal > (select avg(sal) from emp);
-------------------------------------
--EMP VIEW ���� ��ü���� �߿��� 100�� �μ��� ������ �޿��� �������� �޴� ��� ����
--�� ���� �޿��� �޴� ���������
--EMP_ID, NAME, SAL �� ����ϼ���
select emp_id, name, sal
from emp
where sal > any(select sal from emp where dept_id = 100);
-------------------------------------
--EMP ���� �μ����� ���� ���� �޴� �޿����� 
--EMP_ID, NAME, SAL �� ����ϼ���
select emp_id, name, sal from emp a
where sal = (select max(sal) from emp b where a.dept_id = b.dept_id); 

select emp_id, name, sal
from emp
where (dept_id, sal) in (select dept_id, max(sal) from emp group by dept_id); 
----------------------------------------------------
--EMP VIEW ���� �ֱ� �Ի��ϱ��� 10��°~20��° ����� ����� ����ϼ���
--��, ruwnum�� Ȱ���Ͽ� �ۼ����ּ���
select * from 
(select rownum rnum, e.* 
    from (select * from emp order by hire_date desc)e)
where rnum between 10 and 20;
-------------------------------------------------------
--EMP, DEPT VIEW���� 
--DEPT_NAME�� 'IT�� �� 'Sales' �� ����� 
--EMP_ID, NAME, DEPT_NAME ������ϼ��� 
--��, union�� �����Ͽ� �ּ���.
select e.emp_id, e.name, d.dept_name
from emp e, dept d
where e.dept_id = d.dept_id and d.dept_name = 'IT'
union
select e.emp_id, e.name, d.dept_name
from emp e, dept d
where e.dept_id = d.dept_id and d.dept_name = 'Sales';
