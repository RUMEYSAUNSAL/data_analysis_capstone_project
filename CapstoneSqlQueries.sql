



	
	


	
	--CAPSTONE SQL QUERIES--
 
	--Net Profit:
SELECT SUM((od.unit_price - od.unit_price * od.discount) * od.quantity) AS net_profit
FROM orders as o
JOIN order_details as od ON o.order_id = od.order_id;

--Discount:
SELECT SUM(od.unit_price * od.discount * od.quantity) AS total_discount
FROM orders o
JOIN order_details od ON o.order_id = od.order_id;



--Gross Profit:
SELECT SUM(od.unit_price * od.quantity) AS gross_profit
FROM order_details od;


--Number of Products:
SELECT COUNT(*) AS total_products
FROM products;


--Average Shipping Time:

SELECT AVG(EXTRACT(days FROM (o.shipped_date - o.order_date))) AS avg_shipping_time
FROM orders o;

SELECT AVG(DATE_PART('day', o.shipped_date - o.order_date)) AS avg_shipping_time
FROM orders o;

--Customers Who Paid the Highest Shipping Fees:
SELECT c.customer_id, c.company_name, MAX(o.freight) AS max_freight_paid
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.company_name
ORDER BY max_freight_paid DESC
LIMIT 5;


--Top 5 Customers' Order Quantities:

SELECT c.customer_id, c.company_name, COUNT(*) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.company_name
ORDER BY total_orders DESC
LIMIT 5;


--Geographic Distribution of Customers:

SELECT country, COUNT(*) AS total_customers
FROM customers
GROUP BY country;


--Top/Bottom 5 Products by Orders:

SELECT p.product_name, COUNT(*) AS total_orders
FROM order_details od
JOIN products p ON od.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_orders DESC
LIMIT 5;

--Performance at Category and Product Level:

SELECT c.category_name, p.product_name, SUM(od.unit_price * od.quantity) AS total_revenue
FROM order_details od
JOIN products p ON od.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
GROUP BY c.category_name, p.product_name;

--Units in Stock and Quantity Ordered:

SELECT p.product_name, p.unit_in_stock, SUM(od.quantity) AS total_ordered_quantity
FROM order_details od
JOIN products p ON od.product_id = p.product_id
GROUP BY p.product_name, p.unit_in_stock;


--Total Stock Quantity by Categories:
SELECT c.category_name, SUM(p.unit_in_stock) AS total_stock
FROM products p
JOIN categories c ON p.category_id = c.category_id
GROUP BY c.category_name;


--Top/Bottom 5 Products by Employees:

SELECT e.last_name || ' ' || e.first_name AS employee_name, p.product_name, COUNT(*) AS total_orders
FROM order_details od
JOIN orders o ON od.order_id = o.order_id
JOIN employees e ON o.employee_id = e.employee_id
JOIN products p ON od.product_id = p.product_id
GROUP BY e.last_name, e.first_name, p.product_name
ORDER BY total_orders DESC
LIMIT 5;


--Performance by Employee and Title:

SELECT e.last_name || ' ' || e.first_name AS employee_name, e.title, SUM(od.unit_price * od.quantity) AS total_revenue
FROM order_details od
JOIN orders o ON od.order_id = o.order_id
JOIN employees e ON o.employee_id = e.employee_id
GROUP BY e.last_name, e.first_name, e.title;


--Net Profit by Employee Title:

SELECT e.last_name || ' ' || e.first_name AS employee_name, e.title, SUM((od.unit_price - od.unit_price * od.discount) * od.quantity) AS net_profit
FROM order_details od
JOIN orders o ON od.order_id = o.order_id
JOIN employees e ON o.employee_id = e.employee_id
GROUP BY e.last_name, e.first_name, e.title;


--Net Profit per Order by Employees:

SELECT e.last_name || ' ' || e.first_name AS employee_name, e.title, SUM((od.unit_price - od.unit_price * od.discount) * od.quantity) / COUNT(DISTINCT o.order_id) AS net_profit_per_order
FROM order_details od
JOIN orders o ON od.order_id = o.order_id
JOIN employees e ON o.employee_id = e.employee_id
GROUP BY e.last_name, e.first_name, e.title;


--Orders and Net Profit:

SELECT o.order_id, SUM((od.unit_price - od.unit_price * od.discount) * od.quantity) AS net_profit
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
GROUP BY o.order_id;

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	