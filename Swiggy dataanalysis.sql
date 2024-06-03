use swiggydata;

select * from swiggy;

-- Q1.HOW MANY RESTAURANTS HAVE A RATING GREATER THAN 4.5?

select count(rating>4.5) from swiggy;

select count(distinct restaurant_name) as high_rated_resturants
from swiggy where rating>4.5;


-- Q2.WHICH IS THE TOP 1 CITY WITH THE HIGHEST NUMBER OF RESTAURANTS?

select * from swiggy;

select city, count(distinct restaurant_name) 
as restaurant_count from swiggy
group by city
order by restaurant_count desc
limit 1;


-- Q3.HOW MANY RESTAURANTS HAVE THE WORD "PIZZA" IN THEIR NAME?

select count(distinct restaurant_name) as pizza_restaurant
from swiggy where 
restaurant_name like "%PIZZA%";


-- Q4.WHAT IS THE MOST COMMON CUISINE AMONG THE RESTAURANTS IN THE DATASET?

select cuisine,count(*) as cuisine_count
from swiggy
group by cuisine
order by cuisine_count desc
limit 1;


-- Q5.WHAT IS THE AVERAGE RATING OF RESTAURANTS IN EACH CITY?

select city, avg(rating) as average_rating
from swiggy group by city;


-- Q6.WHAT IS THE HIGHEST PRICE OF ITEM UNDER THE 'RECOMMENDED' MENUCATEGORY FOR EACH RESTAURANT?

select distinct(restaurant_name),
menu_category,max(price) as highest_price
from swiggy where menu_category='Recommended'
group by restaurant_name;



-- Q7.FIND THE TOP 5 MOST EXPENSIVE RESTAURANTS THAT OFFER CUISINE OTHER THANINDIAN CUISINE.

select distinct restaurant_name, cost_per_person
from swiggy where cuisine <> 'Indian'
order by cost_per_person desc
limit 5;


-- Q8.FIND THE RESTAURANTS THAT HAVE AN AVERAGE COST WHICH IS HIGHER THAN THETOTAL AVERAGE COST OF ALL RESTAURANTS TOGETHER.

select distinct restaurant_name, cost_per_person
from swiggy where cost_per_person > (
select avg(cost_per_person) from swiggy);


-- Q9.RETRIEVE THE DETAILS OF RESTAURANTS THAT HAVE THE SAME NAME BUT ARELOCATED IN DIFFERENT CITIES.

select distinct t1.restaurant_name, t1.city, t2.city
from swiggy t1 join swiggy t2
on t1.restaurant_name =t2.restaurant_name and
t1.city<>t2.city;



-- Q10. WHICH RESTAURANT OFFERS THE MOST NUMBER OF ITEMS IN THE 'MAIN COURSE'CATEGORY?

select distinct restaurant_name,menu_category,
count(item) as no_of_items from swiggy
where menu_category='Main Course' 
group by restaurant_name, menu_category
order by no_of_items desc limit 1;


-- Q11.LIST THE NAMES OF RESTAURANTS THAT ARE 100% VEGEATARIAN INALPHABETICAL ORDER OF RESTAURANT NAME.

select distinct restaurant_name,
(count(case when veg_or_nonveg='Veg' then 1 end)*100/count(*)) as vegeterian_percentage
from swiggy 
group by restaurant_name 
having vegeterian_percentage=100.00
order by restaurant_name;



-- Q12.WHICH IS THE RESTAURANT PROVIDING THE LOWEST AVERAGE PRICE FOR ALL ITEMS?

Select distinct restaurant_name,
avg(price) as average_price
from swiggy group by restaurant_name 
order by average_price desc limit 1;



-- Q13.WHICH TOP 5 RESTAURANT OFFERS HIGHEST NUMBER OF CATEGORIES?

select distinct restaurant_name,
count(distinct menu_category) as no_of_category
from swiggy
group by restaurant_name 
order by no_of_category desc limit 5;



-- Q14.WHICH RESTAURANT PROVIDES THE HIGHEST PERCENTAGE OF NON-VEGEATARIAN FOOD?

select distinct restaurant_name,
(count(case when veg_or_nonveg = 'Non-veg' then 1 end)*100/count(*)) as nonvegeterian_percentage
from swiggy 
group by restaurant_name 
order by nonvegeterian_percentage desc limit 1;












































































































