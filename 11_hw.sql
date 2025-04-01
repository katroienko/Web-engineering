DELIMITER //

CREATE FUNCTION CircleArea(radius DOUBLE)
RETURNS DOUBLE
DETERMINISTIC
BEGIN
    -- Вычисляем площадь круга по формуле: PI() * (radius)^2
    RETURN PI() * POW(radius, 2);
END //

DELIMITER ;


DELIMITER //
CREATE FUNCTION Hypotenuse(a DOUBLE, b DOUBLE)
RETURNS DOUBLE
DETERMINISTIC
BEGIN
    -- Вычисляем гипотенузу: SQRT(a^2 + b^2)
    RETURN SQRT(POW(a, 2) + POW(b, 2));
END //

DELIMITER ;