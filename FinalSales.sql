create database finalDb

use finaldb
------------------------Creating Tables----------------------
CREATE TABLE customers (
    customer_id INT,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);
CREATE TABLE products (
    product_id INT,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price INT
);
CREATE TABLE orders (
    order_id INT,
    order_date DATE,
    customer_id INT,
    product_id INT,
    quantity INT,
    sales_amount INT
);
--------------------------Inserting Data Into Tables-------------------------------------
INSERT INTO customers VALUES
(1, 'Rahul', 'Mumbai'),
(2, 'Ankit', 'Pune'),
(3, 'Neha', 'Delhi'),
(4, 'Amit', 'Thane');

INSERT INTO products VALUES
(101, 'Laptop', 'Electronics', 50000),
(102, 'Mobile', 'Electronics', 20000),
(103, 'Chair', 'Furniture', 3000),
(104, 'Table', 'Furniture', 7000);

INSERT INTO orders VALUES
(1001, '2025-01-05', 1, 101, 1, 50000),
(1002, '2025-01-08', 2, 102, 2, 40000),
(1003, '2025-01-10', 1, 103, 4, 12000),
(1004, '2025-01-15', 3, 101, 1, 50000),
(1005, '2025-01-20', 4, 104, 1, 7000);

------------------Checking The Tables-------------------
Select * from customers
Select * from products
Select * from orders
----------------creating queries------------------------

select o.order_id,
       o.order_date,
       c.customer_name,
       c.city
from orders o
join customers c
on o.customer_id = c.customer_id;

select o.order_id,
       o.order_date,
       c.customer_name,
       p.product_name,
       o.sales_amount
from orders o
join customers c 
     on o.customer_id = c.customer_id
join products p 
     on o.product_id = p.product_id

----------Total Order Counts-----------
select count(*) as total_counts from orders;

----------Total Sale Revenue-----------------
select SUM(sales_amount) as total_revenue from orders

----------Unique Customer Count--------------
select count(Distinct customer_id) as Unique_customers from orders

-----------customer wise total sales-----------
select c.customer_name,
       sum(o.sales_amount) as total_sales 
from orders o
    join customers c 
    on o.customer_id = c.customer_id
    group by c.customer_name

----------product Wise Total Sales--------------
select p.product_name,
       sum(o.sales_amount) as total_sales
    from orders o
    join products p on 
    o.product_id = p.product_id
    group by p.product_name
    order by total_sales desc;

--------------City Wise Sales--------------------
select c.city,
       sum(o.sales_amount) as total_sales
    from orders o
    join customers c on
    o.customer_id = c.customer_id
group by c.city
order by total_sales desc;

--------------top 3 customers---------------------
select top 3
       c.customer_name,
       sum(o.sales_amount) as total_sales 
from orders o
    join customers c 
    on o.customer_id = c.customer_id
    group by c.customer_name
    order by total_sales desc;

-------------top selling products-----------------
select p.product_name,
       sum(o.quantity) as top_selling
    from orders o
    join products p on 
    o.product_id = p.product_id
    group by p.product_name
    order by top_selling desc;

---------------Customer Having More then 1 Order--------------
select c.customer_name,
       count(o.order_id) as order_amount
    from orders o
    join customers c
    on o.customer_id = c.customer_id
    group by c.customer_name
    having count(o.order_id)>1;

----------------------Monthly Sales----------------------------
select  MONTH(order_date) as monthh,
        sum(sales_amount) as total_sales
        from orders
        group by month(order_date)
        order by monthh;

---------Average Sales--------------
Select AVG(sales_amount) as average_sales from orders

------------Electronic Category Sales--------------------
Select p.category,
       sum(o.sales_amount) as sales
       from orders o
       join products p on
       o.product_id=p.product_id
       group by p.category
       having p.category='Electronics'

-----------Orders Count BY city-------------------------
select c.city,
       count(o.order_id) as order_amount
    from orders o
    join customers c
    on o.customer_id = c.customer_id
    group by c.city

------------Customer With Sales Above average-------------
select c.customer_name,
       sum(o.sales_amount) as total_sales 
from orders o
    join customers c 
    on o.customer_id = c.customer_id
    group by c.customer_name
    having sum(o.sales_amount)>(Select AVG(sales_amount) as average_sales from orders)

------------Products with sales higher than Avg Product sales-------------------

SELECT 
    p.product_name,
    SUM(o.sales_amount) AS total_sales
FROM orders o
JOIN products p
ON o.product_id = p.product_id
GROUP BY p.product_name
HAVING SUM(o.sales_amount) >
       (
         SELECT AVG(product_sales)
         FROM (
              SELECT SUM(sales_amount) AS product_sales
              FROM orders
              GROUP BY product_id
         ) t
       );




