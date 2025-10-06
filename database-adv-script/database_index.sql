-- 0. Indexing for Optimization
-- Objective: Identify and create indexes to improve query performance.

-- 1. Identify high-usage columns
-- Based on typical Airbnb queries, high-usage columns often include:
-- - users.email (used for lookups)
-- - bookings.user_id, bookings.property_id (used in joins)
-- - properties.location (used in filters/search)
-- - bookings.start_date (used in date range queries)
-- - properties.price (used in sorting)

-- 2. Create indexes on these columns

-- Index on users.email to optimize user lookups
CREATE INDEX idx_users_email
ON users(email);

-- Index on bookings.user_id to speed up joins between bookings and users
CREATE INDEX idx_bookings_user_id
ON bookings(user_id);

-- Index on bookings.property_id to optimize joins with the properties table
CREATE INDEX idx_bookings_property_id
ON bookings(property_id);

-- Index on properties.location to improve filtering by location
CREATE INDEX idx_properties_location
ON properties(location);

-- Index on bookings.start_date to improve date range queries
CREATE INDEX idx_bookings_start_date
ON bookings(start_date);

-- Index on properties.price to optimize queries involving sorting or range filtering
CREATE INDEX idx_properties_price
ON properties(price);

-- 3. Measure performance before and after indexing using EXPLAIN or ANALYZE

-- Example before indexing:
-- EXPLAIN ANALYZE
-- SELECT * FROM bookings WHERE user_id = 10;

-- Example after indexing:
-- EXPLAIN ANALYZE
-- SELECT * FROM bookings WHERE user_id = 10;

-- Note:
-- Compare the "Execution Time" and "Rows Examined" in the EXPLAIN ANALYZE output.
-- You should observe reduced query cost and faster execution time after adding indexes.
