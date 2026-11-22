# bookshop：两张表 + 六项 SQL 操作

程序部第三次授课的课后任务。用 MySQL 建一个最小的图书库，把「建表 → 插入 → 查询 → 改 → 删」这条链自己走一遍。

## 运行顺序

需要 MySQL 8.0 以上（本机是 MySQL 26.10，兼容）。

**1. 确认 MySQL 在跑**

```bash
mysql -u root -p -e "SELECT VERSION();"
```

**2. 建库、建表、灌数据**

```bash
mysql -u root -p --default-character-set=utf8mb4 < bookshop.sql
```

**3. 执行六项操作**

```bash
mysql -u root -p --default-character-set=utf8mb4 bookshop < queries.sql
```

`-p` 后面会提示输入密码，这里不写死，避免密码进仓库。

## 表结构

```
authors（作者）
  id          主键，自增
  name        姓名
  bio         简介
  created_at  创建时间

books（图书）
  id          主键，自增
  title       书名
  author_id   外键 → authors.id
  price       定价 DECIMAL(8,2)
  stock       库存
  published_at 出版日期
  created_at  创建时间
```

**主键**：`authors.id` 和 `books.id`，一行记录的唯一身份证，自增，不重复。

**外键**：`books.author_id` 指向 `authors.id`。它保证「一本书的作者必须是表里已有的作者」，插入一个不存在的 author_id 会直接报错。这也是为什么 books 里存的是 `author_id = 3`，而不是把「刘慈欣」三个字抄一遍——改名字时只改 authors 一处。

## 六项操作

| 序号 | 操作 | 做什么 |
|---|---|---|
| 1 | INSERT | 新增《流浪地球》 |
| 2 | SELECT + ORDER BY | 全部图书按价格倒序 |
| 3 | WHERE | 查库存少于 10 本的 |
| 4 | JOIN | 书名和作者名跨表拼起来 |
| 5 | UPDATE | 改《三体》的价格和库存 |
| 6 | DELETE | 删掉第 1 步加的那本 |

## 一个验证记录

导入之后执行：

```sql
USE bookshop;
SELECT COUNT(*) FROM authors;   -- 期望 4
SELECT COUNT(*) FROM books;     -- 期望 8
```

实际输出：

```
+----------+
| COUNT(*) |
+----------+
|        4 |
+----------+

+----------+
| COUNT(*) |
+----------+
|        8 |
+----------+
```

再跑一次第 4 项 JOIN，输出（按价格倒序，这是 UPDATE 之前的状态）：

```
书名          作者    价格
三体          刘慈欣  78.00
球状闪电      刘慈欣  45.00
活着          余华    35.00
许三观卖血记  余华    32.00
呐喊          鲁迅    28.00
朝花夕拾      鲁迅    26.50
江村经济      费孝通  26.00
乡土中国      费孝通  22.00
```

跑完 `queries.sql` 之后，《三体》会变成 79.00、库存 25，《流浪地球》被删掉，总数仍是 8 本。

八本书、四位作者，外键关联正常——这就是本次作业的验收结果。

## 文件说明

```
bookshop.sql   建库 + 两张表 + 四位作者 + 八本书
queries.sql    六项 SQL 操作
README.md      本文件
.gitignore     忽略密码、IDE、日志之类的本地文件
```

## 注意

- 仓库里**不放密码**，也不放虚拟环境、`.env`、日志
- 字符集统一 `utf8mb4`，排序规则 `utf8mb4_0900_ai_ci`，中文书名不会乱码
