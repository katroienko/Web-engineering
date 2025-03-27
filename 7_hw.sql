-- 1   Вывести названия продуктов таблица products, включая количество заказанных единиц quantity для каждого продукта таблица order_details.Решить задачу с помощью cte и подзапроса
-- Создаем обобщенное табличное выражение (CTE) для агрегирования количества заказанных единиц по каждому продукту
WITH ProductQuantities AS (
    SELECT
        product_id,
        SUM(quantity) AS total_quantity
    FROM
        order_details
    GROUP BY
        product_id
)
-- Основной запрос: объединяем данные о продуктах с агрегированными данными о количестве заказанных единиц
SELECT
    p.product_name,
    COALESCE(pq.total_quantity, 0) AS total_quantity
FROM
    products p
    LEFT JOIN ProductQuantities pq ON p.product_id = pq.product_id;
-- Решение с использованием подзапроса:
-- Основной запрос: выбираем название продукта и суммарное количество заказанных единиц, используя подзапрос для агрегирования данных
SELECT
    p.product_name,
    COALESCE((
        SELECT SUM(od.quantity)
        FROM order_details od
        WHERE od.product_id = p.product_id
    ), 0) AS total_quantity
FROM
    products p;


-- 2. Найти все заказы из таблицы orders, сделанные после даты самого первого заказа клиента с фамилией 'Lee' из таблицы customers.
-- Определяем минимальную дату заказа для клиента с фамилией 'Lee'
-- Определяем минимальную дату заказа для клиента с фамилией 'Lee'
WITH FirstLeeOrderDate AS (
    SELECT
        MIN(o.order_date) AS first_order_date
    FROM
        orders o
        JOIN customers c ON o.customer_id = c.customer_id
    WHERE
        c.last_name = 'Lee'
)
-- Основной запрос: выбираем заказы, сделанные после первой даты заказа клиента 'Lee'
SELECT
    o.*
FROM
    orders o,
    FirstLeeOrderDate flo
WHERE
    o.order_date > flo.first_order_date;


-- 3. Найти все продукты из таблицы products с максимальным значением в столбце target_level.
-- Определяем максимальное значение target_level среди всех продуктов
WITH MaxTargetLevel AS (
    SELECT
        MAX(target_level) AS max_target
    FROM
        products
)
-- Основной запрос: выбираем продукты с максимальным значением target_level
SELECT
    p.*
FROM
    products p,
    MaxTargetLevel mtl
WHERE
    p.target_level = mtl.max_target;
