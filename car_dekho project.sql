create database cars;
use cars;

---- Read Data ----
SELECT * FROM cars.`car dekho`;

-- Q1. Total Cars: To get a count of total records;

select count(*) from cars.`car dekho`;

-- Q2. How many cars will be available in 2023?

select count(*) from cars.`car dekho` where year = 2023;

-- Q3. How many cars will be available in 2020, 2021, 2022?

select count(*) from cars.`car dekho` where year in (2020,2021,2022) group by year;

-- Q4. Client asked me to print the total of all cars by years.

select year,count(*) from cars.`car dekho` group by year;

-- Q5. How many Diesel cars will there be in 2020?

select count(*) from cars.`car dekho` where year = 2020 and fuel = "Diesel";

-- Q6. How many Petrol cars will there be in 2020?

select count(*) from cars.`car dekho` where year = 2020 and fuel = "Petrol";

-- Q7. Print all the fuel cars(Diesel, petrol, CNG) by all year.

select year, count(*) from cars.`car dekho` where fuel = "Petrol" group by year;
select year, count(*) from cars.`car dekho` where fuel = "Dielsel" group by year;
select year, count(*) from cars.`car dekho` where fuel = "CNG" group by year;


-- Q7. Which year has more then 100 cars?

select year, count(*) from cars.`car dekho` group by year having count(*) > 100;

-- Q8. Count all cars details between 2015 and 2023.

select count(*) from cars.`car dekho` where year between 2015 and 2023;

-- Q9. All cars details between 2015 and 2023.

select * from cars.`car dekho` where year between 2015 and 2023;




















































