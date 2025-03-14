-- 1. Подключаемся к своей базе данных (замените my_database на свою)
USE northwind;

-- 2. Создаем таблицу погоды за последние 5 дней
CREATE TABLE weather (
    id INT AUTO_INCREMENT PRIMARY KEY,
    date DATE NOT NULL,
    day_temp INT CHECK (day_temp BETWEEN -30 AND 30),
    night_temp INT CHECK (night_temp BETWEEN -30 AND 30),
    wind_speed DECIMAL(3,1) CHECK (wind_speed >= 0) -- скорость ветра может иметь дробную часть
);

-- 3. Заполняем таблицу 5 строками
INSERT INTO weather (date, day_temp, night_temp, wind_speed) VALUES
    (CURDATE() - INTERVAL 4 DAY, 10, 5, 2.5),
    (CURDATE() - INTERVAL 3 DAY, 12, 6, 1.8),
    (CURDATE() - INTERVAL 2 DAY, 8, 3, 4.2),
    (CURDATE() - INTERVAL 1 DAY, 7, 2, 3.0),
    (CURDATE(), 9, 4, 5.5);

-- 4. Увеличиваем ночную температуру на 1 градус, если скорость ветра ≤ 3 м/с
UPDATE weather
SET night_temp = night_temp + 1
WHERE wind_speed <= 3;

-- 5. Создаем представление с расчетными столбцами
CREATE VIEW weather_summary AS
SELECT 
    id, 
    date, 
    day_temp, 
    night_temp, 
    wind_speed,
    (day_temp + night_temp) / 2 AS avg_temp, -- Средняя суточная температура
    CASE 
        WHEN wind_speed < 2 THEN 'штиль'
        WHEN wind_speed >= 2 AND wind_speed < 5 THEN 'умеренный ветер'
        ELSE 'сильный ветер'
    END AS wind_status
FROM weather;
