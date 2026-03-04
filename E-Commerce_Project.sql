use project_placement

select * from payments_table

select * from products_table

select * from sellers_table

select * from Customers_review 

select * from Customers_table 

select * from order_items_table  

select * from orders_table  
select * from payments_table

--How much total money has the platform made so far, and how has it changed over time?

select format(order_delivered_customer_date,'%d-%y-%m'), sum(payment_value) as tol_money  
from orders_table e
inner join payments_table e1
on e.order_id=e1.order_id
group by  order_delivered_customer_date

 
--Which product categories are the most popular, and how do their sales numbers compare?

select * from products_table
select * from order_items_table  

select  product_category_name,count(order_id) as Total_unit, sum(price) as Total_sales
from order_items_table o
join products_table p
on o.product_id=p.product_id
group by product_category_name
order by Total_sales desc

--What is the average amount spent per order, and how does it change depending on payment method?
 
select * from payments_table

select count(order_id) as transaction_count ,avg(payment_value) as avg_order_values
from Payments_table
group by payment_type
order by avg_order_values desc


--How many active sellers are there on the platform, and does this number go up or down over time?

select * from Orders_table
select * from Order_items_table

select month(order_delivered_customer_date) as month,
count(seller_id) as active_sellers from orders_table o
join Order_items_table oi
on o.order_id=oi.order_id
group by month(order_delivered_customer_date)
order by active_sellers desc
  
--Which products sell the most, and how have their sales changed over time?

select * from products_table
select * from Order_items_table

select p.product_category_name,format(shipping_limit_date,'MMMM-yyyy') as sales_month,sum(price) as monthly_sales 
from products_table p
join Order_items_table p1
on p.product_id=p1.product_id
group by p.product_category_name,format(shipping_limit_date,'MMMM-yyyy')
order by  monthly_sales desc

  

--Review VS Sales Correlation do higher rated products sell more?

select * from Customers_review 
select * from Order_items_table

select review_score,
count(distinct o1.order_id) as total_orders,
ROUND(avg(price),2) as avg_product_price
from Customers_review r1
join Order_items_table o1 
on r1.order_id=o1.order_id
group by review_score
order by review_score desc  

-- I can see the higher review rate have the highest total_order and avg_product price is positive 

select eid, name,sum(salary) over (order by sum(salary) desc) as running_salary 
from emp 
group by eid