select e.employee_id, e.first_name, d.department_name, l.city
from employees e, departments d, locations l 
where e.department_id = d.department_id and d.location_id = l.location_id ;

select e.employee_id, e.first_name, d.department_name, l.city
from employees e join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id
;