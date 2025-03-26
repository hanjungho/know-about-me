SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE reviews;
TRUNCATE TABLE orders;
TRUNCATE TABLE products;
TRUNCATE TABLE users;
SET FOREIGN_KEY_CHECKS = 1;

-- 사용자 데이터 삽입 (일부 사용자에게 주문/리뷰 집중)
INSERT INTO users (username, email, age) VALUES
        ('JohnDoe', 'john@example.com', 30),
        ('JaneSmith', 'jane@example.com', 25),
        ('DavidLee', 'david@example.com', 40),
        ('SarahKim', 'sarah@example.com', 28),
        ('MichaelBrown', 'michael@example.com', 35),
        ('EmilyDavis', 'emily@example.com', 29);

-- 상품 데이터 삽입 (특정 상품에 주문/리뷰 집중, 특정 카테고리 편향)
INSERT INTO products (product_name, price, category, stock) VALUES
    ('Laptop', 1200.00, 'Electronics', 10),
    ('Smartphone', 800.00, 'Electronics', 20),
    ('T-shirt', 25.00, 'Clothing', 50),
    ('Jeans', 60.00, 'Clothing', 30),
    ('Book', 15.00, 'Books', 100),
    ('Headphones', 150.00, 'Electronics', 15),
    ('Keyboard', 80.00, 'Electronics', 25);

-- 주문 데이터 삽입 (특정 사용자/상품에 주문 집중)
INSERT INTO orders (user_id, product_id, quantity) VALUES
    (1, 1, 1),
    (1, 1, 2),
    (1, 1, 3),
    (1, 2, 1),
    (2, 2, 2),
    (2, 3, 1),
    (3, 4, 1),
    (3, 5, 2),
    (4, 1, 1),
    (4, 2, 2),
    (5, 1, 1),
    (5, 2, 2),
    (6, 1, 1),
    (6, 2, 2);

-- 리뷰 데이터 삽입 (특정 사용자/상품에 리뷰 집중, 특정 평점 편향)
INSERT INTO reviews (user_id, product_id, rating, comment) VALUES
    (1, 1, 5, 'Excellent product!'),
    (1, 1, 5, 'Great!'),
    (1, 1, 5, 'Perfect!'),
    (1, 2, 4, 'Good value for money.'),
    (2, 2, 4, 'Nice!'),
    (2, 3, 3, 'Average quality.'),
    (3, 4, 5, 'Perfect fit!'),
    (3, 5, 4, 'Interesting book.'),
    (4, 1, 5, 'Amazing!'),
    (4, 2, 4, 'Very good.'),
    (5, 1, 5, 'Fantastic!'),
    (5, 2, 4, 'Not bad.'),
    (6, 1, 5, 'Superb!'),
    (6, 2, 4, 'Decent.');