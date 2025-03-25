-- 01. 30세 이상 사용자의 이름과 이메일을 조회하세요.
SELECT username, email
FROM users
WHERE age >= 30;
-- 02. 평균 상품 가격보다 비싼 상품의 이름과 가격을 조회하세요.
SELECT product_name, price
FROM products
WHERE price > (SELECT AVG(price) FROM products);
-- 03. JohnDoe 사용자가 주문한 상품의 이름과 수량을 조회하세요.
# SELECT p.product_name as 상품, o.quantity as 수량
# FROM orders o, products p, users u
# WHERE o.product_id = p.product_id AND u.user_id = o.user_id AND u.username = 'JohnDoe';
# SELECT p.product_name as 상품, o.quantity as 수량
# FROM orders o natural join products p natural join users u
# WHERE o.product_id = p.product_id AND u.user_id = o.user_id AND u.username = 'JohnDoe';
# SELECT product_name AS 상품, quantity AS 수량
# FROM products JOIN (SELECT product_id, quantity
#                             FROM users u JOIN orders o
#                                 ON u.user_id = o.user_id
#                             WHERE username = 'JohnDoe') AS t
# ON products.product_id = t.product_id;
SELECT product_name AS 상품, quantity AS 수량
FROM orders JOIN users
ON users.username = 'JohnDoe' AND orders.user_id = users.user_id
JOIN products
ON orders.product_id = products.product_id;
-- 04. 별점 4점 이상인 리뷰의 상품 이름과 리뷰 내용을 조회하세요.
-- 05. 카테고리별 상품 수를 조회하세요.
-- 06. 가장 많이 팔린 상품의 이름과 판매 수량을 조회하세요.
-- 07. 사용자별 총 주문 금액을 조회하세요.
-- 08. 평균 별점이 4점 이상인 상품의 이름과 평균 별점을 조회하세요.
-- 09. 상품별 리뷰 수를 조회하고, 리뷰 수가 2개 이상인 상품만 조회하세요.
-- 10. T-shirt를 구매한 사용자의 이름과 이메일을 조회하세요.