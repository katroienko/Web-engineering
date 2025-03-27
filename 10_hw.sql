-- 1. Для каждого product_id вывести inventory_id, а также предыдущий и следующий inventory_id по убыванию quantity.
SELECT
    product_id,
    inventory_id,
    LAG(inventory_id) OVER (PARTITION BY product_id ORDER BY quantity DESC) AS previous_inventory_id,
    LEAD(inventory_id) OVER (PARTITION BY product_id ORDER BY quantity DESC) AS next_inventory_id
FROM
    order_details;

-- 2. Вывести максимальный и минимальный unit_price для каждого order_id с помощью функции FIRST_VALUE. Вывести order_id и полученные значения.
SELECT
    order_id,
    FIRST_VALUE(unit_price) OVER (PARTITION BY order_id ORDER BY unit_price DESC) AS max_unit_price,
    FIRST_VALUE(unit_price) OVER (PARTITION BY order_id ORDER BY unit_price ASC) AS min_unit_price
FROM
    order_details;

-- 3. Вывести order_id и столбец с разницей между unit_price для каждой строки заказа и минимальным unit_price в рамках одного заказа. Решить задачу двумя способами — с помощью FIRST_VALUE и MIN.
SELECT
    order_id,
    unit_price,
    unit_price - FIRST_VALUE(unit_price) OVER (PARTITION BY order_id ORDER BY unit_price ASC) AS price_difference
FROM
    order_details;

SELECT
    order_id,
    unit_price,
    unit_price - MIN(unit_price) OVER (PARTITION BY order_id) AS price_difference
FROM
    order_details;

-- 4. Присвоить ранг каждой строке, используя RANK по убыванию quantity.
-- Функция RANK присваивает ранг каждой строке в порядке убывания quantity. При этом строки с одинаковым значением quantity получат одинаковый ранг, а следующий ранг будет пропущен.
SELECT
    *,
    RANK() OVER (ORDER BY quantity DESC) AS rank
FROM
    order_details;

5. Из предыдущего запроса выбрать только строки с рангом до 10 включительно.
Используя подзапрос, можно отфильтровать строки с рангом до 10.
SELECT
    *
FROM
    (
        SELECT
            *,
            RANK() OVER (ORDER BY quantity DESC) AS rank
        FROM
            order_details
    ) ranked_orders
WHERE
    rank <= 10;
