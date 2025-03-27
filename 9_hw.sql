-- 1. Для каждого order_id выведите минимальный, максимальный и средний unit_cost:
-- Для вычисления минимального, максимального и среднего значения unit_cost по каждому order_id используем агрегатные функции MIN(), MAX() и AVG() в сочетании с группировкой по order_id:
SELECT
    order_id,
    MIN(unit_cost) AS min_unit_cost,
    MAX(unit_cost) AS max_unit_cost,
    AVG(unit_cost) AS avg_unit_cost
FROM
    purchase_order_details
GROUP BY
    order_id;

-- 2.Оставьте только уникальные строки из предыдущего запроса:
-- Результат предыдущего запроса уже содержит уникальные комбинации order_id и соответствующих агрегированных значений. Дополнительные действия для обеспечения уникальности не требуются.

-- 3. Посчитайте стоимость продукта в заказе как quantity * unit_cost. Выведите суммарную стоимость продуктов с помощью оконной функции. Сделайте то же самое с помощью GROUP BY:
SELECT
    order_id,
    product_id,
    quantity,
    unit_cost,
    quantity * unit_cost AS product_total_cost,
    SUM(quantity * unit_cost) OVER(PARTITION BY order_id) AS order_total_cost
FROM
    purchase_order_details;
-- С использованием GROUP BY:
SELECT
    order_id,
    SUM(quantity * unit_cost) AS order_total_cost
FROM
    purchase_order_details
GROUP BY
    order_id;
-- Здесь агрегатная функция SUM() в сочетании с GROUP BY вычисляет общую стоимость продуктов для каждого заказа.

-- 4. Посчитайте количество заказов по date_received и posted_to_inventory. Если оно превышает 1, выведите '>1', в противном случае '=1'. Выведите purchase_order_id, date_received и вычисленный столбец:
WITH OrderCounts AS (
    SELECT
        date_received,
        posted_to_inventory,
        COUNT(*) AS order_count
    FROM
        purchase_order_details
    GROUP BY
        date_received,
        posted_to_inventory
)
SELECT
    pod.purchase_order_id,
    pod.date_received,
    CASE
        WHEN oc.order_count > 1 THEN '>1'
        ELSE '=1'
    END AS order_count_status
FROM
    purchase_order_details pod
JOIN
    OrderCounts oc
    ON pod.date_received = oc.date_received
    AND pod.posted_to_inventory = oc.posted_to_inventory;
