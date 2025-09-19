CREATE TABLE customers (
  customer_id BIGINT GENERATED ALWAYS AS IDENTITY,
  first_name TEXT,
  last_name TEXT,
  email TEXT,
  phone TEXT,
  created_at TIMESTAMPTZ
);

CREATE TABLE addresses (
  address_id BIGINT GENERATED ALWAYS AS IDENTITY,
  customer_id BIGINT,
  line1 TEXT,
  line2 TEXT,
  city TEXT,
  state TEXT,
  postal_code TEXT,
  country TEXT,
  is_primary BOOLEAN,
  created_at TIMESTAMPTZ
);

CREATE TABLE categories (
  category_id BIGINT GENERATED ALWAYS AS IDENTITY,
  name TEXT,
  parent_category_id BIGINT,
  created_at TIMESTAMPTZ
);

CREATE TABLE products (
  product_id BIGINT GENERATED ALWAYS AS IDENTITY,
  sku TEXT,
  name TEXT,
  category_id BIGINT,
  price NUMERIC(12,2),
  cost NUMERIC(12,2),
  active BOOLEAN,
  created_at TIMESTAMPTZ
);

CREATE TABLE orders (
  order_id BIGINT GENERATED ALWAYS AS IDENTITY,
  customer_id BIGINT,
  order_status TEXT,
  order_date TIMESTAMPTZ,
  shipping_address_id BIGINT,
  billing_address_id BIGINT,
  total_amount NUMERIC(12,2)
);

CREATE TABLE order_items (
  order_item_id BIGINT GENERATED ALWAYS AS IDENTITY,
  order_id BIGINT,
  product_id BIGINT,
  quantity INTEGER,
  unit_price NUMERIC(12,2),
  discount_amount NUMERIC(12,2),
  line_total NUMERIC(12,2)
);

CREATE TABLE payments (
  payment_id BIGINT GENERATED ALWAYS AS IDENTITY,
  order_id BIGINT,
  payment_method TEXT,
  amount NUMERIC(12,2),
  currency CHAR(3),
  paid_at TIMESTAMPTZ,
  status TEXT,
  transaction_ref TEXT
);



-- Customers
INSERT INTO customers (first_name, last_name, email, phone, created_at) VALUES
('Alice', 'Johnson', 'alice.johnson@example.com', '555-1010', NOW()),
('Bob', 'Smith', 'bob.smith@example.com', '555-2020', NOW()),
('Carla', 'Martins', 'carla.martins@example.com', '555-3030', NOW()),
('David', 'Brown', 'david.brown@example.com', '555-4040', NOW());

-- Addresses
INSERT INTO addresses (customer_id, line1, line2, city, state, postal_code, country, is_primary, created_at) VALUES
(1, '123 Main St', NULL, 'Austin', 'TX', '73301', 'USA', TRUE, NOW()),
(2, '456 Oak Ave', 'Apt 12', 'Dallas', 'TX', '75201', 'USA', TRUE, NOW()),
(3, '789 Pine Rd', NULL, 'Houston', 'TX', '77001', 'USA', TRUE, NOW()),
(4, '321 Maple St', NULL, 'San Antonio', 'TX', '78201', 'USA', TRUE, NOW());

-- Categories
INSERT INTO categories (name, parent_category_id, created_at) VALUES
('Electronics', NULL, NOW()),
('Computers', 1, NOW()),
('Phones', 1, NOW()),
('Books', NULL, NOW());

-- Products
INSERT INTO products (sku, name, category_id, price, cost, active, created_at) VALUES
('SKU1001', 'Laptop Pro', 2, 1500.00, 1000.00, TRUE, NOW()),
('SKU1002', 'Smartphone X', 3, 800.00, 500.00, TRUE, NOW()),
('SKU1003', 'Headphones', 1, 150.00, 80.00, TRUE, NOW()),
('SKU1004', 'Novel A', 4, 20.00, 5.00, TRUE, NOW()),
('SKU1005', 'Desktop Basic', 2, 900.00, 600.00, TRUE, NOW());

-- Orders
INSERT INTO orders (customer_id, order_status, order_date, shipping_address_id, billing_address_id, total_amount) VALUES
(1, 'Pending', NOW(), 1, 1, 1500.00),
(2, 'Shipped', NOW(), 2, 2, 800.00),
(3, 'Completed', NOW(), 3, 3, 170.00),
(4, 'Pending', NOW(), 4, 4, 920.00);

-- Order Items
INSERT INTO order_items (order_id, product_id, quantity, unit_price, discount_amount, line_total) VALUES
(1, 1, 1, 1500.00, 0.00, 1500.00),
(2, 2, 1, 800.00, 0.00, 800.00),
(3, 3, 1, 150.00, 0.00, 150.00),
(3, 4, 1, 20.00, 0.00, 20.00),
(4, 5, 1, 900.00, -50.00, 850.00),
(4, 3, 1, 150.00, 80.00, 70.00);

-- Payments
INSERT INTO payments (order_id, payment_method, amount, currency, paid_at, status, transaction_ref) VALUES
(1, 'Credit Card', 1500.00, 'USD', NOW(), 'Authorized', 'TXN001'),
(2, 'PayPal', 800.00, 'USD', NOW(), 'Completed', 'TXN002'),
(3, 'Credit Card', 170.00, 'USD', NOW(), 'Completed', 'TXN003'),
(4, 'Credit Card', 920.00, 'USD', NOW(), 'Pending', 'TXN004');