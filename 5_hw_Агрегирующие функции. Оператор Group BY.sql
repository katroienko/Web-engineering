-- 1. Основные статистики по unit_cost
SELECT 
    AVG(unit_cost) AS avg_cost,
    SUM(unit_cost) AS total_cost,
    MIN(unit_cost) AS min_cost,
    MAX(unit_cost) AS max_cost
FROM northwind.purchase_order_details;

-- 2. Количество уникальных заказов purchase_order_id
SELECT COUNT(DISTINCT purchase_order_id) AS unique_orders
FROM northwind.purchase_order_details;

-- 3. Количество продуктов в каждом заказе, сортировка по убыванию
SELECT 
    purchase_order_id, 
    COUNT(product_id) AS product_count
FROM northwind.purchase_order_details
GROUP BY purchase_order_id
ORDER BY product_count DESC;

-- 4. Количество заказов по дате доставки (учитываем только quantity > 30)
SELECT 
    date_received, 
    COUNT(*) AS order_count
FROM northwind.purchase_order_details
WHERE quantity > 30
GROUP BY date_received;

-- 5. Суммарная стоимость заказов в каждую из дат (quantity * unit_cost)
SELECT 
    date_received, 
    SUM(quantity * unit_cost) AS total_order_cost
FROM northwind.purchase_order_details
GROUP BY date_received;

-- 6. Группировка по unit_cost, вычисление среднего и максимального quantity (только для purchase_order_id ≤ 100)
SELECT 
    unit_cost, 
    AVG(quantity) AS avg_quantity, 
    MAX(quantity) AS max_quantity
FROM northwind.purchase_order_details
WHERE purchase_order_id <= 100
GROUP BY unit_cost;

-- 7. Выбор строк, где есть inventory_id, создание категории и подсчет количества продуктов в каждой категории
SELECT 
    CASE 
        WHEN unit_cost > 20 THEN 'Expensive'
        ELSE 'Others'
    END AS category, 
    COUNT(*) AS product_count
FROM northwind.purchase_order_details
WHERE inventory_id IS NOT NULL
GROUP BY category;
