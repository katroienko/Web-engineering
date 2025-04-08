-- 1. Вывести id департамента по id сотрудника
SELECT department_id
FROM employees
WHERE id = 1; 

DELIMITER //

CREATE PROCEDURE get_department_by_employee_id_simple (
    IN emp_id INT
)
BEGIN
    SELECT department_id
    FROM employees
    WHERE id = emp_id;
END //

DELIMITER ;
CALL get_department_by_employee_id_simple(1);


-- DELIMITER //

-- CREATE PROCEDURE get_department_by_employee_id (
--     IN emp_id INT,
--     OUT dept_id INT
-- )
-- BEGIN
--     SELECT department_id
--     INTO dept_id
--     FROM employees
--     WHERE id = emp_id;
-- END //

-- DELIMITER ;
-- - Создаем переменную для результата
-- SET @dept_id = NULL;

-- Вызываем процедуру, передаем ID сотрудника
CALL get_department_by_employee_id(1, @dept_id);

-- Смотрим результат
SELECT @dept_id;


-- 2 Создайте хранимую процедуру get_employee_age, которая принимает id сотрудника (IN-параметр) и возвращает его возраст через OUT-параметр.
DELIMITER $$

CREATE PROCEDURE get_employee_age(
    IN emp_id INT,
    OUT emp_age INT
)
BEGIN
    SELECT TIMESTAMPDIFF(YEAR, birth_date, CURDATE())
    INTO emp_age
    FROM employees
    WHERE id = emp_id;
END$$

DELIMITER ;

CALL get_employee_age(1, @age);
SELECT @age;

-- 3 Создайте хранимую процедуру increase_salary, которая принимает зарплату сотрудника (INOUT-параметр) и уменьшает ее на 10%.
DELIMITER $$

CREATE PROCEDURE increase_salary(
    INOUT emp_salary DECIMAL(10,2)
)
BEGIN
    SET emp_salary = emp_salary * 0.9;
END$$

DELIMITER ;