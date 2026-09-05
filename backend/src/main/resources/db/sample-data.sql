USE food_delivery;

INSERT INTO roles (name) VALUES ('CUSTOMER'), ('RESTAURANT_OWNER'), ('ADMIN')
ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT INTO users (full_name, email, password, primary_role)
VALUES ('Ava Customer', 'ava@example.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'CUSTOMER')
ON DUPLICATE KEY UPDATE full_name = VALUES(full_name);

INSERT INTO users (full_name, email, password, primary_role)
VALUES ('Noah Owner', 'noah@example.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'RESTAURANT_OWNER')
ON DUPLICATE KEY UPDATE full_name = VALUES(full_name);

INSERT INTO users (full_name, email, password, primary_role)
VALUES ('Admin User', 'admin@example.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', 'ADMIN')
ON DUPLICATE KEY UPDATE full_name = VALUES(full_name);

INSERT INTO user_roles (user_id, role_id)
SELECT u.id, r.id FROM users u CROSS JOIN roles r
WHERE u.email = 'ava@example.com' AND r.name = 'CUSTOMER'
ON DUPLICATE KEY UPDATE user_id = user_id;

INSERT INTO user_roles (user_id, role_id)
SELECT u.id, r.id FROM users u CROSS JOIN roles r
WHERE u.email = 'noah@example.com' AND r.name = 'RESTAURANT_OWNER'
ON DUPLICATE KEY UPDATE user_id = user_id;

INSERT INTO user_roles (user_id, role_id)
SELECT u.id, r.id FROM users u CROSS JOIN roles r
WHERE u.email = 'admin@example.com' AND r.name = 'ADMIN'
ON DUPLICATE KEY UPDATE user_id = user_id;

INSERT INTO restaurants (name, description, phone, owner_id)
SELECT 'Green Bowl', 'Fresh salads and warm grain bowls', '+1-555-0100', id
FROM users WHERE email = 'noah@example.com'
AND NOT EXISTS (SELECT 1 FROM restaurants WHERE name = 'Green Bowl');

INSERT INTO categories (name, restaurant_id)
SELECT 'Bowls', id FROM restaurants WHERE name = 'Green Bowl'
AND NOT EXISTS (SELECT 1 FROM categories c WHERE c.name = 'Bowls' AND c.restaurant_id = restaurants.id);

INSERT INTO food_items (name, description, price, restaurant_id, category_id)
SELECT 'Teriyaki Tofu Bowl', 'Tofu, rice, greens, and sesame teriyaki', 12.50, r.id, c.id
FROM restaurants r JOIN categories c ON c.restaurant_id = r.id AND c.name = 'Bowls'
WHERE r.name = 'Green Bowl'
AND NOT EXISTS (SELECT 1 FROM food_items f WHERE f.name = 'Teriyaki Tofu Bowl' AND f.restaurant_id = r.id);