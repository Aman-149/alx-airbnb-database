# 🧩 Database Normalization - AirBnB Project

## 🎯 Objective
The goal of normalization is to minimize redundancy and ensure data integrity across all entities in the AirBnB database.  
This process ensures the design adheres to **Third Normal Form (3NF)** while maintaining optimal performance and scalability.

---

## 🧱 Step 1: First Normal Form (1NF)

**Rule:**  
Each table should have atomic (indivisible) values and a unique primary key.

**Implementation:**
- All attributes contain single, atomic values (e.g., one email per user, one location per property).
- Primary keys are defined for all tables (`user_id`, `property_id`, `booking_id`, etc.).
- Repeating groups are eliminated — e.g., multiple messages or bookings are stored in separate rows rather than columns.

✅ **Result:** Each table is in 1NF.

---

## 🧩 Step 2: Second Normal Form (2NF)

**Rule:**  
All non-key attributes must depend on the entire primary key (no partial dependency).

**Implementation:**
- Each table has a single-column primary key (UUID).
- Attributes in each table depend fully on that key.
  - For example, `pricepernight` depends on the entire `property_id`.
  - `payment_method` depends entirely on `payment_id`.
- There are no composite primary keys, so 2NF is automatically satisfied.

✅ **Result:** Each table is in 2NF.

---

## 🧠 Step 3: Third Normal Form (3NF)

**Rule:**  
No transitive dependencies — non-key attributes must not depend on other non-key attributes.

**Implementation:**
- User contact info (`email`, `phone_number`) depends only on `user_id`, not on another non-key field.
- Booking details (`start_date`, `end_date`, `status`) depend only on `booking_id`, not indirectly through `property_id` or `user_id`.
- Payment information is separated into its own table, avoiding transitive dependency on Booking.
- Review and Message entities are fully independent and reference User or Property via foreign keys.

✅ **Result:** Each table satisfies 3NF — no redundant or derived data.

---

## 🧮 Summary Table

| Table Name | Normal Form Achieved | Explanation |
|-------------|----------------------|--------------|
| User | 3NF | All attributes depend solely on `user_id`. |
| Property | 3NF | Attributes depend only on `property_id`. |
| Booking | 3NF | No redundant user or property data. |
| Payment | 3NF | Fully dependent on `booking_id`. |
| Review | 3NF | Independent, depends on booking, user, and property. |
| Message | 3NF | No repeating or derived fields. |

---

## 🏁 Final Note
By following these normalization steps, the AirBnB database ensures:
- Minimal redundancy  
- Strong data consistency  
- Easier maintenance and scaling  
- Clear logical relationships between entities


