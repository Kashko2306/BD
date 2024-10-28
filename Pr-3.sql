-- Запити на вибірку даних 

-- Кількість фільмів у кожній категорії
SELECT 
    c.name AS "Категорія",
    COUNT(f.film_id) AS "Кількість фільмів"
FROM category c
LEFT JOIN film_category fc ON c.category_id = fc.category_id
LEFT JOIN film f ON fc.film_id = f.film_id
GROUP BY c.category_id, c.name
ORDER BY "Кількість фільмів" DESC;

-- Середня тривалість фільмів у кожній категорії
SELECT 
    c.name AS "Категорія",
    ROUND(AVG(f.length), 2) AS "Середня тривалість (хв)",
    COUNT(f.film_id) AS "Кількість фільмів"
FROM category c
LEFT JOIN film_category fc ON c.category_id = fc.category_id
LEFT JOIN film f ON fc.film_id = f.film_id
GROUP BY c.category_id, c.name
ORDER BY "Середня тривалість (хв)" DESC;

-- Мінімальна та максимальна тривалість фільмів
SELECT 
    MIN(length) AS "Мінімальна тривалість (хв)",
    MAX(length) AS "Максимальна тривалість (хв)",
    ROUND(AVG(length), 2) AS "Середня тривалість (хв)",
    COUNT(*) AS "Загальна кількість фільмів"
FROM film
WHERE length IS NOT NULL;

-- Загальна кількість клієнтів
SELECT COUNT(*) AS total_customers
FROM customers;

-- Сума платежів по кожному клієнту
SELECT 
    c.customer_name, 
    SUM(p.payment_amount) AS total_payments
FROM customers c
JOIN payments p ON c.customer_id = p.customer_id
GROUP BY c.customer_name;

-- П'ять клієнтів з найбільшою сумою платежів
SELECT 
    c.customer_name, 
    SUM(p.payment_amount) AS total_payments
FROM customers c
JOIN payments p ON c.customer_id = p.customer_id
GROUP BY c.customer_name
ORDER BY total_payments DESC
LIMIT 5;

-- Загальна кількість орендованих фільмів кожним клієнтом
SELECT 
    c.customer_name, 
    COUNT(r.rental_id) AS rental_count
FROM customers c
JOIN rentals r ON c.customer_id = r.customer_id
GROUP BY c.customer_name;

-- Середній вік фільмів у базі даних
SELECT 
    AVG(YEAR(CURRENT_DATE) - release_year) AS average_movie_age
FROM movies;

-- Кількість фільмів, орендованих за певний період
SELECT COUNT(*) AS rental_count
FROM rentals
WHERE rental_date BETWEEN 'YYYY-MM-DD' AND 'YYYY-MM-DD';  -- Змініть дати на потрібні

-- Сума платежів по кожному місяцю
SELECT 
    DATE_FORMAT(payment_date, '%Y-%m') AS month, 
    SUM(payment_amount) AS total_payments
FROM payments
GROUP BY month
ORDER BY month;

-- Максимальна сума платежу, здійснена клієнтом
SELECT 
    c.customer_name, 
    MAX(p.payment_amount) AS max_payment
FROM customers c
JOIN payments p ON c.customer_id = p.customer_id
GROUP BY c.customer_name;

-- Середня сума платежів для кожного клієнта
SELECT 
    c.customer_name, 
    AVG(p.payment_amount) AS average_payment
FROM customers c
JOIN payments p ON c.customer_id = p.customer_id
GROUP BY c.customer_name;

-- Кількість фільмів у кожному рейтингу (rating)
SELECT 
    rating, 
    COUNT(*) AS film_count
FROM movies
WHERE rating IN ('G', 'PG', 'PG-13', 'R', 'NC-17')
GROUP BY rating
ORDER BY rating;

-- Середня сума платежів по кожному магазину (store)
SELECT 
    s.store_name, 
    AVG(p.payment_amount) AS average_payment
FROM stores s
JOIN payments p ON s.store_id = p.store_id
GROUP BY s.store_name;
