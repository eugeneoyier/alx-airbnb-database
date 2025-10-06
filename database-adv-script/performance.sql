-- Optimize Complex Queries
-- Objective: Refactor complex queries to improve performance.
-- This file contains the initial query, EXPLAIN analysis, and the optimized version.

-- ===========================================================
-- 1️⃣ Initial Query (Before Optimization)
-- ===========================================================
-- Retrieve all bookings along with user details, property details, and payment details.

EXPLAIN ANALYZE
SELECT 
    b.id AS booking_id,
    b.start_date,
    b.end_date,
    u.id AS user_id,
    u.name AS user_name,
    u.email AS user_email,
    p.id AS property_id,
    p.title AS property_title,
    p.location AS property_location,
    pay.id AS payment_id,
    pay.amount,
    pay.status
FROM bookings b
JOIN users u ON b.user_id = u.id
JOIN properties p ON b.property_id = p.id
LEFT JOIN payments pay ON b.id = pay.booking_id
ORDER BY b.start_date DESC;

-- ⚠️ Potential Issues Identified:
-- - Full table scans on large tables (bookings, users, properties).
-- - No filter condition, so all records are retrieved (high I/O cost).
-- - ORDER BY b.start_date DESC requires sorting large datasets without an index.
-- - Multiple joins increase execution time if foreign key columns are not indexed.

-- ===========================================================
-- 2️⃣ Optimized Query (After Refactoring)
-- ===========================================================

EXPLAIN ANALYZE
SELECT 
    b.id AS booking_id,
    b.start_date,
    b.end_date,
    u.name AS user_name,
    p.title AS property_title,
    pay.amount,
    pay.status
FROM bookings b
INNER JOIN users u ON b.user_id = u.id
INNER JOIN properties p ON b.property_id = p.id
LEFT JOIN payments pay ON b.id = pay.booking_id
WHERE b.start_date >= CURRENT_DATE - INTERVAL 1 YEAR
ORDER BY b.start_date DESC;

-- ✅ Optimizations Applied:
-- 1. Reduced unnecessary selected column
