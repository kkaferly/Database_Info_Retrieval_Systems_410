-- #1
--Write a SELECT statement that returns four columns from the Products table: 
--product_code, product_name, list_price, and discount_percent. Then, run this 
--statement to make sure it works correctly.Add an ORDER BY clause to this statement 
--that sorts the result set by list price in descending sequence. Then, run this 
--statement again to make sure it works correctly. This is a good way to build and 
--test a statement, one clause at a time.

SELECT product_code, product_name, list_price, discount_percent
	FROM products
	ORDER BY list_price DESC;

-- #2
--Write a SELECT statement that returns one column from the Customerstable named 
--full_name that joins the last_name and first_name columns.Format this column with 
--the last name, a comma, a space, and the first name like this:Doe, JohnSort the 
--result set by the last_name column in ascending sequence.Return only the 
--customerswhose last name begins with lettersfrom M to Z.

SELECT CONCAT(last_name, ', ', first_name) AS full_name
	FROM customers c 
	WHERE last_name NOT BETWEEN 'A' AND 'L'
	ORDER BY last_name ASC;

-- #3
--Write a SELECT statement that returns these columnsfrom the Products 
--table:product_nameThe product_namecolumnlist_priceThe list_price 
--columndate_addedThe date_added columnReturn only the rows with a list price 
--that’s greater than 500 and less than 2000.Sort the result set by the date_added 
--columnin descending sequence.

SELECT product_name, list_price, date_added
	FROM products p 
	WHERE list_price > 500 AND list_price < 2000
	ORDER BY date_added DESC;

-- #4
--Write a SELECT statement that returns these column names and data from the Products 
--table:product_nameThe product_name columnlist_priceThe list_price 
--columndiscount_percentThe discount_percent columndiscount_amountA column that’s 
--calculated from the previous two columnsdiscount_priceA column that’s calculated 
--from the previous three columnsRound the discount_amountand discount_price columns 
--to 2 decimal places.Sort the result set bythediscount_price column in descending 
--sequence.Use the LIMIT clause so the result set contains only the first 5 rows.

SELECT 
		product_name, 
		list_price, 
		discount_percent, 
		ROUND((list_price / discount_percent), 2) AS discount_amount, 
		ROUND((list_price - (list_price / discount_percent)), 2) AS discount_price
	FROM products
	ORDER BY discount_price DESC
	LIMIT 5;

-- #5
--Write a SELECT statement that returns these column names and data from the 
--Order_Items table:item_idThe item_id columnitem_priceThe 
--item_pricecolumndiscount_amountThe discount_amount columnquantityThe quantity 
--columnprice_totalA column that’s calculated by multiplying the item price bythe 
--quantitydiscount_totalA column that’s calculated by multiplying the discount amount 
--bythe quantityitem_totalA column that’s calculated by subtracting the discount 
--amount from the item price and then multiplying by the quantityOnly return rows 
--where the item_total is greater than 500.Sort the result set by the item_totalcolumn 
--in descending sequence.

SELECT 
		item_id,
		item_price,
		discount_amount,
		quantity,
		(item_price * quantity) AS price_total,
		(discount_amount * quantity) AS discount_total,
		((item_price - discount_amount) * quantity) AS item_total
	FROM order_items
 	HAVING item_total > 500
	ORDER BY item_total DESC;

-- #6
--Write a SELECT statement that returns these columns from the Orders 
--table:order_idThe order_idcolumnorder_dateThe order_date columnship_date
--The ship_datecolumnReturn only the rows where the ship_datecolumn contains a null 
--value.

SELECT order_id, order_date, ship_date
	FROM orders o 
	WHERE ship_date IS NULL;

-- #7
--Write a SELECT statement without a FROM clause that uses the NOW function to create 
--a row with these columns:today_unformattedThe NOW function 
--unformattedtoday_formattedThe NOW function in this format: DD-Mon-YYYYThis displays 
--a number for the day, an abbreviation for the month, and a four-digit year.

SELECT 
	CURRENT_DATE AS today_unformatted,
	DATE_FORMAT(CURRENT_DATE, '%e-%b-%Y') AS today_formatted;

-- #8
--Write a SELECT statement without a FROM clause that creates a row with these 
--columns:price100(dollars)tax_rate.07(7 percent)tax_amountThe price multiplied by 
--the taxtotalThe price plus the taxTo calculate the fourth column, add the 
--expressions you used for the first and third columns.

SELECT
	('$100.00') AS price,
	CONCAT(.07, '%') AS tax_rate,
	CONCAT('$', (100 * .07)) AS tax_amount,
	CONCAT('$', (100 +(100 * .07))) AS total;

