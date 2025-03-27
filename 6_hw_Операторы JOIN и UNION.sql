-- 1. Вывести id, employee_id из orders и purchase_orders, где created_by = employee_id
SELECT 
    id, 
    employee_id 
FROM northwind.orders
UNION
SELECT 
    id, 
    created_by AS employee_id 
FROM northwind.purchase_orders;

-- 2. Исключить записи с NULL в employee_id, добавить столбец с указанием источника данных
SELECT 
    id, 
    employee_id, 
    'orders' AS source_table
FROM northwind.orders
WHERE employee_id IS NOT NULL
UNION
SELECT 
    id, 
    created_by AS employee_id, 
    'purchase_orders' AS source_table
FROM northwind.purchase_orders
WHERE created_by IS NOT NULL;

-- 3. Вывести все столбцы из order_details + payment_method из purchase_orders (только для заказов с payment_method)
SELECT 
    od.*, 
    po.payment_method
FROM northwind.order_details AS od
JOIN northwind.purchase_orders AS po ON od.order_id = po.id
WHERE po.payment_method IS NOT NULL;

-- 4. Вывести заказы orders и фамилии клиентов customers, только для заказов, по которым есть инвойсы (invoices)
SELECT 
    o.id AS order_id, 
    c.last_name AS customer_last_name
FROM northwind.orders AS o
JOIN northwind.customers AS c ON o.customer_id = c.id
JOIN northwind.invoices AS i ON o.id = i.order_id;

-- 5. Подсчитать количество инвойсов для каждого клиента
SELECT 
    c.id AS customer_id,
    c.last_name AS customer_last_name,
    COUNT(i.id) AS invoice_count
FROM northwind.customers AS c
JOIN northwind.orders AS o ON c.id = o.customer_id
JOIN northwind.invoices AS i ON o.id = i.order_id
GROUP BY c.id, c.last_name;
