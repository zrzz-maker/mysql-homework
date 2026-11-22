-- ============================================================
-- 六项 SQL 操作
-- 前提：已经跑过 bookshop.sql
--   mysql -u root -p --default-character-set=utf8mb4 bookshop < queries.sql
-- ============================================================

USE bookshop;

-- ---------- 1. INSERT：新增一本书 ----------
-- 用作者的 id 建立关联，第 3 位作者是刘慈欣
INSERT INTO books (title, author_id, price, stock, published_at)
VALUES ('流浪地球', 3, 42.00, 18, '2008-11-01');

-- ---------- 2. SELECT：全部图书，按价格从高到低 ----------
SELECT id, title, price, stock
FROM books
ORDER BY price DESC;

-- ---------- 3. WHERE：只看库存少于 10 本的 ----------
SELECT title, stock
FROM books
WHERE stock < 10
ORDER BY stock;

-- ---------- 4. JOIN：书名 + 作者名（跨两张表） ----------
SELECT b.title  AS 书名,
       a.name   AS 作者,
       b.price  AS 价格
FROM books b
JOIN authors a ON b.author_id = a.id
ORDER BY b.price DESC;

-- ---------- 5. UPDATE：把《三体》的库存改成 25、价格改成 79.00 ----------
UPDATE books
SET stock = 25, price = 79.00
WHERE title = '三体';

-- 改完查一下确认
SELECT title, price, stock FROM books WHERE title = '三体';

-- ---------- 6. DELETE：删掉刚加的那本《流浪地球》 ----------
DELETE FROM books
WHERE title = '流浪地球';

-- 删完确认还剩八本
SELECT COUNT(*) AS 总册数 FROM books;
