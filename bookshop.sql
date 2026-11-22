-- ============================================================
-- 程序部第三次授课 · 课后任务
-- bookshop 图书库：两张表 + 四位作者 + 八本书
--
-- 运行顺序：先跑本文件，再跑 queries.sql
--   mysql -u root -p --default-character-set=utf8mb4 < bookshop.sql
-- ============================================================

DROP DATABASE IF EXISTS bookshop;
CREATE DATABASE bookshop
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_0900_ai_ci;

USE bookshop;

-- ---------- 表一：作者 ----------
CREATE TABLE authors (
    id         INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name       VARCHAR(100) NOT NULL,
    bio        VARCHAR(255),
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------- 表二：图书 ----------
-- author_id 是指向 authors.id 的外键，一本书只归一位作者
CREATE TABLE books (
    id           INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title        VARCHAR(100) NOT NULL,
    author_id    INT UNSIGNED NOT NULL,
    price        DECIMAL(8,2) NOT NULL DEFAULT 0.00,
    stock        INT UNSIGNED NOT NULL DEFAULT 0,
    published_at DATE,
    created_at   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_books_author FOREIGN KEY (author_id) REFERENCES authors(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------- 四位作者 ----------
INSERT INTO authors (name, bio) VALUES
('鲁迅',   '中国现代文学奠基人'),
('余华',   '当代作家，代表作《活着》'),
('刘慈欣', '科幻作家，《三体》作者'),
('费孝通', '社会学家，《乡土中国》');

-- ---------- 八本书 ----------
INSERT INTO books (title, author_id, price, stock, published_at) VALUES
('呐喊',         1, 28.00, 12, '1923-08-01'),
('朝花夕拾',     1, 26.50,  8, '1928-09-01'),
('活着',         2, 35.00, 20, '1993-01-01'),
('许三观卖血记', 2, 32.00, 15, '1995-01-01'),
('三体',         3, 78.00, 30, '2008-01-01'),
('球状闪电',     3, 45.00,  6, '2004-05-01'),
('乡土中国',     4, 22.00, 25, '1948-01-01'),
('江村经济',     4, 26.00,  9, '1939-01-01');
