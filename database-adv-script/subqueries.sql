-- 0. Subqueries in SQL
-- Objective: Write both correlated and non-correlated subqueries.

-- 1. Non-correlated Subquery:
-- Find all properties where the average rating is greater than 4.0
SELECT 
    p.id AS property_id,
    p.title,
    p.location
FROM properties p
WHERE p.id IN (
    SELECT r.property_id
    FROM reviews r
    GROUP BY r.property_id
    HAVING AVG(r.rating) > 4.0
)
ORDER BY p.id;

-- 2. Correlated Subquery:
-- Find users who have made more than 3 bookings
SELECT 
    u.id AS user_id,
    u.username,
    u.email
FROM users u
WHERE (
    SELECT COUNT(*)
    FROM bookings b
    WHERE b.user_id = u.id
) > 3
ORDER BY u.id;
