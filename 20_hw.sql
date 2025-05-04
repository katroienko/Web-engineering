Web engineering 2025: Домашнее задание 20

1. Подключитесь к базе данных hr (которая находится на удаленном сервере). USE hr;

USE hr;

2. Выведите количество сотрудников в базе

SELECT 
	COUNT(employee_id) AS count_of_employees
FROM employees;

3. Выведите количество департаментов (отделов) в базе

SELECT 
	COUNT(department_id) AS count_of_departments
FROM departments;

4. Подключитесь к базе данных World (которая находится на удаленном сервере).

USE world;

5. Выведите среднее население в городах Индии (таблица City, код Индии - IND)

SELECT 
	AVG(Population) AS average_population_in_indian_cities
FROM 
	city
WHERE 
	CountryCode = "IND";

 6. Выведите минимальное население в индийском городе и максимальное.

SELECT 
	MIN(Population) AS min_population_in_indian_cities,
    MAX(Population) AS max_population_in_indian_cities
FROM 
	city
WHERE 
	CountryCode = "IND";

7. Выведите самую большую площадь территории.

SELECT 
    MAX(SurfaceArea) AS max_surface_area
FROM 
	country;
    
8. Выведите среднюю продолжительность жизни по странам.

SELECT 
    AVG(LifeExpectancy) AS average_life_expectancy
FROM 
	country;
    
 9. Найдите самый населенный город (подсказка: использовать подзапросы)

SELECT 
    Name AS most_populated_city,
    Population
FROM 
    city
WHERE 
    Population = (
        SELECT MAX(Population)
        FROM city
    );
    
