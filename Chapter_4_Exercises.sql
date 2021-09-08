-- #1
--Write a SELECT statement that joins the Categories table to the Products tableand 
--returns these columns: category_name, product_name, list_price.Sort the result set 
--by the category_name column and then by the product_name column in ascending 
--sequence.

SELECT category_name, product_name, list_price
	FROM products p
	JOIN categories c 
		ON p.category_id = c.category_id 
	ORDER BY category_name ASC, product_name ASC;
	
-- #2
--Write a SELECT statement that joins the Customerstable to the Addresses table and 
--returns these columns:first_name, last_name, line1, city, state, zip_code.Return one 
--row for eachaddress for the customer with an email address of 
--allan.sherwood@yahoo.com.

SELECT first_name, last_name, line1, city, state, zip_code
	FROM addresses a 
	JOIN customers c 	
		ON a.customer_id = c.customer_id 
	AND c.email_address = 'allan.sherwood@yahoo.com';

-- #3
--Write a SELECT statement that joins the Customerstable to the Addressestable and 
--returns these columns: first_name, last_name, line1, city, state, zip_code. Return 
--one row for each customer, but only return addresses that are the shipping address 
--for a customer.

SELECT first_name, last_name, line1, city, state, zip_code
	FROM addresses a 
	JOIN customers c
		ON a.customer_id = c.customer_id 
	AND a.address_id = c.shipping_address_id;

-- #4
--Write a SELECT statement that joins the Customers, Orders, Order_Items, and Products 
--tables. This statement should returnthese columns:last_name, first_name, order_date, 
--product_name, item_price, discount_amount, and quantity.Use aliases for the tables. 
--Sort the final result set by the last_name, order_date, and product_namecolumns.

SELECT 
		last_name, 
		first_name, 
		order_date, 
		product_name, 
		item_price, 
		discount_amount,
		quantity
	FROM customers c, orders o, order_items oi, products p 
	WHERE c.customer_id = o.customer_id
		AND o.order_id = oi.order_id 
		AND oi.product_id = p.product_id
	ORDER BY last_name, order_date, product_name;

-- #5
--Write a SELECT statement that returns the product_name and list_price columns from 
--the Products table.Return one row for each product that has the same list price as 
--another product.Hint: Use a self-jointo check that the product_id columns aren’t 
--equal but the list_price columnsareequal.Sort the result set by the 
--product_namecolumn.

SELECT p1.product_name, p1.list_price
	FROM products p1, products p2
	WHERE p1.list_price = p2.list_price 
		AND p1.product_id != p2.product_id
	ORDER BY product_name;

-- #6
--Write a SELECT statement that returns these two columns: category_nameThe 
--category_namecolumn from the Categories tableproduct_idThe product_id column from 
--the Products tableReturn one row for each category that has never been used. 
--Hint: Use an outer join and only return rows where the product_id column contains a 
--null value.

SELECT c.category_name, p.product_id
	FROM categories c
	LEFT OUTER JOIN products p 
		ON c.category_id = p.category_id
	WHERE p.product_id IS NULL;

-- #7
--Use the UNION operator to generate a result set consisting of three columns from the 
--Orders table: ship_statusA calculated column that contains a value of SHIPPED or NOT 
--SHIPPEDorder_idThe order_idcolumnorder_dateThe order_date columnIf the order has a 
--value in the ship_date column, the ship_status column should contain a value of 
--SHIPPED. Otherwise, it should contain a value of NOT SHIPPED.Sort the final result 
--set by the order_datecolumn.

SELECT 'SHIPPED' ship_status, order_id, order_date
	FROM orders o 
	WHERE ship_date IS NULL
UNION 
SELECT 'NOT SHIPPED' ship_status, order_id, order_date
	FROM orders o 
	WHERE ship_date IS NOT NULL;

	
	