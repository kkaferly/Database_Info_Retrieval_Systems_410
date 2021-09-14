-- #1
-- Write a SELECT statement that returns the same result set as this SELECT statement, but don’t use a join. Instead, 
-- use a subquery in a WHERE clause that uses the IN keyword.
-- SELECT DISTINCT category_name
-- FROM categories c 
-- JOIN products p 
-- ON c.category_id = p.category_idORDER 
-- BY category_name

SELECT DISTINCT category_name
	FROM categories c 
	JOIN products p
		ON c.category_id = p.category_id
	ORDER BY category_name;
	
SELECT category_name
	FROM categories c
	WHERE category_id 
		IN(
			SELECT category_id _id 
				FROM products)
	ORDER BY category_name;
	
-- #2
-- Write a SELECT statement that answers this question: Which products have a list price that’s greater than the average 
-- list price for all products? Return the product_name and list_price columns for each product. Sort the resultset by the 
-- list_price columnin descending sequence.


SELECT product_name, list_price
	FROM products p 
	WHERE list_price >
		(SELECT AVG(list_price)
			FROM products p
			WHERE list_price > 0)
	ORDER BY list_price DESC;

-- #3
-- Write a SELECT statement that returns the category_name column from the Categories table. Return one row for each 
-- category that has never been assigned to any product in the Products table. To do that, use a subquery introduced with 
-- the NOT EXISTS operator.

SELECT category_name
	FROM categories c 
	WHERE NOT EXISTS
		(SELECT *
			FROM products p 
			WHERE p.category_id = c.category_id);
		
-- #4
-- Write a SELECT statement that returns three columns: email_address, order_id,and the ordertotal for each customer. To do 
-- this, you can group the result set by the email_address and order_id columns.In addition, you must calculate the order 
-- total from the columns in the Order_Items table.Write a second SELECT statement that uses the first SELECT statement in 
-- its FROM clause. The main query should return two columns: the customer’s email address and the largest orderfor that 
-- customer.To do this, you can group the result set by the email_address.Sort the result set by the largest order in 
-- descending sequence.

SELECT a.email_address, MAX(order_total) AS max_order_total	
	FROM (
		SELECT email_address, oi.order_id, SUM((oi.item_price - oi.discount_amount) * oi.quantity) AS order_total	
			FROM customers c
			INNER JOIN orders o 
				ON c.customer_id = o.customer_id
			INNER JOIN order_items oi 
				ON o.order_id = oi.order_id 
			GROUP BY c.email_address, o.order_id) AS a
	GROUP BY a.email_address
	ORDER BY max_order_total DESC;
		
-- #5
-- Write a SELECT statement that returns the name and discount percent of each product that has a unique discount percent. 
-- In other words, don’t include products that have the same discount percent as another product.Sort the resultsetby the 
-- product_namecolumn.

SELECT p.product_name, p.discount_percent 
	FROM products p
	WHERE p.discount_percent 
		NOT IN(
			SELECT a.discount_percent 
				FROM products a
				WHERE p.product_name <> a.product_name)
	ORDER BY product_name;

-- #6
-- Use a correlated subquery to return one row per customer, representing the customer’s oldest order(the one with the 
-- earliest date). Each row should include these three columns: email_address, order_id, and order_date.Sort the result 
-- set by the order_date and order_id columns.

SELECT c.email_address, o.order_id, o.order_date
	FROM customers c 
	JOIN orders o 
		ON c.customer_id = o.customer_id 
	WHERE o.order_date = (
		SELECT min(a.order_date)
			FROM orders a
			WHERE c.customer_id = a.customer_id);

			
			