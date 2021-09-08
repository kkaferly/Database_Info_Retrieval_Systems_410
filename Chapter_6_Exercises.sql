-- #1
--Write a SELECT statement that returns these columns:The count of the number of 
--orders in the Orders tableThe sum of the tax_amount columns in the Orders table

SELECT COUNT(order_id), SUM(tax_amount)
	FROM orders;

-- #2
--Write a SELECT statement that returns one row for each category that has products 
--with these columns:The category_namecolumn from the Categories tableThe count of the 
--products in the Products tableThe list price of the most expensive product in the 
--Products tableSort the result set so the category with the most products appears 
--first.

SELECT category_name, COUNT(product_id), MAX(list_price)
	FROM categories c
	JOIN products p 
		ON p.category_id = c.category_id 
	GROUP BY category_name 
	ORDER BY COUNT(p.category_id) DESC;

-- #3
--Write a SELECT statement that returns one row for each customer that has orders with 
--these columns:The email_address column from the Customers tableThe sum of the item 
--price in the Order_Items table multiplied by the quantity in the Order_Items TABLE
--The sum of the discount amount column in the Order_Items table multiplied by the 
--quantity in the Order_Items tableSort the result set in descending sequence by the 
--item price total for each customer.

SELECT 
		c.email_address, 
		(SUM(oi.item_price) * COUNT(oi.item_id)) AS price_quantity, 
		(SUM(oi.discount_amount) * COUNT(oi.item_id)) AS discount_quantity
	FROM customers c 
	JOIN orders o 
		ON c.customer_id = o.customer_id 
	JOIN order_items oi 
		ON oi.order_id = o.order_id 
	GROUP BY c.customer_id 
	ORDER BY SUM(oi.item_price) DESC;

-- #4
--Write a SELECT statement that returns one row for each customer that has orders with 
--these columns:The email_address column from the Customers tableA count of the number 
--of ordersThe total amount for each order(Hint: First, subtract the discount amount 
--from the price. Then, multiply by the quantity.)Return only those rows where the 
--customer has more than 1order.Sort the result set in descending sequence by the sum 
--of the line item amounts.

SELECT 
		c.email_address,
		(COUNT(oi.order_id)) AS num,
		(SUM(oi.item_price - oi.discount_amount) * COUNT(oi.order_id)) AS total
	FROM customers as c 
	INNER JOIN orders o 
		ON c.customer_id = o.customer_id 
	INNER JOIN order_items oi 
		ON oi.order_id = o.order_id 
	GROUP BY c.customer_id 
	HAVING num > 1
	ORDER BY total DESC;

-- #5
--Modify the solution to exercise 4 so it only counts and totals line items that have 
--anitem_pricevalue that’s greater than 400.

SELECT 
		c.email_address,
		(COUNT(oi.order_id)) AS num,
		(SUM(oi.item_price - oi.discount_amount) * COUNT(oi.order_id)) AS total
	FROM customers as c 
	INNER JOIN orders o 
		ON c.customer_id = o.customer_id 
	INNER JOIN order_items oi 
		ON oi.order_id = o.order_id 
	WHERE oi.item_price > 400
	GROUP BY c.customer_id 
	HAVING num > 1
	ORDER BY total DESC;
	
-- #6
--Write a SELECT statement that answers this question: What is the total amount 
--ordered for each product? Return these columns:The product_name column from the 
--Products tableThe total amount for each product in the Order_Items table (Hint: You 
--can calculate the total amount by subtracting the discount amount from the item 
--price and then multiplying it by the quantity)Use the WITH ROLLUP operator to 
--include a row that gives the grand total.

SELECT 
		p.product_name, 
		(SUM(oi.item_price - oi.discount_amount) * COUNT(oi.quantity)) AS tot_per_prod
		FROM products p 
		JOIN order_items oi
			ON p.product_id = oi.product_id
		GROUP BY p.product_name WITH ROLLUP;
		
-- #7
--Write a SELECT statement that answers this question: Which customers have ordered 
--more than one product? Return these columns:The email_address column from the 
--Customers tableThe count of distinct products from the customer’s ordersSort the 
--result set in ascending sequence by the email_address column.	
	
SELECT c.email_address, COUNT(DISTINCT( oi.product_id)) AS dist_prods
	FROM customers c 
	JOIN orders o 
		ON c.customer_id = o.customer_id 
	JOIN order_items oi
		ON oi.order_id = o.order_id 
	GROUP BY c.email_address 
	HAVING dist_prods > 1;