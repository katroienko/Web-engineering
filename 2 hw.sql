-- 1. Выбрать все строки из таблицы suppliers
SELECT * FROM northwind.suppliers;

-- 2. Вывести id, order_id и category с использованием IF
SELECT id, order_id, 
       IF(unit_price > 10, 'Expensive', 'Cheap') AS category
FROM order_details;

-- 2. Вывести id, order_id и category с использованием CASE
SELECT id, order_id, 
       CASE WHEN unit_price > 10 THEN 'Expensive' 
       ELSE 'Cheap' END AS category
FROM order_details;

-- 3. Вывести строки без purchase_order_id и вычислить total_price
SELECT *, (quantity * unit_price) AS total_price
FROM order_details
WHERE purchase_order_id IS NULL;

-- 4. Вывести имя и фамилию сотрудников в одном столбце, начиная со 2-й строки
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM employees
LIMIT 3 OFFSET 1;

-- 5. Вывести год и месяц из order_date в формате 'год-месяц'
SELECT DATE_FORMAT(order_date, '%Y-%m') AS order_year_month
FROM orders;

-- 6. Вывести уникальные имена компаний из customers, отсортированные по убыванию
SELECT DISTINCT company_name 
FROM customers
ORDER BY company_name DESC;
