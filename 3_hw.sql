-- 1. Выведите Ваш возраст на текущий день в секундах
SELECT TIMESTAMPDIFF(SECOND, 'YYYY-MM-DD', NOW()) AS age_in_seconds;

-- 2. Выведите, какая дата будет через 51 день
SELECT DATE_ADD(NOW(), INTERVAL 51 DAY) AS future_date;

-- 3. Отформатируйте предыдущий запрос - выведите день недели для этой даты
SELECT DATE_FORMAT(DATE_ADD(NOW(), INTERVAL 51 DAY), '%W') AS future_day_of_week;

-- 4. Подключитесь к базе данных northwind и выведите дату создания транзакции + 3 часа
USE northwind;
SELECT 
    transaction_created_date, 
    DATE_ADD(transaction_created_date, INTERVAL 3 HOUR) AS updated_transaction_date
FROM inventory_transactions;

-- 5. Выведите столбец с текстом 'Клиент с id <customer_id> сделал заказ <order_date>'
-- Способ 1 (неявное преобразование)
SELECT 
    CONCAT('Клиент с id ', customer_id, ' сделал заказ ', order_date) AS order_info
FROM orders;

-- Способ 2 (с явным приведением customer_id к строке)
SELECT 
    CONCAT('Клиент с id ', CAST(customer_id AS CHAR), ' сделал заказ ', order_date) AS order_info
FROM orders;

