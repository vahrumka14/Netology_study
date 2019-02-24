SELECT ('ФИО: Мироненко Елена Борисовна');

-- 1. Создаем четыре таблицы discount, items, sales, shops

DROP TABLE IF EXISTS discount CASCADE;
CREATE TABLE discount
(
DISCOUNT_NAME TEXT,
AMOUNT_DISCOUNT numeric(13,2),
OPER_DATE TIMESTAMP,
DOC_NUMBER bigint,
KEY_DISCOUNT int
);


DROP TABLE IF EXISTS items CASCADE;
CREATE TABLE items
(
ITEM_ARTICLE TEXT,
ITEM_NAME TEXT,
ITEM_CATEGORY TEXT,
ITEM_SUBCATEGORY TEXT,
ITEM_MARK TEXT,
VIEW_ITEM TEXT,
MOD_NO_COLOR TEXT
);


DROP TABLE IF EXISTS sales CASCADE;
CREATE TABLE sales
(
OPER_DATE TIMESTAMP,
CODE_OFFICE TEXT,
TP varchar,
DOC_NUMBER bigint,
ITEM_ARTICLE TEXT,
QTY bigint,
AMOUNT_AUTO_DISCOUNT numeric(13,2),
AMOUNT_RUR numeric(13,2),
PAYMENT_FORM TEXT,
KEY_DISCOUNT int
);


DROP TABLE IF EXISTS shops CASCADE;
CREATE TABLE shops
(
MARKET_CODE TEXT,
SHOP TEXT,
CODE_POINTS_SALE TEXT,
CODE_OFFICE TEXT,
SHEDULE_NAME TEXT,
TIME_ZONE TEXT
);

-- 2. Загружаем в созданные таблицы данные в формате .csv

psql -U postgres -c \
    "\\copy discount FROM '/home/lena/Netology/SQL/data/discount1.csv' DELIMITER ';' CSV HEADER"

psql -U postgres -c \
    "\\copy items FROM '/home/lena/Netology/SQL/data/items.csv' DELIMITER ';' CSV HEADER"

psql -U postgres -c \
    "\\copy sales FROM '/home/lena/Netology/SQL/data/sales333.csv' DELIMITER ';' CSV HEADER"

psql -U postgres -c \
    "\\copy shops FROM '/home/lena/Netology/SQL/data/shops.csv' DELIMITER ';' CSV HEADER"



