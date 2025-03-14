-- Выведите в одну общую выборку из таблиц customers и employees имена и фамилии клиентов и сотрудников.
SELECT 
	first_name,
    last_name
FROM
	customers
UNION
SELECT 
	first_name,
    last_name
FROM 
	employees;
    -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
SELECT
	employees.id,
	last_name,
    employee_privileges.privilege_id,
    privileges.id,
    privileges.privilege_name
FROM employees
LEFT JOIN employee_privileges ON employees.id = employee_privileges.employee_id
LEFT JOIN privileges ON employee_privileges.privilege_id = privileges.id;