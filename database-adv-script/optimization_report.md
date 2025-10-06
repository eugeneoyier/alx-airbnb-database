# Optimization Report – Airbnb Database Performance Tuning

## Objective
To refactor a complex SQL query that retrieves booking information along with user, property, and payment details to improve performance and reduce query execution time.

---

## Initial Query Analysis
**Query File:** `perfomance.sql` (Initial Version)

The original query joined four tables:
- `bookings`
- `users`
- `properties`
- `payments`

It retrieved all records without any filters and ordered results by `b.start_date DESC`.

### Performance Observations (Before Optimization)
- **Execution plan:** Full table scan on `bookings`.
- **Sorting:** Temporary files created for ORDER BY operation.
- **Join Cost:** High, as foreign key columns were not indexed.
- **Rows Examined:** ~250,000 (simulated dataset).
- **Execution Time:** ~1.8 seconds (example estimate).

---

## Identified Inefficiencies
1. No filtering condition — fetched all records.
2. Lack of indexes on join and sorting columns (`user_id`, `property_id`, `start_date`).
3. Unnecessary columns increased data transfer.
4. ORDER BY without index caused full sort operations.
5. LEFT JOIN used unnecessarily in some cases.

---

## Optimization Techniques Applied
1. **Added Indexes:**
   ```sql
   CREATE INDEX idx_bookings_user_id ON bookings(user_id);
   CREATE INDEX idx_bookings_property_id ON bookings(property_id);
   CREATE INDEX idx_bookings_start_date ON bookings(start_date);
   CREATE INDEX idx_payments_booking_id ON payments(booking_id);
