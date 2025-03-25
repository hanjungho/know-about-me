-- 테이블 삭제
# DROP TABLE products;
# DROP TABLE orders;
# DROP TABLE reviews;
# DROP TABLE users;

-- 사용자 테이블 생성
CREATE TABLE users (
                       user_id INT PRIMARY KEY AUTO_INCREMENT,
                       username VARCHAR(255) UNIQUE NOT NULL,
                       email VARCHAR(255) UNIQUE NOT NULL,
                       age INT,
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 칼럼명 변경
# ALTER TABLE users RENAME COLUMN username TO nickname;

-- 데이터 추가
INSERT INTO users (username, email, age) VALUES ('Alice', '123@123.123', 25);
# INSERT INTO users (username, email, age) VALUES ('Bob', '123@123.123', 30);
# 실패해도 user_id(AUTO_INCREMENT) 는 증가
INSERT INTO users (username, email, age) VALUES ('Bob', '456@456.456', 30);

-- 데이터 조회
SELECT * FROM users;

-- 데이터 수정
UPDATE users SET age = 26 WHERE user_id = 1;    # 조건을 적지 않는 경우 모든 행이 수정됨

-- 데이터 삭제
DELETE FROM users WHERE user_id = 2;    # 조건을 적지 않는 경우 모든 행이 삭제됨

-- 상품 테이블 생성
CREATE TABLE products (
                          product_id INT PRIMARY KEY AUTO_INCREMENT,
                          product_name VARCHAR(255) NOT NULL,
                          price DECIMAL(10, 2) NOT NULL,
                          category VARCHAR(255),
                          stock INT DEFAULT 0
);

-- 주문 테이블 생성
CREATE TABLE orders (
                        order_id INT PRIMARY KEY AUTO_INCREMENT,
                        user_id INT,
                        product_id INT,
                        quantity INT,
                        order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                        FOREIGN KEY (user_id) REFERENCES users(user_id),
                        FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 리뷰 테이블 생성
CREATE TABLE reviews (
                         review_id INT PRIMARY KEY AUTO_INCREMENT,
                         user_id INT,
                         product_id INT,
                         rating INT,
                         comment TEXT,
                         created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                         FOREIGN KEY (user_id) REFERENCES users(user_id),
                         FOREIGN KEY (product_id) REFERENCES products(product_id)
);