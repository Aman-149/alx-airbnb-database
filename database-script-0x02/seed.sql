-- Insert sample users
INSERT INTO users (user_id, name, email, password)
VALUES
(1, 'Amanuel Fikadu', 'amanuel@example.com', 'hashed_password'),
(2, 'Marta Kebede', 'marta@example.com', 'hashed_password');

-- Insert sample products
INSERT INTO products (product_id, name, price, quantity)
VALUES
(1, 'Laptop', 45000, 10),
(2, 'Headphones', 1200, 50);

-- Insert sample orders
INSERT INTO orders (order_id, user_id, order_date, total)
VALUES
(1, 1, '2025-10-15', 46200),
(2, 2, '2025-10-16', 1200);

