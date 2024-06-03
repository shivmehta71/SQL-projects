use restaurant_db;


-- 1.View the Menu_items tabl.

select * from menu_items;

-- 2.Find the number of items on the menu.

select count(*) from menu_items;

-- 3.What are the least and most expensive items on the menu?

select * from menu_items
order by price;

select * from menu_items
order by price desc;


-- 4.How many italian dishes are on the menu?

select count(*) from menu_items
where category="Italian";


-- 5.What are the least and the most expensive Italian dishes on the menu?

select * from menu_items
where category="Italian"
order by price;


select * from menu_items
where category="Italian"
order by price desc;


-- 6.How many dishes are in each category?

select category,count(menu_item_id) as num_dishes
from menu_items
group by category;

-- 7.What is the average dish price within each category?

select category,avg(price) as avg_dish_price
from menu_items
group by category;


--------  ORDERS DETAILS ------------



-- 1. View the order_details table.

select * from order_details;


-- 2. What is the Data Range of the table?

select * from order_details 
order by order_date;

select min(order_date), max(order_date) from order_details;

-- 3. How many orders were made within this date range?

select count(distinct order_id) from order_details;

-- 4. How many items were ordered within this data range?

select count(*) from order_details;


-- 5. Which orders had the most number of items?

select order_id, count(item_id) as num_items
from order_details
group by order_id
order by num_items desc;


-- 6.How many orders had more then 12 items?

select count(*) from 
(select order_id, count(item_id) as num_items
from order_details
group by order_id
having num_items >12) as num_orders;


-------  OBJECTIVE 3 : ANALYSIZE CUSTOMER BEHAVIOUR ---------- 

-- 1. Combine the menu_items and order_details tables into a single table.

select *
from order_details od left join menu_items mi
     on od.item_id=mi.menu_item_id;
     
     
-- 2. What are the least and the most ordered items? What categories were they in? 

select item_name, category,count(order_details_id) as num_purchases
from order_details od left join menu_items mi
     on od.item_id=mi.menu_item_id
group by item_name, category
order by num_purchases;


-- 3. What where the top 5 orders that spent the most money?

select order_id, sum(price) as total_spend
from order_details od left join menu_items mi
     on od.item_id=mi.menu_item_id
group by order_id
order by total_spend desc
limit 5;


-- 4. View the details of the heighest spend order. What insights can you gather from the 

select category, count(item_id) as num_items
from order_details od left join menu_items mi
     on od.item_id=mi.menu_item_id
where order_id = 440
group by category;


-- 5. View the details of the top 5 higest spent orders. What insights can you gather      

select order_id, category, count(item_id) as num_items
from order_details od left join menu_items mi
     on od.item_id=mi.menu_item_id
where order_id in (440, 2075, 1957, 330, 2675)
group by order_id, category;










    
     
     
     
     
     
     
































































