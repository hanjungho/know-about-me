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
SELECT product_name, comment
FROM products join (SELECT product_id, comment
FROM reviews
WHERE rating >= 4) AS t
using (product_id);
-- 05. 카테고리별 상품 수를 조회하세요.
SELECT category, COUNT(*) AS 상품수
FROM products
GROUP BY category;
-- 06. 가장 많이 팔린 상품의 이름과 판매 수량을 조회하세요.
# 가장 많이 팔린 상품이 두 개 이상일 경우에도 하나만 나오므로 틀린 답안
# SELECT product_name, 판매수량
# FROM products JOIN (SELECT product_id, SUM(quantity) AS 판매수량
# FROM orders
# GROUP BY product_id
# ORDER BY 판매수량 DESC LIMIT 1) AS t USING (product_id);
# 가장 많이 팔린 상품이 두 개 이상일 경우 두 개 이상 출력
SELECT p.product_name, SUM(o.quantity) AS 판매수량
FROM orders o
         JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_id, p.product_name
HAVING SUM(o.quantity) = (
    SELECT MAX(판매수량)
    FROM (
             SELECT SUM(quantity) AS 판매수량
             FROM orders
             GROUP BY product_id
         ) AS t
);
-- 07. 사용자별 총 주문 금액을 조회하세요.
SELECT username, SUM(주문가격)
FROM users join (SELECT user_id, quantity * price AS 주문가격
FROM products join (SELECT user_id, product_id, quantity
FROM orders) AS t USING (product_id)) AS p USING (user_id)
GROUP BY user_id;
-- 08. 평균 별점이 4점 이상인 상품의 이름과 평균 별점을 조회하세요.
# SELECT product_name AS 상품이름, 평균별점
# FROM products JOIN (SELECT AVG(rating) AS 평균별점, product_id
# FROM reviews JOIN (SELECT product_id
# FROM reviews
# GROUP BY product_id
# HAVING AVG(rating) >= 4) AS t USING (product_id)
# GROUP BY product_id) AS b USING (product_id);
SELECT
    p.product_name AS 상품이름,
    AVG(r.rating) AS 평균별점
FROM
    products p
        JOIN
    reviews r ON p.product_id = r.product_id
GROUP BY
    p.product_id
HAVING
    AVG(r.rating) >= 4;
-- 09. 상품별 리뷰 수를 조회하고, 리뷰 수가 2개 이상인 상품만 조회하세요.
SELECT product_name AS 상품명, COUNT(*) AS 리뷰수
FROM reviews JOIN products USING (product_id)
GROUP BY product_id;
SELECT product_name AS 상품명, COUNT(*) AS 리뷰수
FROM reviews JOIN products USING (product_id)
GROUP BY product_id
HAVING COUNT(*) >= 2;
-- 10. T-shirt를 구매한 사용자의 이름과 이메일을 조회하세요.
SELECT username, email
FROM orders JOIN (SELECT product_id
FROM products
WHERE product_name = 'T-shirt') AS t USING (product_id) JOIN users USING (user_id);