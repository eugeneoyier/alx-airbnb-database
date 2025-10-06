-- 0. Write Complex Queries with Joins
-- Objective: Master SQL joins by writing complex queries using different types of joins.

-- Retrieve all bookings and the respective users who made those bookings
-- Using INNER JOIN
SELECT 
    b.id AS booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    u.id AS user_id,
    u.username,
    u.email
FROM bookings b
INNER JOIN users u
    ON b.user_id = u.id;

-- Retrieve all properties and their reviews, including properties that have no reviews
-- Using LEFT JOIN
SELECT 
    p.id AS property_id,
    p.title,
    p.location,
    r.id AS review_id,
    r.rating,
    r.comment
FROM properties p
LEFT JOIN reviews r
    ON p.id = r.property_id
ORDER BY p.id;

-- Retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user
-- Using FULL OUTER JOIN (emulated with UNION)
SELECT 
    u.id AS user_id,
    u.username,
    b.id AS booking_id,
    b.property_id,
    b.start_date,
    b.end_date
FROM users u
LEFT JOIN bookings b
    ON u.id = b.user_id
UNION
SELECT 
    u.id AS user_id,
    u.username,
    b.id AS booking_id,
    b.property_id,
    b.start_date,
    b.end_date
FROM users u
RIGHT JOIN bookings b
    ON u.id = b.user_id;
