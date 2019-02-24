SELECT ('ФИО: Мироненко Елена Борисовна');

-- 1. Вывести топ-5 самых продаваемых марок телефонов

select ITEM_MARK, Sum(AMOUNT_RUR) as sum_amount_rur
from
(Select s.ITEM_ARTICLE, i.ITEM_CATEGORY, i.ITEM_MARK, s.AMOUNT_RUR
from sales as s
inner join items as i
on s.ITEM_ARTICLE = i.ITEM_ARTICLE
where i.ITEM_CATEGORY = 'Phones') as a
group by ITEM_MARK
order by sum_amount_rur desc
limit 5;

-- 2. Вывести все категории товаров от Apple

select distinct item_category
from items
where item_mark = 'Apple';


-- 3. Вывести топ-5 офисов, которые генерят наибольшие продажи

select s.CODE_OFFICE, SHOP, sum(s.AMOUNT_RUR) as sum_amount_rur
from sales as s
inner join shops as sh
on s.CODE_OFFICE = sh.CODE_OFFICE
group by s.CODE_OFFICE, SHOP
order by sum_amount_rur desc
limit 5;


-- 4. Вывести выручку, продажи и среднюю цену по планшетам по каждому офису

select s.CODE_OFFICE, SHOP, sum(s.AMOUNT_RUR) as sum_amount_rur, sum(QTY) as sales_qty,
case 
when sum(s.AMOUNT_RUR) <= 0 or sum(QTY) <= 0 then '0'
else sum(s.AMOUNT_RUR)/sum(QTY)
end as avg_price
from sales as s
inner join shops as sh
on s.CODE_OFFICE = sh.CODE_OFFICE
inner join items as i
on s.ITEM_ARTICLE = i.ITEM_ARTICLE
where i.ITEM_CATEGORY = 'Tablets'
group by s.CODE_OFFICE, SHOP
order by avg_price desc
limit 30;

-- 5. Вывести первую продажу по каждому чеку

select d.*
from
(
Select s.*, row_number() over (partition by doc_number order by oper_date asc)  as num
from sales as s
) as d
where d.num = 1
limit 30;


-- 6. Вывести самые популярные маркетинговые акции за июль 2017 года

select discount_name, sum(amount_discount) as sum_amount_discount
from
(
select *, cast(oper_date as date) as oper_date1
from discount
where cast(oper_date as date) between '2017-07-01' and '2017-07-31'
order by oper_date1 asc
) as d
group by discount_name
order by sum_amount_discount desc
limit 30;

-- 7. Вывести долю каждого товара в чеке

select *, (AMOUNT_RUR/sum (AMOUNT_RUR) over (partition by doc_number))*100 as share
from sales 
limit 30;

-- 8. Вывести чеки, у которых более двух позиций - это аксессуары

select distinct doc_number 
from
(
select s.*, row_number () over (partition by doc_number order by oper_date asc) as num
from sales as s
inner join items as i
on s.ITEM_ARTICLE = i.ITEM_ARTICLE
where item_category = 'Accessories'
) as d
where num > 2
limit 30;

-- 9. Определить какая форма оплаты была предпочтительнее за июль 2017 года

select payment_form, sum(amount_rur) as sum_amount_rur
from sales
where cast(oper_date as date) between '2017-07-01' and '2017-07-31'
group by payment_form
order by sum_amount_rur desc
limit 1;


-- 10. Вывести самый дорогой товар в каждом филиале

select *
from
(
select sh.market_code, s.ITEM_ARTICLE, ITEM_NAME, ITEM_MARK, ITEM_CATEGORY, amount_rur, 
case 
when qty = 0 then '0'
else MAX(amount_rur/qty) OVER (PARTITION BY market_code)
end as max_amount_rur
from sales as s
inner join shops as sh
on s.code_office = sh.code_office
inner join items as i
on s.ITEM_ARTICLE = i.ITEM_ARTICLE
where item_category <> 'Услуга'
) as d
where amount_rur = max_amount_rur
limit 30;


 
