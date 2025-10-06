# Task 0: Write Complex Queries with Joins

## 🎯 Objective
Master SQL joins by writing complex queries using different types of joins to combine data from multiple related tables.

---

## 🧩 Task Description

This task demonstrates how to use various SQL join operations in a relational database context (based on the Airbnb data model).  

The goal is to write queries that retrieve data across multiple tables such as **users**, **bookings**, **properties**, and **reviews**.

---

## 🧠 Queries Overview

### 1️⃣ INNER JOIN
Retrieve all bookings and the respective users who made those bookings.

```sql
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
